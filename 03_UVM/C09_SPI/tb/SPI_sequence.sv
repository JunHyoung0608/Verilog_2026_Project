`ifndef SEQUENCE_SV
`define SEQUENCE_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "SPI_seq_item.sv"

class SPI_base_seq extends uvm_sequence #(SPI_seq_item);
    `uvm_object_utils(SPI_base_seq)
    int num_loop = 0;

    function new(string name = "SPI_base_seq");
        super.new(name);
    endfunction  //new()

    task defin_func(bit [7:0] data, bit [1:0] mode);
        SPI_seq_item item;
        item = SPI_seq_item::type_id::create("item");
        start_item(item);
        if (!item.randomize()) `uvm_fatal(get_type_name(), "do_read() Ramdomization Fail!")
        item.m_tx_data             = data;
        item.s_slv_tx_data         = data;
        {item.m_cpol, item.m_cpha} = mode;
        finish_item(item);
        `uvm_info(get_type_name(),
                  $sformatf(
                      "[%d/255]do_write() 전송 완료: m_tx_data=0x%02h, s_slv_tx_data=0x%08h",
                      data, item.m_tx_data, item.s_slv_tx_data), UVM_MEDIUM)
    endtask


    virtual task body();
    endtask

endclass

class SPI_write_read_seq extends SPI_base_seq;
    `uvm_object_utils(SPI_write_read_seq)
    int num_loop = 10;

    function new(string name = "SPI_write_read_seq");
        super.new(name);
    endfunction  //new()

    virtual task body();
        SPI_seq_item item = SPI_seq_item::type_id::create("item");
        for (int i = 0; i < num_loop; i++) begin
            defin_func(i, 0);

        end
    endtask

endclass

`endif
