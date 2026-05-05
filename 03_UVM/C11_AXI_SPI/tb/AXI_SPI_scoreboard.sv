`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "AXI_SPI_seq_item.sv"

class AXI_SPI_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(AXI_SPI_scoreboard);

    uvm_analysis_imp #(AXI_SPI_seq_item, AXI_SPI_scoreboard) ap_imp;

    logic [31:0] ref_mem[0:2**6-1];

    int num_test = 0;
    int num_writes_errors = 0;
    int num_reads_errors = 0;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_imp = new("ap_imp", this);
    endfunction

    virtual function void write(AXI_SPI_seq_item tx);
        num_test++;

        if (tx.axi_wdata[7:0] != tx.slv_rx_data) begin
            num_writes_errors++;
            `uvm_error(
                get_type_name(), $sformatf(
                "FAIL! axi_wdata = 0x%02h, slv_rx_data=0x%02h", tx.axi_wdata[7:0], tx.slv_rx_data));
        end else begin
            `uvm_info(
                get_type_name(), $sformatf(
                "PASS! axi_wdata = 0x%02h, slv_rx_data=0x%02h", tx.axi_wdata[7:0], tx.slv_rx_data),
                UVM_MEDIUM);
        end
        if (tx.slv_tx_data != tx.axi_rdata[7:0]) begin
            num_reads_errors++;
            `uvm_error(
                get_type_name(), $sformatf(
                "FAIL! slv_tx_data = 0x%02h, axi_rdata=0x%02h", tx.slv_tx_data, tx.axi_rdata[7:0]));
        end else begin
            `uvm_info(
                get_type_name(), $sformatf(
                "PASS! slv_tx_data = 0x%02h, axi_rdata=0x%02h", tx.slv_tx_data, tx.axi_rdata[7:0]),
                UVM_MEDIUM);
        end

    endfunction

    virtual function void report_phase(uvm_phase phase);
        string result = ((num_writes_errors + num_reads_errors) == 0) ? "** PASS **" : "** FAIL **";

        super.report_phase(phase);
        `uvm_info(get_type_name(), $sformatf("\
        \n===== Summary Report =========\
        \n  Result          : %s\
        \n  test            : %0d\
        \n  writes_errors   : %0d\
        \n  reads_errors    : %0d\
        \n==============================", result, num_test, num_writes_errors, num_reads_errors),
                  UVM_LOW);
    endfunction

endclass  //component extends uvm_componet


`endif
