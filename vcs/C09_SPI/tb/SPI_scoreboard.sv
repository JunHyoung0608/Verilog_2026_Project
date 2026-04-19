`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "SPI_seq_item.sv"

class SPI_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(SPI_scoreboard);

    uvm_analysis_imp #(SPI_seq_item, SPI_scoreboard) ap_imp;

    logic [31:0] ref_mem[0:2**6-1];

    int test_cnt = 0;
    int mosi_errors = 0;
    int miso_errors = 0;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_imp = new("ap_imp", this);
    endfunction

    virtual function void write(SPI_seq_item tx);
        test_cnt++;
        //miso
        if (tx.m_tx_data !== tx.s_slv_rx_data) begin
            mosi_errors++;
            `uvm_error(get_type_name(), $sformatf(
                       "FAIL!  m_tx_data=0x%02h -> s_rx_data=0x%02h", tx.m_tx_data, tx.s_slv_rx_data
                       ));
        end else begin
            `uvm_info(get_type_name(), $sformatf(
                      "PASS!  m_tx_data=0x%02h -> s_rx_data=0x%02h", tx.m_tx_data, tx.s_slv_rx_data
                      ), UVM_MEDIUM);
        end
        //mosi
        if (tx.s_slv_tx_data !== tx.m_rx_data) begin
            miso_errors++;
            `uvm_error(get_type_name(), $sformatf(
                       "FAIL!  s_tx_data=0x%02h -> m_rx_data=0x%02h", tx.s_slv_tx_data, tx.m_rx_data
                       ));
        end else begin
            `uvm_info(get_type_name(), $sformatf(
                      "PASS!  s_tx_data=0x%02h -> m_rx_data=0x%02h", tx.s_slv_tx_data, tx.m_rx_data
                      ), UVM_MEDIUM);
        end

    endfunction

    virtual function void report_phase(uvm_phase phase);
        string result = ((mosi_errors + miso_errors) == 0) ? "** PASS **" : "** FAIL **";

        super.report_phase(phase);
        `uvm_info(get_type_name(), $sformatf("\
        \n===== Summary Report =========\
        \n  Result      : %s\
        \n  test_cnt    : %0d\
        \n  mosi_errors : %0d\
        \n  miso_errors : %0d\
        \n==============================", result, test_cnt, mosi_errors, miso_errors), UVM_LOW);
    endfunction

endclass  //component extends uvm_componet


`endif
