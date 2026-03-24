`timescale 1ns / 1ps
//multi_cycle CPU + interrupt I/O
interface apb_if;
    logic [31:0] PRDATA;
    logic        PSEL;
    logic        PREADY;

    // Slave I/O
    modport slave_io(input PRDATA, PREADY, output PSEL);
endinterface

module rv32I_mcu (
    input clk,
    input rst
);
    logic [31:0] instr_addr, instr_data;
    logic bus_wreq, bus_rreq, ready;
    logic [31:0] bus_addr, bus_wdata, bus_rdata;
    logic [2:0] o_funct3;
    apb_if slv_RAM ();
    apb_if slv_GPO ();
    apb_if slv_GPI ();
    apb_if slv_GPIO ();
    apb_if slv_FND ();
    apb_if slv_UART ();

    instruction_mem U_INSTR_MEM (
        .instr_addr(instr_addr[31:2]),
        .instr_data(instr_data)
    );

    rv32i_cpu U_CPU (.*);

    // data_mem U_DATA_MEM (
    //     .*,
    //     .i_funct3(o_funct3)
    // );

    apb_master U_APB_MASTER (
        .PCLK    (clk),
        .PRESETn (rst),
        //Soc Internal signal with CPU
        .addr    (bus_addr),
        .Wdata   (bus_wdata),
        .Wreq    (bus_wreq),
        .Rreq    (bus_rreq),
        //APB Interface
        // output logic                  slvERR,
        .Rdata   (bus_rdata),
        .ready   (ready),
        //output -> salve
        .PADDR   (),
        .PWDATA  (),
        .PENABLE (),
        .PWRITE  (),
        .slv_RAM (slv_RAM),
        .slv_GPO (slv_GPO),
        .slv_GPI (slv_GPI),
        .slv_GPIO(slv_GPIO),
        .slv_FND (slv_FND),
        .slv_UART(slv_UART)
    );


endmodule
