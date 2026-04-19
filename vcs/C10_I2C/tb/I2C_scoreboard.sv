`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
// `include "I2C_ram_seq_item.sv"

class I2C_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(I2C_scoreboard);

    uvm_analysis_imp #(I2C_seq_item, I2C_scoreboard) ap_imp;

    int addr_fail_cnt = 0;
    int is_writes_cnt = 0;
    int is_reads_cnt = 0;
    int write_errors_cnt = 0;
    int read_errors_cnt = 0;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_imp = new("ap_imp", this);
    endfunction

    virtual function void write(I2C_seq_item tr);
        if (tr.addr != 7'h12) begin
            addr_fail_cnt++;
            `uvm_error(get_type_name(), $sformatf("FAIL ADDR! paddr = 0x%02h, ", tr.addr));
        end else begin
            //IS_READ
            if (tr.m_is_read) begin
                is_reads_cnt++;
                if (tr.m_rx_data !== tr.s_tx_data) begin
                    read_errors_cnt++;
                    `uvm_error(get_type_name(), $sformatf(
                               "FAIL! paddr = 0x%02h, exptected=0x%08h -x> m_rx_data=0x%08h",
                               tr.addr,
                               tr.s_tx_data,
                               tr.m_rx_data
                               ));
                end else begin
                    `uvm_info(get_type_name(), $sformatf(
                              "PASS! paddr = 0x%02h, exptected=0x%08h -> m_rx_data=0x%08h",
                              tr.addr,
                              tr.s_tx_data,
                              tr.m_rx_data
                              ), UVM_MEDIUM);
                end
                //IS_WRITE
            end else begin
                is_writes_cnt++;
                if (tr.m_tx_data !== tr.s_rx_data) begin
                    write_errors_cnt++;
                    `uvm_error(get_type_name(), $sformatf(
                               "FAIL! paddr = 0x%02h, m_tx_data=0x%08h -x> s_rx_data=0x%08h",
                               tr.addr,
                               tr.m_tx_data,
                               tr.s_rx_data
                               ));
                end else begin
                    `uvm_info(get_type_name(), $sformatf(
                              "PASS! paddr = 0x%02h, m_tx_data=0x%08h -> s_rx_data=0x%08h",
                              tr.addr,
                              tr.m_tx_data,
                              tr.s_rx_data
                              ), UVM_MEDIUM);
                end
            end
        end
    endfunction

    virtual function void report_phase(uvm_phase phase);
        string result = ((read_errors_cnt == 0) && (write_errors_cnt == 0)) ? "** PASS **" : "** FAIL **";

        super.report_phase(phase);
        `uvm_info(get_type_name(), $sformatf(
                  "\
        \n===== Summary Report =========\
        \n  - Result          : [%s]\
        \n  - addr_fail_cnt   : %0d\
        \n  - is_writes_cnt   : %0d\
        \n  - is_reads_cnt    : %0d\
        \n  - write_errors_cnt: %0d\
        \n  - read_errors_cnt : %0d\
        \n==============================",
                  result,
                  addr_fail_cnt,
                  is_writes_cnt,
                  is_reads_cnt,
                  write_errors_cnt,
                  read_errors_cnt
                  ), UVM_LOW);
    endfunction

endclass  //component extends uvm_componet


`endif
