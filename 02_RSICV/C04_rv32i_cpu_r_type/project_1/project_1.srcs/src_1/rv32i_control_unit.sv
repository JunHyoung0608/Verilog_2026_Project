`timescale 1ns / 1ps
`include "rv32i_opcode.svh"

module control_unit (
    input                [6:0] funct7,
    input                [2:0] funct3,
    input  opcode_t            opcode,
    output logic               rf_we,
    output alu_control_t       alu_control
);

    always_comb begin : ctrl_unit_comb
        rf_we = 0;
        alu_control = ALU_OFF;
        case (opcode)
            R_type: begin
                rf_we = 1;
                alu_control = alu_control_t'({funct7[5], funct3});
            end
        endcase
    end
endmodule
