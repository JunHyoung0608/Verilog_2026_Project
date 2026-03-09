`timescale 1ns / 1ps
`include "rv32i_opcode.svh"

module rv32i_cpu (
    input               clk,
    input               rst,
    //instr
    input        [31:0] instr_data,
    output logic [31:0] instr_addr,
    //data_mem
    output logic        dwe,
    output logic [31:0] dwaddr,
    output logic [31:0] dwdata
);
    logic rf_we, alu_src_sel;
    alu_control_t alu_control;


    control_unit U_CTRL_UNIT (
        //instr
        .funct7     (instr_data[31:25]),
        .funct3     (instr_data[14:12]),
        .opcode     (opcode_t'(instr_data[6:0])),
        //datapath
        .rf_we      (rf_we),
        .alu_src_sel(alu_src_sel),
        .alu_control(alu_control),
        //data_mem
        .dwe        (dwe)
    );

    data_path #(
        .ADDR(32),
        .BIT_WIDTH(32)
    ) U_DATA_PATH (
        .clk        (clk),
        .rst        (rst),
        //control
        .rf_we      (rf_we),
        .alu_src_sel(alu_src_sel),
        .alu_control(alu_control),
        //instr
        .instr_data (instr_data),
        .instr_addr (instr_addr),
        //data_mem
        .dwaddr(dwaddr),
        .dwdata(dwdata)
    );

endmodule

