`timescale 1ns / 1ps
`include "rv32i_opcode.svh"

module data_path #(
    parameter ADDR = 32,
    BIT_WIDTH = 32
) (
    input                       clk,
    input                       rst,
    input                       rf_we,
    input  alu_control_t        alu_control,
    input                [31:0] instr_data,
    output logic         [31:0] instr_addr
);
    logic [BIT_WIDTH-1:0] rd1, rd2;
    logic [BIT_WIDTH-1:0] alu_result;


    register_file #(
        .ADDR     (ADDR),
        .BIT_WIDTH(BIT_WIDTH)
    ) U_REG_FILE (
        .clk  (clk),
        .rst  (rst),
        .rf_we(rf_we),
        //write
        .wa   (instr_data[11:7]),
        .wd   (alu_result),
        //read
        .ra1  (instr_data[19:15]),
        .ra2  (instr_data[24:20]),
        .rd1  (rd1),
        .rd2  (rd2)
    );

    alu U_ALU (
        .rd1        (rd1),
        .rd2        (rd2),
        .alu_control(alu_control),
        .alu_result (alu_result)
    );

    pc U_PC (
        .clk (clk),
        .rst (rst),
        .i_pc(instr_addr + 4),
        .o_pc(instr_addr)
    );
endmodule


module register_file #(
    parameter ADDR = 32,
    BIT_WIDTH = 32
) (
    input                     clk,
    input                     rst,
    input                     rf_we,
    //write
    input  [$clog2(ADDR)-1:0] wa,
    input  [ BIT_WIDTH - 1:0] wd,
    //read
    input  [$clog2(ADDR)-1:0] ra1,
    input  [$clog2(ADDR)-1:0] ra2,
    output [ BIT_WIDTH - 1:0] rd1,
    output [ BIT_WIDTH - 1:0] rd2
);

    logic [BIT_WIDTH - 1:0] reg_file[0:ADDR-1];

    assign rd1 = reg_file[ra1];
    assign rd2 = reg_file[ra2];

    initial begin
        reg_file[0] = 0;
    end


    always_ff @(posedge clk) begin : reg_file_ff
        if (!rst && (rf_we) && (wa != 0)) begin  //reg_file[0] = Zero
            reg_file[wa] = wd;
        end
    end
endmodule


module alu (
    input                [31:0] rd1,
    input                [31:0] rd2,
    input  alu_control_t        alu_control,
    output logic         [31:0] alu_result
);

    always_comb begin : alu_comb
        alu_result = 0;
        case (alu_control)
            ADD:  alu_result = rd1 + rd2;
            SUB:  alu_result = rd1 - rd2;
            SLL:  alu_result = rd1 << rd2[4:0];
            SLT:  alu_result = ($signed(rd1) < $signed(rd2)) ? 32'b1 : 32'b0;
            SLTU: alu_result = (rd1 < rd2) ? 32'b1 : 32'b0;
            XOR:  alu_result = rd1 ^ rd2;
            SRL:  alu_result = rd1 >> rd2[4:0];
            SRA:  alu_result = $signed(rd1) >>> rd2[4:0];
            OR:   alu_result = rd1 | rd2;
            AND:  alu_result = rd1 & rd2;
        endcase
    end

endmodule


module pc (
    input               clk,
    input               rst,
    input        [31:0] i_pc,
    output logic [31:0] o_pc
);



    always_ff @(posedge clk or posedge rst) begin : pc_ff
        if (rst) begin
            o_pc <= 0;
        end else begin
            o_pc <= i_pc;
        end
    end

endmodule
