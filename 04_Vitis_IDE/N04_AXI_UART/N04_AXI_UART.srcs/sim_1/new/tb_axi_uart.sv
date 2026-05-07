`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/06 16:39:27
// Design Name: 
// Module Name: tb_axi_uart
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_axi_uart ();

    parameter CLK_FREQ = 100_000_000;
    parameter BAUD_RATE = 115_200;
    parameter integer C_S00_AXI_DATA_WIDTH = 32;
    parameter integer C_S00_AXI_ADDR_WIDTH = 4;

    logic                                  tx;
    logic                                  rx;
    logic                                  rx_intr;
    logic                                  loop_wire;



    logic                                  s00_axi_aclk;
    logic                                  s00_axi_aresetn;
    logic [    C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr;
    logic [                         2 : 0] s00_axi_awprot;
    logic                                  s00_axi_awvalid;
    logic                                  s00_axi_awready;
    logic [    C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata;
    logic [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb;
    logic                                  s00_axi_wvalid;
    logic                                  s00_axi_wready;
    logic [                         1 : 0] s00_axi_bresp;
    logic                                  s00_axi_bvalid;
    logic                                  s00_axi_bready;
    logic [    C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr;
    logic [                         2 : 0] s00_axi_arprot;
    logic                                  s00_axi_arvalid;
    logic                                  s00_axi_arready;
    logic [    C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata;
    logic [                         1 : 0] s00_axi_rresp;
    logic                                  s00_axi_rvalid;
    logic                                  s00_axi_rready;

    uart_v1_0 #(
        .CLK_FREQ(100_000_000),
        .BAUD_RATE(115_200),
        // Parameters of Axi Slave Bus Interface S00_AXI
        .C_S00_AXI_DATA_WIDTH(32),
        .C_S00_AXI_ADDR_WIDTH(4)
    ) U_uart_v1_0 (
        .*,
        .tx(loop_wire),
        .rx(loop_wire)
    );

    always #5 s00_axi_aclk = ~s00_axi_aclk;

    task axi_write(input logic [7:0] addr, input logic [31:0] data);
        @(posedge s00_axi_aclk);
        s00_axi_awaddr  <= addr;
        s00_axi_awvalid <= 1'b1;
        s00_axi_wdata   <= data;
        s00_axi_wvalid  <= 1'b1;
        s00_axi_wstrb   <= 4'hf;
        s00_axi_bready  <= 1'b1;

        wait (s00_axi_awready && s00_axi_wready);
        @(posedge s00_axi_aclk);
        s00_axi_awvalid <= 1'b0;
        s00_axi_wvalid  <= 1'b0;

        wait (s00_axi_bvalid);
        @(posedge s00_axi_aclk);
        s00_axi_bready <= 1'b0;

    endtask

    task axi_read(input logic [7:0] addr, output logic [31:0] data);
        @(posedge s00_axi_aclk);
        s00_axi_araddr  <= addr;
        s00_axi_arvalid <= 1'b1;
        s00_axi_rready  <= 1'b1;

        wait (s00_axi_arready);
        @(posedge s00_axi_aclk);
        s00_axi_arvalid <= 1'b0;

        wait (s00_axi_rvalid);
        data = s00_axi_rdata;
        @(posedge s00_axi_aclk);
        s00_axi_rready <= 1'b0;
        @(posedge s00_axi_aclk);
    endtask

    initial begin
        //$timeformat(-9,1,"ns");

        logic [31:0] read_data;
        logic [31:0] tx_data;
        logic [31:0] rx_data;
        logic [31:0] control_data;
        logic [31:0] status_data;

        s00_axi_aclk = 0;
        s00_axi_aresetn = 0;
        #100;
        s00_axi_aresetn = 1;
        #100;

        //1. tx_data 레지스터에 데이터 쓰기
        tx_data = 32'h0000_0055;
        axi_write(8'h04, tx_data);

        //2. rx_data 확인
        do begin
            @(posedge s00_axi_aclk);
            axi_read(8'h00, status_data);
        end while (!status_data[1]);
        @(posedge s00_axi_aclk);


        axi_read(8'h08, rx_data);
        if (tx_data == rx_data) begin
            $display("[%t] [PASS!] tx_data: %0h, rx_data: %0h", $time, tx_data, rx_data);
        end else begin
            $display("[%t] [FAIL!] tx_data: %0h, rx_data: %0h", $time, tx_data, rx_data);
        end

        //3. 인터럽트 확인
        control_data = 32'h0000_0001;
        axi_write(8'h0c, control_data);  //cr[0] = 1; 인터럽트 인에이블

        do begin
            @(posedge s00_axi_aclk);
            axi_read(8'h00, status_data);
        end while (!status_data[0]);
        @(posedge s00_axi_aclk);


        tx_data = 32'h0000_0011;
        axi_write(8'h04, tx_data);

        wait (rx_intr);

        axi_read(8'h08, rx_data);
        if (tx_data == rx_data) begin
            $display("[%t] [PASS!] tx_data: %0h, rx_data: %0h", $time, tx_data, rx_data);
        end else begin
            $display("[%t] [FAIL!] tx_data: %0h, rx_data: %0h", $time, tx_data, rx_data);
        end







        #100;
        $finish;
    end
endmodule
