`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "SPI_interface.sv"
`include "SPI_seq_item.sv"
`include "SPI_sequence.sv"
`include "SPI_driver.sv"
`include "SPI_monitor.sv"
`include "SPI_agent.sv"
`include "SPI_scoreboard.sv"
`include "SPI_coverage.sv"
`include "SPI_env.sv"
`include "SPI_test.sv"

module tb_SPI ();
    logic clk;
    logic rst;
    initial clk = 0;
    always #5 clk = ~clk;

    logic sclk;
    logic mosi;
    logic miso;
    logic cs_n;

    SPI_if vif (
        clk, rst
    );

    //DUT
    spi_master U_SPI_MM (
        .clk    (clk),
        .reset  (rst),
        .cpol   (vif.m_cpol),     //idle 0: low, 1: high
        .cpha   (vif.m_cpha),     //first sampling 0: first efge, 1: seconed edge
        .clk_div(vif.m_clk_div),
        .tx_data(vif.m_tx_data),
        .start  (vif.m_start),
        .rx_data(vif.m_rx_data),
        .done   (vif.m_done),
        .busy   (vif.m_busy),
        .*
    );

    spi_slave U_SPI_SS (
        .clk        (clk),
        .rst        (rst),
        //spi_protocals
        .*,
        //slave I/O
        .slv_tx_data(vif.s_slv_tx_data),
        .slv_rx_data(vif.s_slv_rx_data),
        .done       (vif.s_done)
    );

    initial begin
        clk = 0;
        rst = 1;
        repeat (5) @(posedge clk);
        rst = 0;
    end

    initial begin
        uvm_config_db#(virtual SPI_if)::set(null, "*", "vif", vif);
        run_test();
    end

    initial begin
        $timeformat(-9, 3, " ns");
        $fsdbDumpfile("novas.fsdb");
        $fsdbDumpvars(0, tb_SPI, "+all");
    end
endmodule
