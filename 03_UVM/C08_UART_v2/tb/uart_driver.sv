`ifndef DRIVER_SV
`define DRIVER_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "uart_ram_seq_item.sv"

class uart_driver extends uvm_driver #(uart_seq_item);
    `uvm_component_utils(uart_driver);

    virtual uart_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual uart_if)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "driver에서 uvm_config_db 에러 발생");
    endfunction


    virtual task run_phase(uvm_phase phase);
        uart_seq_item item;

        vif.tx_data  <= 8'h00;
        vif.tx_start <= 1'b0;
        @(negedge vif.rst);
        repeat (3) @(vif.drv_cb);

        forever begin
            seq_item.prot.get_next_item(item);
            while (vif.drv_cb.tx_busy == 0) @(vif.drv_cb);
            @(vif.drv_cb);
            vif.tx_data  <= item.tx_data;
            vif.tx_start <= 1'b1;
            @(vif.drv_cb);
            vif.tx_start <= 1'b0;
            `uvm_info(get_type_name(), $sforamtf("전송 시작: tx_data = 0x%02h", item.tx_data),
                      UVM_HIGH)
            @(vif.drv_cb);
            while (!v_if.drv_cb.tx_busy) @(vif.drv_cb);
            while (v_if.drv_cb.tx_busy) @(vif.drv_cb);
            `uvm_info(get_type_name(), $sforamtf("전송 완료: tx_data = 0x%02h", item.tx_data),
                      UVM_HIGH)
            seq_item_prot.item_done();
        end
    endtask

endclass  //component extends uvm_componet


`endif
