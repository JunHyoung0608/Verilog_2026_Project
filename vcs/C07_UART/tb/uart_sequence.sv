`ifndef SEQUENCE_SV
`define SEQUENCE_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "uart_seq_item.sv"

class uart_base_seq extends uvm_sequence #(uart_seq_item);
    `uvm_object_utils(uart_base_seq);
    int num_loop = 0;

    function new(string name = "uart_base_seq");
        super.new(name);
    endfunction  //new()

    task gen_data(bit [7:0] data, bit dif_mode);
        string pf = (dif_mode) ? "TX" : "RX";
        uart_seq_item item;
        item = uart_seq_item::type_id::create("item");
        start_item(item);
        if (!item.randomize() with {
                mode == dif_mode;
            })
            `uvm_fatal(get_type_name(), "gen_data() Ramdomization Fail!")

        `uvm_info(get_type_name(), $sformatf("gen_data()[%s] 전송 완료: rand_data=0x%02h", pf,
                                             item.rand_data), UVM_MEDIUM)
        finish_item(item);
    endtask


    virtual task body();
    endtask

endclass

class uart_tx_seq extends uart_base_seq;
    `uvm_object_utils(uart_tx_seq);
    int num_loop = 0;
    bit [7:0] addr;
    bit [31:0] wdata, rdata;

    function new(string name = "uart_tx_seq");
        super.new(name);
    endfunction  //new()

    virtual task body();
        for (int i = 0; i < 128; i++) begin
            uart_seq_item item = uart_seq_item::type_id::create("item");
            gen_data(i, 1);
        end
    endtask

endclass

class uart_rx_seq extends uart_base_seq;
    `uvm_object_utils(uart_rx_seq);
    int num_loop = 0;
    bit [7:0] addr;
    bit [31:0] wdata, rdata;

    function new(string name = "uart_rx_seq");
        super.new(name);
    endfunction  //new()

    virtual task body();
        for (int i = 0; i < 128; i++) begin
            uart_seq_item item = uart_seq_item::type_id::create("item");
            gen_data(i, 0);
        end
    endtask
endclass

`endif
