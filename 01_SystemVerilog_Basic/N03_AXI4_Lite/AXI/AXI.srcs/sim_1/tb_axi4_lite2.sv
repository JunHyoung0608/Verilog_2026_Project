`timescale 1ns / 1ps

module tb_axi4_lite ();


    logic        ACLK;
    logic        ARESETn;
    logic [31:0] AWADDR;
    logic        AWVALID;
    logic        AWREADY;
    logic [31:0] WDATA;
    logic        WVALID;
    logic        WREADY;
    logic [ 1:0] BRESP;
    logic        BVALID;
    logic        BREADY;
    logic [31:0] ARADDR;
    logic        ARVALID;
    logic        ARREADY;
    logic [31:0] RDATA;
    logic        RVALID;
    logic        RREADY;
    logic [ 1:0] RRESP;
    logic        transfer;
    logic        ready;
    logic [31:0] addr;
    logic [31:0] wdata;
    logic        write;
    logic [31:0] rdata;

    // SLAVE AXI-Lite simulator
    logic [31:0] slv_reg0, slv_reg1, slv_reg2, slv_reg3;

    axi4_lite_master U_M0 (.*);
    axi4_lite_slave U_S0 (.*);

    always #5 ACLK = ~ACLK;
    bit [31:0] slave_addr;
    bit slv_addr_flag;

    // tester
    task automatic axi_write(logic [31:0] address, logic [31:0] data);
        addr <= address;
        wdata <= data;
        write <= 1'b1;
        transfer <= 1'b1;
        @(posedge ACLK);
        transfer <= 1'b0;
        do @(posedge ACLK); while (!ready);
        $display("[%0t] CPU WRITE ADDR @%0h, WDATA = %0h", $time, addr, wdata);
    endtask  //axi_write


    task automatic axi_read(logic [31:0] address);
        addr <= address;
        write <= 1'b0;
        transfer <= 1'b1;
        @(posedge ACLK);
        transfer <= 1'b0;
        do @(posedge ACLK); while (!ready);
        $display("[%0t] CPU READ ADDR @%0h, RDATA = %0h", $time, addr, rdata);
    endtask  //axi_write



    initial begin
        ACLK = 0;
        ARESETn = 0;
        repeat (3) @(posedge ACLK);
        ARESETn = 1;
        repeat (3) @(posedge ACLK);

        repeat (3) @(posedge ACLK);
        axi_write(32'h00000000, 32'h11111111);
        @(posedge ACLK);
        axi_write(32'h00000004, 32'h22222222);
        @(posedge ACLK);
        axi_write(32'h00000008, 32'h33333333);
        @(posedge ACLK);
        axi_write(32'h0000000c, 32'h44444444);
        @(posedge ACLK);

        axi_read(32'h00000000);
        @(posedge ACLK);
        axi_read(32'h00000004);
        @(posedge ACLK);
        axi_read(32'h00000008);
        @(posedge ACLK);
        axi_read(32'h0000000c);

        repeat (10) @(posedge ACLK);
        $finish;
    end
endmodule
