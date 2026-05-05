`ifndef MONITOR_SV
`define MONITOR_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
// `include "ram_interface.sv"
`include "AXI_SPI_seq_item.sv"


class AXI_SPI_monitor extends uvm_monitor;
    `uvm_component_utils(AXI_SPI_monitor);

    virtual AXI_SPI_if vif;

    uvm_analysis_port #(AXI_SPI_seq_item) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("ap", this);
        if (!uvm_config_db#(virtual AXI_SPI_if)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "monitor에서 uvm_config_db 에러 발생");
    endfunction

    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "AXI_SPI 버스 모니터링 시작 ...", UVM_MEDIUM)

        forever begin
            collect_transaction();
        end
    endtask

    task collect_transaction();
        AXI_SPI_seq_item tx;

        tx = AXI_SPI_seq_item::type_id::create("mon_tx");

        //STEP1에서 tx_data들 모니터링
        wait (vif.mon_cb.axi_wvalid && vif.mon_cb.axi_wready);
        @(vif.mon_cb);
        tx.axi_wdata = vif.mon_cb.axi_wdata;
        tx.slv_tx_data = vif.mon_cb.slv_tx_data;

        //STEP4에서  mosi 읽기
        wait (vif.mon_cb.axi_rvalid && vif.mon_cb.axi_rready);
        @(vif.mon_cb);

        tx.slv_rx_data = vif.mon_cb.slv_rx_data;
        tx.axi_rdata   = vif.mon_cb.axi_rdata;

        `uvm_info(get_type_name(), $sformatf("mon end tx: %s", tx.convert2string()), UVM_MEDIUM);

        ap.write(tx);
    endtask

endclass  //component extends uvm_componet


`endif
