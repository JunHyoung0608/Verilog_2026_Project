`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "uart_seq_item.sv"

class uart_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(uart_scoreboard);

    uvm_analysis_imp #(uart_seq_item, uart_scoreboard) ap_imp;

    int farst_scb = 1;


    logic [7:0] tx_assembled_data;
    logic [7:0] rx_assembled_data;
    int start_bit = 1;
    int tx_samp_cnt = 0;
    int rx_samp_cnt = 0;
    int sample_cnt = 0;
    logic [7:0] exp_tx_data = 0;

    int num_tx_pass = 0;
    int num_tx_fail = 0;
    int num_rx_pass = 0;
    int num_rx_fail = 0;


    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_imp = new("ap_imp", this);
    endfunction


    virtual function void write(uart_seq_item item);
        if (item.mode == 1) process_tx(item);  // TX 검증 (DUT Out)
        else process_rx(item);  // RX 검증 (DUT In)
    endfunction

    virtual function void process_tx(uart_seq_item item);
        // 1. [Start Bit] 카운트가 0일 때 (첫 번째 호출)
        if (tx_samp_cnt == 0) begin
            exp_tx_data = item.tx_data;  // 정답 미리 챙겨두기
            tx_assembled_data = 8'h00;  // 이전 데이터 찌꺼기 청소 (매우 중요!)
        end  // 2. [Data Bits] 카운트 1~8일 때 (데이터 비트 구간)
        else if (tx_samp_cnt >= 1 && tx_samp_cnt <= 8) begin
            // UART는 보통 LSB(0번 비트)부터 옵니다.
            // 인덱스를 [tx_samp_cnt-1]로 해야 0, 1, 2...7 순서로 들어갑니다.
            tx_assembled_data[tx_samp_cnt-1] = item.uart_tx;

            `uvm_info("DEBUG", $sformatf("Bit %0d collected: %b -> Current: 0x%h", tx_samp_cnt - 1,
                                         item.uart_tx, tx_assembled_data), UVM_NONE)
        end

        tx_samp_cnt++;

        // 3. [Stop Bit & Compare] 카운트 10일 때 (Stop bit까지 다 들어온 후)
        // 모니터가 Start(1) + Data(8) + Stop(1) = 총 10번 보낸다고 가정
        if (tx_samp_cnt == 10) begin
            if (tx_assembled_data === exp_tx_data) begin
                `uvm_info("SCB_TX", $sformatf("PASS! Act:0x%h == Exp:0x%h", tx_assembled_data,
                                              exp_tx_data), UVM_LOW)
                num_tx_pass++;
            end else begin
                `uvm_error("SCB_TX", $sformatf(
                           "FAIL! Act:0x%h, Exp:0x%h (Missing bit?)", tx_assembled_data, exp_tx_data
                           ))
                num_tx_fail++;
            end

            // 초기화
            tx_samp_cnt = 0;
            tx_assembled_data = 8'h00;
        end
    endfunction

    virtual function void process_rx(uart_seq_item item);
        // 1. [Start Bit]
        if (rx_samp_cnt == 0) begin
            rx_assembled_data = 8'h00;
        end  // 2. [Data Bits] 
        else if (rx_samp_cnt >= 1 && rx_samp_cnt <= 8) begin
            rx_assembled_data[rx_samp_cnt-1] = item.uart_rx;
            `uvm_info("DEBUG_RX", $sformatf("RX Bit %0d collected: %b -> Current: 0x%h",
                                            rx_samp_cnt - 1, item.uart_rx, rx_assembled_data),
                      UVM_NONE)
        end

        rx_samp_cnt++;

        // 3. [Stop Bit & Compare]
        if (rx_samp_cnt == 10) begin
            if (rx_assembled_data === item.rx_data) begin
                `uvm_info("SCB_RX", $sformatf("PASS! Act:0x%h == Exp:0x%h", rx_assembled_data,
                                              item.rx_data), UVM_LOW)
                num_rx_pass++;
            end else begin
                `uvm_error(
                    "SCB_RX", $sformatf(
                    "FAIL! Act:0x%h, Exp:0x%h (RX Bit Mismatch)", rx_assembled_data, item.rx_data))
                num_rx_fail++;
            end

            // 다음 수신을 위한 초기화
            rx_samp_cnt = 0;
            rx_assembled_data = 8'h00;
        end
    endfunction

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info(get_type_name(), $sformatf(
                  "\
        \n===== Summary Report =========\
        \n  Total   : %0d\
        \n  Tx Pass : %0d\
        \n  Tx Fail : %0d\
        \n  Rx Pass : %0d\
        \n  RX Fail : %0d\
        \n==============================",
                  (num_tx_pass + num_tx_fail + num_rx_pass + num_rx_fail),
                  num_tx_pass,
                  num_tx_fail,
                  num_rx_pass,
                  num_rx_fail
                  ), UVM_LOW);
    endfunction

endclass  //component extends uvm_componet


`endif
