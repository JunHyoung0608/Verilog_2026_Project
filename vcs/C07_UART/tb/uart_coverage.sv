`ifndef COVERAGE_SV
`define COVERAGE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "uart_ram_seq_item.sv"

class uart_coverage extends uvm_subscriber #(uart_seq_item);
    `uvm_component_utils(uart_coverage);

    uart_seq_item tx;

    covergroup uart_cg;

    endgroup

    function new(string name = "COV", uvm_component c);
        super.new(name, c);
        uart_cg = new();
    endfunction  //new()

    virtual function void write(uart_seq_item t);
        tx = t;
        uart_cg.sample();
        `uvm_info(get_type_name(), $sformatf("counter_cg sampled: %s", tx.convert2string()),
                  UVM_MEDIUM);
    endfunction

    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf(
                  "\
        \n===== Coverage Summary =====\
        \n  addr            : %.1f%%\
        \n  rw              : %.1f%%\
        \n  wdata           : %.1f%%\
        \n  rdata           : %.1f%%\
        \n  cross(addr, rw) : %.1f%%\
        \n============================",
                  uart_cg.cp_addr.get_coverage(),
                  uart_cg.cp_rw.get_coverage(),
                  uart_cg.cp_wdata.get_coverage(),
                  uart_cg.cp_rdata.get_coverage(),
                  uart_cg.cx_addr_rw.get_coverage()
                  ), UVM_LOW);
    endfunction
endclass  

`endif
