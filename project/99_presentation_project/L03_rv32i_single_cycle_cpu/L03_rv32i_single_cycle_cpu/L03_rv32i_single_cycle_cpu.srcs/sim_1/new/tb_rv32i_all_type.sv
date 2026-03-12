`timescale 1ns / 1ps
`include "../../src_1/rv32i_opcode.svh"

`define R 0
`define I 0
`define S 0
`define IL 0
`define B 0
`define U 0
`define J 0




module tb_rv32i_all_type ();
    //input
    logic clk, rst;

    //sim
    logic [4:0] rs1, rs2, shift_addr, rd;
    logic [31:0] rd1, rd2, shift;

    logic [31:0] sim_result;

    integer i;

    rv32I_top U_DUT (
        .clk(clk),
        .rst(rst)
    );

    always #5 clk = ~clk;

    task reset(input reg_option);
        rst = 1;

        //REG
        if (reg_option) begin
            for (i = 1; i < 32; i = i + 1) begin
                `REG_FILE.reg_file[i] = i;
            end
        end else begin
            for (i = 1; i < 32; i = i + 1) begin
                `REG_FILE.reg_file[i] = 32'bx;
            end
        end

        //DMEM
        for (i = 0; i < 32; i = i + 1) begin
            `DMEM.dmem[i] = 32'bx;
        end
    endtask

    task run(input cycle);
        @(negedge clk);
        rst = 0;
        repeat(cycle) @(posedge clk);
    endtask


    //sim
    initial begin
        clk =0;
        reset(0);

        $readmemh("riscv_rv32i_rom.mem",`INSTR_MEM.rom);

        run(10);

        //sim1----------------r-type------------------------
        if(`R)begin
        reset(0);
        $display("[Test R_type Instr]");
        //REG
        `REG_FILE.reg_file[1] = rd1;
        `REG_FILE.reg_file[2] = rd2;
        `REG_FILE.reg_file[shift_addr] = shift;

        //PC
        `INSTR_MEM.rom[0] = {`FNC7_0,   rs2,            rs1,    `FNC3_ADD_SUB,  rd, `R_TYPE};
        `INSTR_MEM.rom[1] = {`FNC7_SUB, rs2,            rs1,    `FNC3_ADD_SUB,  rd, `R_TYPE};
        `INSTR_MEM.rom[2] = {`FNC7_0,   shift_addr,     rs1,    `FNC3_SLL,      rd, `R_TYPE};
        `INSTR_MEM.rom[3] = {`FNC7_0,   rs2,            rs1,    `FNC3_SLT,      rd, `R_TYPE};
        `INSTR_MEM.rom[4] = {`FNC7_0,   rs2,            rs1,    `FNC3_SLTU,     rd, `R_TYPE};
        `INSTR_MEM.rom[5] = {`FNC7_0,   rs2,            rs1,    `FNC3_XOR,      rd, `R_TYPE};
        `INSTR_MEM.rom[6] = {`FNC7_0,   shift_addr,     rs1,    `FNC3_SRL_SRA,  rd, `R_TYPE};
        `INSTR_MEM.rom[7] = {`FNC7_SRA, shift_addr,     rs1,    `FNC3_SRL_SRA,  rd, `R_TYPE};
        `INSTR_MEM.rom[8] = {`FNC7_0,   rs2,            rs1,    `FNC3_OR,       rd, `R_TYPE};
        `INSTR_MEM.rom[9] = {`FNC7_0,   rs2,            rs1,    `FNC3_AND,      rd, `R_TYPE};


        run(10);
        end
        //sim2----------------i-type------------------------
        if(`I) begin
            reset(0);
            $display("[Test I_type Instr]");
            run(10);
        end
        //sim3----------------s-type------------------------
        if(`S) begin
            reset(0);
            $display("[Test S_type Instr]");
            run(10);
        end
        //sim4----------------il-type-----------------------
        if(`IL) begin
            reset(0);
            $display("[Test IL_type Instr]");
            run(10);
        end
        //sim5----------------b-type-----------------------
        if(`B) begin
            reset(0);
            $display("[Test B_type Instr]");
            run(10);
        end
        //sim6----------------u-type------------------------
        if(`U) begin
            reset(0);
            $display("[Test U_type Instr]");
            run(10);
        end
        //sim7----------------j-type------------------------
        if(`J) begin
            reset(0);
            $display("[Test J_type Instr]");
            run(10);
        end


    end
endmodule
