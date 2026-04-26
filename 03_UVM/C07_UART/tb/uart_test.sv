`ifndef TEST_SV
`define TEST_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

class uart_base_test extends uvm_test;
    `uvm_component_utils(uart_base_test);

    apb_env env;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = apb_env::type_id::create("env", this);
    endfunction

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        `uvm_info(get_type_name(), "===== UVM 계층 구조 =====", UVM_MEDIUM)
        uvm_top.print_topology();
    endfunction


    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        run_test_seq();
        phase.drop_objection(this);
    endtask

    virtual task run_test_seq();
        // 자식 클래스에서 해당 기능 구현
    endtask

endclass

class uart_tx_test extends uart_base_test;
    `uvm_component_utils(uart_tx_test);

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual task run_test_seq();
        uart_tx_seq seq;
        seq = uart_tx_seq::type_id::create("seq");
        seq.start(env.agt.sqr);
    endtask

endclass

class uart_rx_test extends uart_base_test;
    `uvm_component_utils(uart_rx_test);

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual task run_test_seq();
        uart_rx_seq seq;
        seq = uart_rx_seq::type_id::create("seq");
        seq.start(env.agt.sqr);
    endtask

endclass



`endif
