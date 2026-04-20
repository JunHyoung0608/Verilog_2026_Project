`ifndef MONITOR_SV
`define MONITOR_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;


class I2C_monitor extends uvm_monitor;
    `uvm_component_utils(I2C_monitor);

    virtual I2C_if vif;

    uvm_analysis_port #(I2C_seq_item) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("ap", this);
        if (!uvm_config_db#(virtual I2C_if)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "monitor에서 uvm_config_db 에러 발생");
    endfunction

    virtual task run_phase(uvm_phase phase);
        @(vif.mon_cb);
        `uvm_info(get_type_name(), "I2C 버스 모니터링 시작 ...", UVM_MEDIUM)
        forever begin
            collect_transaction();
        end
    endtask

    task collect_transaction();
        I2C_seq_item tr;
        tr = I2C_seq_item::type_id::create("mon_tr");

        //START
        @(vif.mon_cb);
        wait (vif.mon_cb.cmd_start);
        `uvm_info(get_type_name(), $sformatf("start..."), UVM_MEDIUM)
        //ADDR
        wait (vif.mon_cb.cmd_write);
        tr.addr      = vif.mon_cb.m_tx_data[7:1];
        tr.m_is_read = vif.mon_cb.m_tx_data[0];
        @(vif.mon_cb);
        wait (vif.mon_cb.m_done);
        

        @(vif.mon_cb);
        `uvm_info(get_type_name(), $sformatf("addr...%02h", tr.addr), UVM_MEDIUM)

        //R/W
        wait (vif.mon_cb.m_done);

        @(vif.mon_cb);
        if (tr.m_is_read) begin
            // Read 완료 대기
            wait (vif.mon_cb.m_done);
            wait (vif.mon_cb.m_done);
            @(vif.mon_cb);
            tr.m_tx_data = vif.mon_cb.m_tx_data;
            tr.m_rx_data = vif.mon_cb.m_rx_data;

            tr.s_tx_data = vif.mon_cb.s_tx_data;
            tr.s_rx_data = vif.mon_cb.s_rx_data;
        end else begin
            // Write 완료 대기
            wait (vif.mon_cb.m_done);
            wait (vif.mon_cb.m_done);
            @(vif.mon_cb);
            tr.m_tx_data = vif.mon_cb.m_tx_data;
            tr.m_rx_data = vif.mon_cb.m_rx_data;

            tr.s_tx_data = vif.mon_cb.s_tx_data;
            tr.s_rx_data = vif.mon_cb.s_rx_data;
        end
        `uvm_info(get_type_name(), $sformatf("샘플링 완료: %s", tr.convert2string()),
                  UVM_MEDIUM)
        ap.write(tr);

    endtask

endclass  //component extends uvm_componet


`endif
