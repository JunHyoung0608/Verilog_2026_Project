`timescale 1ns / 1ps
//multi_cycle CPU + interrupt I/O



module rv32I_mcu (
    input         clk,
    input         rst,
    //IO
    input  [ 7:0] gpi,
    output [ 7:0] gpo,
    inout  [15:0] gpio,
    //FND
    output [ 7:0] fnd_data,
    output [ 3:0] fnd_digit,
    //UART
    input         uart_rx,
    output        uart_tx
);
    logic clk_out;
    logic [31:0] instr_addr, instr_data;
    logic bus_wreq, bus_rreq, ready;
    logic [31:0] bus_addr, bus_wdata, bus_rdata;
    logic [2:0] o_funct3;
    logic PENABLE, PWRITE;
    logic [31:0] PADDR, PWDATA;
    logic [13:0] FND_slv_data;
    logic [ 1:0] baud_mode;
    logic TX_busy, TX_start, RX_done;
    logic [7:0] TX_data, RX_data;

    apb_if slv_RAM (), slv_GPIO (), slv_FND (), slv_UART (), slv_I_FILE ();


    // clk_div50 U_CLK_DIV (
    //     .clk    (clk),
    //     .rst    (rst),
    //     .clk_out(clk_out)
    // );

    instruction_mem U_INSTR_MEM (
        .instr_addr(instr_addr[31:2]),
        .instr_data(instr_data)
    );

    rv32i_cpu U_CPU (
        .clk(clk),
        .*
    );


    apb_master U_APB_MASTER (
        .PCLK    (clk),
        .PRESET  (rst),
        //Soc Internal signal with CPU
        .addr    (bus_addr),
        .Wdata   (bus_wdata),
        .Wreq    (bus_wreq),
        .Rreq    (bus_rreq),
        //APB Interface
        .Rdata   (bus_rdata),
        .ready   (ready),
        //output -> salve
        .PADDR   (PADDR),
        .PWDATA  (PWDATA),
        .PENABLE (PENABLE),
        .PWRITE  (PWRITE),
        .slv_RAM (slv_RAM),
        .slv_I_FILE (slv_I_FILE),
        .slv_GPIO(slv_GPIO),
        .slv_FND (slv_FND),
        .slv_UART(slv_UART)
    );

    //0x1000_0000 ~ 0x1000_0FFF
    apb_slave_dram U_SLV_DRAM (
        .PCLK  (clk),
        //cpu
        .funct3(o_funct3),
        //APB_bus
        .*
    );
    //0x1000_1000 ~ 0x1000_2FFF
    apb_slave_image_file U_SLV_I_FILE (
        //APB_bus
        .*
    );
    //0x2000_0000 ~ 0x2000_0FFF
    apb_slave_GPIO U_SLV_GPIO (
        .PCLK   (clk),
        .PRESET (rst),
        //APB_bus
        .*,
        //inout
        .GPIO_io(gpio)
    );
    //0x2000_1000 ~ 0x2000_1FFF
    apb_slave_FND U_SLV_FND (
        .PCLK        (clk),
        .PRESET      (rst),
        //APB_bus
        .*,
        //output
        .FND_slv_data()
    );
    //0x2000_2000 ~ 0x2000_2FFF
    apb_slave_UART U_SLV_UART (
        .PCLK  (clk),
        .PRESET(rst),
        //APB_bus
        //Baud
        //TX
        //RX
        .*
    );

    uart_top U_UART (
        .clk(clk),
        .rst(rst),
        //Baud
        //TX data
        //RX data
        //UART
        .*
    );

endmodule
