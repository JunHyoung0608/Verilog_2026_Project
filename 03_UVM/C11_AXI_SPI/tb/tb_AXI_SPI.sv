`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "AXI_SPI_interface.sv"
`include "AXI_SPI_seq_item.sv"
`include "AXI_SPI_sequence.sv"
`include "AXI_SPI_driver.sv"
`include "AXI_SPI_monitor.sv"
`include "AXI_SPI_agent.sv"
`include "AXI_SPI_scoreboard.sv"
`include "AXI_SPI_coverage.sv"
`include "AXI_SPI_env.sv"
`include "AXI_SPI_test.sv"

module tb_AXI_SPI ();
    logic clk;
    logic rst_n;
    initial clk = 0;
    always #5 clk = ~clk;

    logic sclk, mosi, miso, cs_n;

    AXI_SPI_if vif (clk,rst_n);

    //DUT
    SIP_master_v1_0 #(
        .C_S00_AXI_DATA_WIDTH(32),
        .C_S00_AXI_ADDR_WIDTH(4)
    ) SPI_MASTER (
        .*,
        .s00_axi_aclk   (clk),
        .s00_axi_aresetn(rst_n),
        .s00_axi_awaddr (vif.axi_awaddr),
        .s00_axi_awprot (),
        .s00_axi_awvalid(vif.axi_awvalid),
        .s00_axi_awready(vif.axi_awready),
        .s00_axi_wdata  (vif.axi_wdata),
        .s00_axi_wstrb  (vif.axi_wstrb),
        .s00_axi_wvalid (vif.axi_wvalid),
        .s00_axi_wready (vif.axi_wready),
        .s00_axi_bresp  (vif.axi_bresp),
        .s00_axi_bvalid (vif.axi_bvalid),
        .s00_axi_bready (vif.axi_bready),
        .s00_axi_araddr (vif.axi_araddr),
        .s00_axi_arprot (),
        .s00_axi_arvalid(vif.axi_arvalid),
        .s00_axi_arready(vif.axi_arready),
        .s00_axi_rdata  (vif.axi_rdata),
        .s00_axi_rresp  (vif.axi_rresp),
        .s00_axi_rvalid (vif.axi_rvalid),
        .s00_axi_rready (vif.axi_rready)
    );

    spi_slave SPI_SLV (
        .clk        (clk),
        .rst        (~rst_n),
        //spi_protocals
        .*,
        //slave I/O
        .slv_tx_data(vif.slv_tx_data),
        .slv_rx_data(vif.slv_rx_data),
        .done       (vif.slv_done)
    );


    initial begin
        clk   = 0;
        rst_n = 0;
        repeat (5) @(posedge clk);
        rst_n = 1;
    end

    initial begin
        uvm_config_db#(virtual AXI_SPI_if)::set(null, "*", "vif", vif);
        run_test();
    end

    initial begin
        $timeformat(-9, 3, " ns");
        $fsdbDumpfile("novas.fsdb");
        $fsdbDumpvars(0, tb_AXI_SPI, "+all");
    end
endmodule
