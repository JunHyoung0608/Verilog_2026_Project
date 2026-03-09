`timescale 1ns / 1ps
`include "rv32i_opcode.svh"

module control_unit (
    //instr
    input                [6:0] funct7,
    input                [2:0] funct3,
    input  opcode_t            opcode,
    //datapath
    output logic               rf_we,
    output logic               alu_src_sel,
    output alu_control_t       alu_control,
    //data_mem
    output logic               dwe
);

    always_comb begin : ctrl_unit_comb
        rf_we = 0;
        alu_src_sel = 0;
        alu_control = ALU_OFF;
        dwe = 0;
        case (opcode)
            R_type: begin
                rf_we       = 1;
                alu_src_sel = 0;
                alu_control = alu_control_t'({funct7[5], funct3});
                dwe         = 0;
            end
            S_type: begin
                rf_we       = 0;
                alu_src_sel = 1;
                alu_control = ALU_OFF;
                dwe         = 0;
            end
            I_type: begin
                rf_we = 1;
            end
        endcase
    end
endmodule
