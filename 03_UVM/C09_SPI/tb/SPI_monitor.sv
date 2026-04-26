`ifndef MONITOR_SV
`define MONITOR_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
// `include "interface.sv"
`include "SPI_seq_item.sv"


class SPI_monitor extends uvm_monitor;
    `uvm_component_utils(SPI_monitor);

    virtual SPI_if vif;

    uvm_analysis_port #(SPI_seq_item) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("ap", this);
        if (!uvm_config_db#(virtual SPI_if)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "monitor에서 uvm_config_db 에러 발생");
    endfunction

    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "SPI 버스 모니터링 시작 ...", UVM_MEDIUM)

        forever begin
            collect_transaction();
        end
    endtask

    task collect_transaction();
        SPI_seq_item tx;
        tx               = SPI_seq_item::type_id::create("mon_tx");

        wait (vif.mon_cb.m_start);
        @(vif.mon_cb);
        tx.m_tx_data     = vif.mon_cb.m_tx_data;
        tx.s_slv_tx_data = vif.mon_cb.s_slv_tx_data;
        wait (vif.mon_cb.m_done);
        @(vif.mon_cb);

        tx.m_cpol        = vif.mon_cb.m_cpol;
        tx.m_cpha        = vif.mon_cb.m_cpha;
        tx.m_clk_div     = vif.mon_cb.m_clk_div;
        
        tx.m_start       = vif.mon_cb.m_start;
        tx.m_rx_data     = vif.mon_cb.m_rx_data;
        tx.m_done        = vif.mon_cb.m_done;
        tx.m_busy        = vif.mon_cb.m_busy;
        
        tx.s_slv_rx_data = vif.mon_cb.s_slv_rx_data;
        tx.s_done        = vif.mon_cb.s_done;
        `uvm_info(get_type_name(), $sformatf("모니터 전송: %s", tx.convert2string()),
                  UVM_MEDIUM);
        ap.write(tx);
        @(vif.mon_cb);
    endtask

endclass  //component extends uvm_componet


`endif
