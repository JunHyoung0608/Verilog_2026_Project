`ifndef DRIVER_SV
`define DRIVER_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "uart_seq_item.sv"

class uart_driver extends uvm_driver #(uart_seq_item);
    `uvm_component_utils(uart_driver);

    virtual uart_if vif;
    uvm_analysis_port #(uart_seq_item) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("ap", this);
        if (!uvm_config_db#(virtual uart_if)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "driver에서 uvm_config_db 에러 발생");
    endfunction


    virtual task run_phase(uvm_phase phase);
        uart_bus_init();
        wait (vif.rst == 0);
        `uvm_info(get_type_name(), "리셋 해제 확인. 트랜잭션 대기 중 ...", UVM_MEDIUM)

        forever begin
            uart_seq_item item;

            repeat (50) @(vif.drv_cb);
            seq_item_port.get_next_item(item);
            if (item.mode) begin
                drive_tx(item);
            end else begin
                drive_rx(item);
            end
            seq_item_port.item_done();
        end
    endtask

    task uart_bus_init();
        vif.drv_cb.tx_data <= 8'h0;
        vif.drv_cb.uart_rx <= 1;
    endtask

    task drive_tx(uart_seq_item item);
        //start
        vif.drv_cb.tx_start <= 1;
        vif.drv_cb.tx_data  <= item.rand_data;
        @(vif.drv_cb);
        vif.drv_cb.tx_start <= 0;
        repeat (650) @(vif.drv_cb);
        //WAIT
        for (int i = 0; i < 9; i++) begin
            repeat (651) @(vif.drv_cb);
        end
        `uvm_info(get_type_name(), $sformatf("drv tx 구동 완료: %s", item.convert2string()),
                  UVM_MEDIUM)

    endtask

    task drive_rx(uart_seq_item item);
        //START bit
        vif.drv_cb.uart_rx <= 0;
        repeat (651) @(vif.drv_cb);
        //DATA bit
        for (int i = 0; i < 8; i++) begin
            vif.drv_cb.uart_rx <= item.rand_data[i];
            repeat (651) @(vif.drv_cb);
        end
        //STOP bit
        repeat (651) @(vif.drv_cb);
        vif.drv_cb.uart_rx <= 1;

        `uvm_info(get_type_name(), $sformatf("drv rx 구동 완료: %s", item.convert2string()),
                  UVM_MEDIUM)
    endtask

endclass  //component extends uvm_componet


`endif
