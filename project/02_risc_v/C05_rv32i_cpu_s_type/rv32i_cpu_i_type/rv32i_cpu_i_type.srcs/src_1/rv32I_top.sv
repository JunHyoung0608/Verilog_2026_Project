`timescale 1ns / 1ps

module rv32I_top (
    input clk,
    input rst
);
    logic [31:0] instr_addr, instr_data;
    logic dwe;
    logic [31:0] dwaddr, dwdata, drdata;

    instruction_mem U_INSTR_MEM (
        .instr_addr(instr_addr[31:2]),
        .instr_data(instr_data)
    );

    rv32i_cpu U_CPU (.*);

    data_mem #(
        .ADDR(32),
        .BIT_WIDTH(32)
    ) U_DATA_MEM (
        .clk(clk),
        .rst(rst),
        .dwe(dwe),
        //write
        .dwaddr(dwaddr),
        .dwdata(dwdata),
        //read
        .drdata(drdata)
    );


endmodule
