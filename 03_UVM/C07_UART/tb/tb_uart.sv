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
//`include "uart_coverage.sv"
`include "uart_env.sv"
`include "uart_test.sv"

module tb_uart ();
    logic clk;
    logic rst;
    initial clk = 0;
    always #5 clk = ~clk;

    uart_if vif (clk, rst);

    //DUT
    uart_top DUT (
        .clk     (vif.clk),
        .rst     (vif.rst),
        //tx
        .tx_start(vif.tx_start),
        .tx_data (vif.tx_data),
        .uart_tx (vif.uart_tx),
        .tx_done (vif.tx_done),
        .tx_busy (vif.tx_busy),
        //rx
        .uart_rx (vif.uart_rx),
        .rx_data (vif.rx_data),
        .rx_done (vif.rx_done)
    );

    initial begin
        clk = 0;
        rst = 1;
        repeat (5) @(posedge clk);
        rst = 0;
    end

    initial begin
        uvm_config_db#(virtual uart_if)::set(null, "*", "vif", vif);
        run_test();
    end

    initial begin
        $timeformat(-9, 3, " ns");
        $fsdbDumpfile("novas.fsdb");
        $fsdbDumpvars(0, tb_uart, "+all");
    end
endmodule
