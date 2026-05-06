`timescale 1ns / 1ps

module tb_I2C_master();

    // Parameters
    parameter ADDR_WIDTH = 4;
    parameter DATA_WIDTH = 32;

    // Signals
    reg clk;
    reg rst_n;
    
    // AXI Slave Interface Signals
    reg [ADDR_WIDTH-1:0] awaddr;
    reg awvalid;
    wire awready;
    reg [DATA_WIDTH-1:0] wdata;
    reg [DATA_WIDTH/8-1:0] wstrb;
    reg wvalid;
    wire wready;
    wire [1:0] bresp;
    wire bvalid;
    reg bready;
    
    reg [ADDR_WIDTH-1:0] araddr;
    reg arvalid;
    wire arready;
    wire [DATA_WIDTH-1:0] rdata;
    wire [1:0] rresp;
    wire rvalid;
    reg rready;

    // I2C External Ports
    wire scl;
    wire sda;

    // I2C Pull-up Resistor (SDA는 Open-drain이므로 풀업이 필수입니다)
    assign (pull1, pull0) sda = 1'b1;

    // Instantiate Top Module
    I2C_master_v1_0 #(
        .C_S00_AXI_DATA_WIDTH(DATA_WIDTH),
        .C_S00_AXI_ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .scl(scl),
        .sda(sda),
        .s00_axi_aclk(clk),
        .s00_axi_aresetn(rst_n),
        .s00_axi_awaddr(awaddr),
        .s00_axi_awprot(3'b000),
        .s00_axi_awvalid(awvalid),
        .s00_axi_awready(awready),
        .s00_axi_wdata(wdata),
        .s00_axi_wstrb(wstrb),
        .s00_axi_wvalid(wvalid),
        .s00_axi_wready(wready),
        .s00_axi_bresp(bresp),
        .s00_axi_bvalid(bvalid),
        .s00_axi_bready(bready),
        .s00_axi_araddr(araddr),
        .s00_axi_arprot(3'b000),
        .s00_axi_arvalid(arvalid),
        .s00_axi_arready(arready),
        .s00_axi_rdata(rdata),
        .s00_axi_rresp(rresp),
        .s00_axi_rvalid(rvalid),
        .s00_axi_rready(rready)
    );

    // Clock Generation (100MHz)
    always #5 clk = ~clk;

    // AXI Write Task
    task axi_write(input [ADDR_WIDTH-1:0] addr, input [DATA_WIDTH-1:0] data);
        begin
            awaddr = addr;
            awvalid = 1;
            wdata = data;
            wvalid = 1;
            wstrb = 4'hf;
            bready = 1;
            wait(awready && wready);
            @(posedge clk);
            awvalid = 0;
            wvalid = 0;
            wait(bvalid);
            @(posedge clk);
            bready = 0;
        end
    endtask

    // AXI Read Task
    task axi_read(input [ADDR_WIDTH-1:0] addr);
        begin
            araddr = addr;
            arvalid = 1;
            rready = 1;
            wait(arready);
            @(posedge clk);
            arvalid = 0;
            wait(rvalid);
            $display("Read Data from Addr %h: %h", addr, rdata);
            @(posedge clk);
            rready = 0;
        end
    endtask

    // Simple I2C Slave Model (ACK 전송용)
    // 9번째 클럭마다 SDA를 0으로 떨어뜨려 ACK를 시뮬레이션함
    reg sda_slave_out;
    assign sda = sda_slave_out ? 1'bz : 1'b0;
    initial sda_slave_out = 1;

    // Main Test Sequence
    initial begin
        // Initialize
        clk = 0;
        rst_n = 0;
        awaddr = 0; awvalid = 0; wdata = 0; wvalid = 0; wstrb = 0; bready = 0;
        araddr = 0; arvalid = 0; rready = 0;

        // Reset
        #100;
        rst_n = 1;
        #100;

        $display("--- Starting I2C Simulation ---");

        // 1. START Command (slv_reg0[0] = 1 이라고 가정)
        axi_write(4'h0, 32'h0000_0001); 
        #100;
        axi_write(4'h0, 32'h0000_0000); // Command bit clear (Software처럼 동작)

        // // 2. Busy 확인 및 Done 대기
        // repeat(50) begin
        //     axi_read(4'h8); // Status Register (slv_reg2)
        //     #5000; // I2C는 느리므로 간격을 둡니다.
        // end

        // // 3. Write Address (예: 0xA0)
        // // slv_reg1에 데이터 쓰고 slv_reg0[1]에 Write 명령
        // axi_write(4'h4, 32'h0000_00A0); 
        // axi_write(4'h0, 32'h0000_0002);
        // #100;
        // axi_write(4'h0, 32'h0000_0000);

        #100000;
        $finish;
    end

endmodule