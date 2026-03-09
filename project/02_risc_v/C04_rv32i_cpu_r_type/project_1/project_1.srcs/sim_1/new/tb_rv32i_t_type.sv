`timescale 1ns / 1ps
`include "../../src_1/rv32i_opcode.svh"


module tb_rv32i_t_type ();

    logic clk, rst;

    logic [4:0] rs1,rs2, shift_addr,rd;
    logic [31:0] rd1, rd2, shift;

    logic [31:0] sim_result;
 
    rv32I_top U_DUT (
        .clk(clk),
        .rst(rst)
    );

    always #5 clk = ~clk;
    always @(negedge clk) begin
        #1; 
        if(!rst) begin
            if(`INSTR_MEM.rom[U_DUT.instr_addr][6:0] == `R_TYPE) begin
                case (U_DUT.U_CPU.alu_control)
                    `ADD:  sim_result = rd1 + rd2;
                    `SUB:  sim_result = rd1 - rd2;
                    `SLL:  sim_result = rd1 << shift[4:0];
                    `SLT:  sim_result = ($signed(rd1) < $signed(rd2)) ? 32'b1 : 32'b0;
                    `SLTU: sim_result = (rd1 < rd2) ? 32'b1 : 32'b0;
                    `XOR:  sim_result = rd1 ^ rd2;
                    `SRL:  sim_result = rd1 >> shift[4:0];
                    `SRA:  sim_result = $signed(rd1) >>> shift[4:0];
                    `OR:   sim_result = rd1 | rd2;
                    `AND:  sim_result = rd1 & rd2;
                endcase
                if ($signed(U_DUT.U_CPU.U_DATA_PATH.alu_result) == $signed(sim_result)) begin
                    $write("TRUE\t");
                end else begin
                    $write("FALUS\t");
                end
                $display("%t [check] OPCODE = P_TYPE, ALU_CTRL = %b, reg_file[%d] = %d, sim_result = alu_result"
                ,$realtime, U_DUT.U_CPU.alu_control, rd ,$signed(U_DUT.U_CPU.U_DATA_PATH.alu_result), $signed(sim_result));
            end
        end
    end

    initial begin
        $timeformat(-9,0,"ns");
        clk = 0;
        rst = 1;
        rs1 = 1; rd1 = -100;
        rs2 = 2; rd2 = 200;
        shift_addr = 3; shift = 2;
        rd = 4;
        $display("[Test R_type Instr]");
        //REG
        `REG_FILE.reg_file[rs1] = rd1;
        `REG_FILE.reg_file[rs2] = rd2;
        `REG_FILE.reg_file[shift_addr] = shift;

        //PC
        `INSTR_MEM.rom[0] = {`FNC7_0,   rs2,    rs1,    `FNC3_ADD_SUB,  rd, `R_TYPE};
        `INSTR_MEM.rom[1] = {`FNC7_SUB, rs2,    rs1,    `FNC3_ADD_SUB,  rd, `R_TYPE};
        `INSTR_MEM.rom[2] = {`FNC7_0,   shift_addr,    rs1,    `FNC3_SLL,      rd, `R_TYPE};
        `INSTR_MEM.rom[3] = {`FNC7_0,   rs2,    rs1,    `FNC3_SLT,      rd, `R_TYPE};
        `INSTR_MEM.rom[4] = {`FNC7_0,   rs2,    rs1,    `FNC3_SLTU,     rd, `R_TYPE};
        `INSTR_MEM.rom[5] = {`FNC7_0,   rs2,    rs1,    `FNC3_XOR,      rd, `R_TYPE};
        `INSTR_MEM.rom[6] = {`FNC7_0,   shift_addr,    rs1,    `FNC3_SRL_SRA,  rd, `R_TYPE};
        `INSTR_MEM.rom[7] = {`FNC7_SRA, shift_addr,    rs1,    `FNC3_SRL_SRA,  rd, `R_TYPE};
        `INSTR_MEM.rom[8] = {`FNC7_0,   rs2,    rs1,    `FNC3_OR,       rd, `R_TYPE};
        `INSTR_MEM.rom[9] = {`FNC7_0,   rs2,    rs1,    `FNC3_AND,      rd, `R_TYPE};

        @(negedge clk);
        @(negedge clk);
        rst = 0;
        @(negedge clk);

        repeat(10) @(posedge clk);

        $stop;


    end
endmodule
