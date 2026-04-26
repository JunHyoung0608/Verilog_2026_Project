`ifndef MONITOR_SV
`define MONITOR_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
// `include "ram_interface.sv"
`include "uart_seq_item.sv"


class uart_monitor extends uvm_monitor;
    `uvm_component_utils(uart_monitor);

    virtual uart_if vif;

    uvm_analysis_port #(uart_seq_item) ap;

    int mode = 0;
    int start = 0;


    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("ap", this);
        if (!uvm_config_db#(virtual uart_if)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "monitor에서 uvm_config_db 에러 발생");
    endfunction

    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "UART 모니터링 시작 ...", UVM_MEDIUM)

        forever begin
            collect_transaction();
        end
    endtask


    task collect_transaction();
        uart_seq_item item;

        @(vif.mon_cb);

        // 1. 신호 변화 감지 (Start Bit 또는 TX Start)
        if (!vif.mon_cb.uart_rx || vif.mon_cb.tx_start) begin
            if (vif.mon_cb.tx_start) mode = 1;
            else mode = 0;
            start = 1;
        end
        if (start) begin
            // --- START Bit 샘플링 ---
            repeat (651 / 2 * 16) @(vif.mon_cb);
            send_bit_to_scb(mode);  // Start Bit 전송 (보통 0)

            // --- DATA Bits 샘플링 (8번) ---
            for (int i = 0; i < 8; i++) begin
                repeat (651 * 16) @(vif.mon_cb);
                send_bit_to_scb(mode);  // 각 데이터 비트 즉시 전송
            end

            // --- STOP Bit 샘플링 ---
            repeat (651* 16) @(vif.mon_cb);
            send_bit_to_scb(mode);  // Stop Bit 전송 (보통 1)

            //END
            mode  = 0;
            start = 0;
        end
    endtask

    task send_bit_to_scb(int m);
        uart_seq_item item;
        item          = uart_seq_item::type_id::create("mon_item");

        item.mode     = m;
        item.uart_tx  = vif.mon_cb.uart_tx;
        item.uart_rx  = vif.mon_cb.uart_rx;
        item.tx_start = vif.mon_cb.tx_start;
        item.tx_data  = vif.mon_cb.tx_data;
        item.rx_data  = vif.mon_cb.rx_data;
        item.tx_done  = vif.mon_cb.tx_done;
        item.rx_done  = vif.mon_cb.rx_done;
        `uvm_info(get_type_name(), $sformatf("mon 보내기: %s", item.convert2string()),
                  UVM_MEDIUM)
        ap.write(item);
    endtask

endclass  //component extends uvm_componet


`endif
