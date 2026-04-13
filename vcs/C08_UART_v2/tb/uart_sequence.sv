`ifndef SEQUENCE_SV
`define SEQUENCE_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "uart_ram_seq_item.sv"

class uart_base_seq extends uvm_sequence #(uart_seq_item);
    `uvm_object_utils(uart_base_seq);
    int num_loop = 0;

    function new(string name = "uart_base_seq");
        super.new(name);
    endfunction  //new()

    task defin_func(bit [7:0] addr, bit [31:0] data);
        uart_seq_item item;
        item = uart_seq_item::type_id::create("item");
        start_item(item);
        finish_item(item);
    endtask


    virtual task body();
    endtask

endclass

class uart_write_read_seq extends uart_base_seq;
    `uvm_object_utils(uart_write_read_seq);
    int num_loop = 0;
    bit [7:0] addr;
    bit [31:0] wdata, rdata;

    function new(string name = "uart_write_read_seq");
        super.new(name);
    endfunction  //new()

    virtual task body();
        uart_seq_item item = uart_seq_item::type_id::create("item");
        defin_func(addr, wdata);
    endtask

endclass

`endif
