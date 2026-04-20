`ifndef SEQUENCE_SV
`define SEQUENCE_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

// ack_in write =>ack : 1 nack : 0
// ack_in read => ack : 0 nack : 1

class I2C_base_seq extends uvm_sequence #(I2C_seq_item);
    `uvm_object_utils(I2C_base_seq);
    int num_loop = 0;
    logic [6:0] addr;
    logic slv_ack_in;

    function new(string name = "I2C_base_seq");
        super.new(name);
    endfunction  //new()

    task do_write(bit [7:0] addr_in, bit [7:0] data);
        I2C_seq_item item;
        item = I2C_seq_item::type_id::create("item");
        start_item(item);
        slv_ack_in = 0;
        if (!item.randomize() with {
                item.m_is_read == 0;
                item.s_tx_data == 0;
            })
            `uvm_fatal(get_type_name(), "do_read() Ramdomization Fail!")
        addr = 8'h12;
        item.m_tx_data = data;
        finish_item(item);
        `uvm_info(get_type_name(), $sformatf(
                                       "do_write() 전송 완료: addr=0x%02h, m_tx_data=0x%08h",
                                       addr, item.m_tx_data), UVM_MEDIUM)
    endtask

    task do_read(bit [7:0] addr_in, bit [7:0] data);
        I2C_seq_item item;
        item = I2C_seq_item::type_id::create("item");
        start_item(item);
        slv_ack_in = 0;
        if (!item.randomize() with {
                m_is_read == 1;
                m_tx_data == 0;
            })

            `uvm_fatal(get_type_name(), "do_read() Ramdomization Fail!")
        addr = 8'h12;
        item.s_tx_data = data;
        finish_item(item);
        `uvm_info(get_type_name(), $sformatf(
                                       "do_read() 전송 완료: addr=0x%02h, s_tx_data=0x%08h",
                                       addr, item.s_tx_data), UVM_MEDIUM)
    endtask


    virtual task body();
    endtask

endclass

class I2C_write_seq extends I2C_base_seq;
    `uvm_object_utils(I2C_write_seq);
    int num_loop = 256;


    function new(string name = "I2C_write_seq");
        super.new(name);
    endfunction  //new()

    virtual task body();
        I2C_seq_item item = I2C_seq_item::type_id::create("item");
        for (int i = 0; i < num_loop; i++) begin
            do_write(8'h12, i);
        end
        for (int i = 0; i < num_loop; i++) begin
            do_read(8'h12, i);
        end
    endtask
endclass

class I2C_rand_seq extends I2C_base_seq;
    `uvm_object_utils(I2C_rand_seq);
    int num_loop = 256;


    function new(string name = "I2C_rand_seq");
        super.new(name);
    endfunction  //new()

    virtual task body();
        I2C_seq_item item = I2C_seq_item::type_id::create("item");
        for (int i = 0; i < num_loop; i++) begin
            do_write(8'h12, i);
        end
        for (int i = 0; i < num_loop; i++) begin
            do_read(8'h12, i);
        end
    endtask

    task do_read(bit [7:0] addr_in, bit [7:0] data);
        I2C_seq_item item;
        item = I2C_seq_item::type_id::create("item");
        start_item(item);
        slv_ack_in = 0;
        if (!item.randomize() with {
                m_is_read == 1;
                m_tx_data == 0;
            })

            `uvm_fatal(get_type_name(), "do_read() Ramdomization Fail!")
        addr = 8'h12;
        finish_item(item);
        `uvm_info(get_type_name(), $sformatf(
                                       "do_read() 전송 완료: addr=0x%02h, s_tx_data=0x%08h",
                                       addr, item.s_tx_data), UVM_MEDIUM)
    endtask
endclass

`endif
