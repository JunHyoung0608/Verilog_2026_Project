`timescale 1ns / 1ps

module tb_axi_slave ();

    parameter C_S_AXI_DATA_WIDTH = 32;
    parameter C_S_AXI_ADDR_WIDTH = 4;

    logic                                s00_axi_aclk;
    logic                                s00_axi_aresetn;
    logic [      C_S_AXI_ADDR_WIDTH-1:0] s00_axi_awaddr;
    logic [                       2 : 0] s00_axi_awprot;
    logic                                s00_axi_awvalid;
    logic                                s00_axi_awready;
    logic [    C_S_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata;
    logic [(C_S_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb;
    logic                                s00_axi_wvalid;
    logic                                s00_axi_wready;
    logic [                       1 : 0] s00_axi_bresp;
    logic                                s00_axi_bvalid;
    logic                                s00_axi_bready;
    logic [      C_S_AXI_ADDR_WIDTH-1:0] s00_axi_araddr;
    logic [                       2 : 0] s00_axi_arprot;
    logic                                s00_axi_arvalid;
    logic                                s00_axi_arready;
    logic [    C_S_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata;
    logic [                       1 : 0] s00_axi_rresp;
    logic                                s00_axi_rvalid;
    logic                                s00_axi_rready;


    myip_v1_0_S00_AXI #(
        .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
    ) myip_v1_0_S00_AXI_inst (
        .S_AXI_ACLK(s00_axi_aclk),
        .S_AXI_ARESETN(s00_axi_aresetn),
        .S_AXI_AWADDR(s00_axi_awaddr),
        .S_AXI_AWPROT(s00_axi_awprot),
        .S_AXI_AWVALID(s00_axi_awvalid),
        .S_AXI_AWREADY(s00_axi_awready),
        .S_AXI_WDATA(s00_axi_wdata),
        .S_AXI_WSTRB(s00_axi_wstrb),
        .S_AXI_WVALID(s00_axi_wvalid),
        .S_AXI_WREADY(s00_axi_wready),
        .S_AXI_BRESP(s00_axi_bresp),
        .S_AXI_BVALID(s00_axi_bvalid),
        .S_AXI_BREADY(s00_axi_bready),
        .S_AXI_ARADDR(s00_axi_araddr),
        .S_AXI_ARPROT(s00_axi_arprot),
        .S_AXI_ARVALID(s00_axi_arvalid),
        .S_AXI_ARREADY(s00_axi_arready),
        .S_AXI_RDATA(s00_axi_rdata),
        .S_AXI_RRESP(s00_axi_rresp),
        .S_AXI_RVALID(s00_axi_rvalid),
        .S_AXI_RREADY(s00_axi_rready)
    );

    always #5 s00_axi_aclk = ~s00_axi_aclk;

    task automatic axi_write(logic [31:0] addr, logic [31:0] data);
        @(posedge s00_axi_aclk);
        s00_axi_awaddr  <= addr;
        s00_axi_awvalid <= 1'b1;
        s00_axi_wdata   <= data;
        s00_axi_wvalid  <= 1'b1;
        s00_axi_wstrb   <= 4'b1111;
        s00_axi_bready  <= 1'b1;

        wait (s00_axi_awready & s00_axi_wready);
        @(posedge s00_axi_aclk);
        s00_axi_awvalid <= 1'b0;
        s00_axi_wvalid  <= 1'b0;

        wait (s00_axi_bvalid);
        @(posedge s00_axi_aclk);
        s00_axi_bready <= 1'b0;
        $display("[%t] WRITE: Addr = 0x%0h, Data = 0x%0h", $time, addr, data);
    endtask  //automatic

    task automatic axi_read(logic [31:0] addr);
        @(posedge s00_axi_aclk);
        s00_axi_araddr  <= addr;
        s00_axi_arvalid <= 1'b1;
        s00_axi_rready <= 1'b1;

        wait (s00_axi_arready);
        @(posedge s00_axi_aclk);
        s00_axi_arvalid <= 1'b0;

        wait (s00_axi_rvalid);
        @(posedge s00_axi_aclk);
        s00_axi_rready <= 1'b0;
        $display("[%t] READ: Addr=0x%0h, Data=0x%0h", $time, addr, s00_axi_rdata);
    endtask  //automatic

    initial begin
        $timeformat(-9, 3, " ns");
        s00_axi_aclk    = 0;
        s00_axi_aresetn = 0;
        s00_axi_awaddr  = 0;
        s00_axi_awprot  = 0;
        s00_axi_awvalid = 0;
        s00_axi_wdata   = 0;
        s00_axi_wstrb   = 0;
        s00_axi_wvalid = 0;
        s00_axi_bready = 0;
        s00_axi_bready =0;
        s00_axi_araddr = 0;
        s00_axi_arprot = 0;
        s00_axi_arvalid = 0;
        s00_axi_rready = 0;
        repeat (3) @(posedge s00_axi_aclk);
        s00_axi_aresetn = 1;
        repeat (3) @(posedge s00_axi_aclk);
        axi_write(4'h0, 32'hDEAD_BEEF);
        axi_write(4'h4, 32'hCAFE_BABE);
        axi_write(4'h8, 32'h1234_5678);
        axi_write(4'hc, 32'hAAAA_BBBB);

        repeat (3) @(posedge s00_axi_aclk);
        axi_read(4'h0);
        axi_read(4'h4);
        axi_read(4'h8);
        axi_read(4'hc);
    end

endmodule
