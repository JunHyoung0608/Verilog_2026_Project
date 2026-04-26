`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "uart_interface.sv"
`include "uart_seq_item.sv"
`include "uart_sequence.sv"
`include "uart_driver.sv"
`include "uart_monitor.sv"
`include "uart_agent.sv"
`include "uart_scoreboard.sv"
`include "uart_coverage.sv"
`include "uart_env.sv"
`include "uart_test.sv"

module tb_uart_uvm ();
    logic clk;
    logic rst;

    always #5 clk = ~clk;

    uart_if vif (
        clk,
        rst
    );

    //DUT
    uart #(
        .BAUD_RATE(9600)
    ) DUT (
        .clk     (clk),
        .rst     (rst),
        //tx port
        .tx_data (vif.tx_data),
        .tx_start(vif.tx_start),
        .tx      (vif.tx),
        .tx_busy (vif.tx_busy),
        //rx port
        .rx      (vif.rx),
        .rx_data (vif.rx_data),
        .rx_valid(vif.rx_valid)
    );

    assign vif.rx = vif.tx;

    initial begin
        clk = 0;
        rst = 1;
        repeat (3) @(posedge clk);
        rst = 0;
        @(posedge clk);
    end

    initial begin
        uvm_config_db#(virtual uart_if)::set(null, "*", "vif", vif);
        run_test();
    end

    initial begin
        $timeformat(-9, 3, " ns");
        $fsdbDumpfile("novas.fsdb");
        $fsdbDumpvars(0, tb_uart_uvm, "+all");
    end
endmodule
