`ifndef SEQUENCE_SV
`define SEQUENCE_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "AXI_SPI_seq_item.sv"

class AXI_SPI_base_seq extends uvm_sequence #(AXI_SPI_seq_item);
    `uvm_object_utils(AXI_SPI_base_seq);
    int num_loop = 0;

    function new(string name = "AXI_SPI_base_seq");
        super.new(name);
    endfunction  //new()

    task do_send(bit [31:0] data);
        AXI_SPI_seq_item item;
        item = AXI_SPI_seq_item::type_id::create("item");
        start_item(item);
        if (!item.randomize()) `uvm_fatal(get_type_name(), "do_read() Ramdomization Fail!")
        item.axi_wdata   = data;
        item.slv_tx_data = data;
        finish_item(item);
        `uvm_info(get_type_name(), $sformatf("do_write() 전송 완료: data=0x%08h", data),
                  UVM_MEDIUM)
    endtask


    virtual task body();
    endtask

endclass

class AXI_SPI_write_read_seq extends AXI_SPI_base_seq;
    `uvm_object_utils(AXI_SPI_write_read_seq);
    int num_loop = 10;
    bit [7:0] addr;
    bit [31:0] wdata, rdata;

    function new(string name = "AXI_SPI_write_read_seq");
        super.new(name);
    endfunction  //new()

    virtual task body();
        AXI_SPI_seq_item item = AXI_SPI_seq_item::type_id::create("item");
        for(int i = 0; i < num_loop; i++) begin
            do_send(i);
        end
    endtask

endclass

`endif
