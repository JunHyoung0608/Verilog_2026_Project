`ifndef COVERAGE_SV
`define COVERAGE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "SPI_seq_item.sv"

class SPI_coverage extends uvm_subscriber #(SPI_seq_item);
    `uvm_component_utils(SPI_coverage);

    SPI_seq_item tx;

    covergroup SPI_cg;
        cp_m_tx_data: coverpoint tx.m_tx_data {
            bins all_zeros = {32'h0000_0000};
            bins all_ones = {32'hffff_ffff};
            bins all_a = {32'haaaa_aaaa};
            bins all_5 = {32'h5555_5555};
            bins other = default;
        }
        cp_s_tx_data: coverpoint tx.s_slv_tx_data {
            bins all_zeros = {32'h0000_0000};
            bins all_ones = {32'hffff_ffff};
            bins all_a = {32'haaaa_aaaa};
            bins all_5 = {32'h5555_5555};
            bins other = default;
        }
    endgroup

    function new(string name = "COV", uvm_component c);
        super.new(name, c);
        SPI_cg = new();
    endfunction  //new()

    virtual function void write(SPI_seq_item t);
        tx = t;
        SPI_cg.sample();
        `uvm_info(get_type_name(), $sformatf("counter_cg sampled: %s", tx.convert2string()),
                  UVM_MEDIUM);
    endfunction

    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf(
                  "\
        \n===== Coverage Summary =====\
        \n  cp_m_tx_data    : %.1f%%\
        \n  cp_s_tx_data    : %.1f%%\
        \n============================",
                  SPI_cg.cp_m_tx_data.get_coverage(),
                  SPI_cg.cp_s_tx_data.get_coverage()
                  ), UVM_LOW);
    endfunction
endclass

`endif
