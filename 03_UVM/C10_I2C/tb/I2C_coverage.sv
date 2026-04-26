`ifndef COVERAGE_SV
`define COVERAGE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
// `include "I2C_ram_seq_item.sv"

class I2C_coverage extends uvm_subscriber #(I2C_seq_item);
    `uvm_component_utils(I2C_coverage);

    I2C_seq_item tx;

    covergroup I2C_cg;
        cp_m_tx_data: coverpoint tx.m_tx_data {
            bins special_55 = {8'h55};  // 01010101 확인
            bins special_aa = {8'hAA};  // 10101010 확인
            bins all_ones = {8'hFF};  // Pull-up 확인용
            bins all_zeros = {8'h00};
            bins range_0 = {[8'h01 : 8'h54], [8'h56 : 8'hA9], [8'hAB : 8'hFE]};  // 나머지
        }
        cp_s_tx_data: coverpoint tx.s_tx_data {
            bins special_55 = {8'h55};  // 01010101 확인
            bins special_aa = {8'hAA};  // 10101010 확인
            bins all_ones = {8'hFF};  // Pull-up 확인용
            bins all_zeros = {8'h00};
            bins range_0 = {[8'h01 : 8'h54], [8'h56 : 8'hA9], [8'hAB : 8'hFE]};  // 나머지
        }
        cp_rw: coverpoint tx.m_is_read {bins write_op = {1}; bins read_op = {0};}

    endgroup

    function new(string name = "COV", uvm_component c);
        super.new(name, c);
        I2C_cg = new();
    endfunction  //new()

    virtual function void write(I2C_seq_item t);
        tx = t;
        I2C_cg.sample();
        `uvm_info(get_type_name(), $sformatf("counter_cg sampled: %s", tx.convert2string()),
                  UVM_MEDIUM);
    endfunction

    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf(
                  "\
        \n===== Coverage Summary =====\
        \n  - m_tx_data         : %.1f%%\
        \n  - s_tx_data         : %.1f%%\
        \n  - cp_rw             : %.1f%%\
        \n============================",
                  I2C_cg.cp_m_tx_data.get_coverage(),
                  I2C_cg.cp_s_tx_data.get_coverage(),
                  I2C_cg.cp_rw.get_coverage()
                  ), UVM_LOW);
    endfunction
endclass

`endif
