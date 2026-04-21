`timescale 1ns / 1ps
`include "rv32i_opcode.svh"

module data_path #(
    parameter ADDR = 32,
    BIT_WIDTH = 32
) (
    input                                  clk,
    input                                  rst,
    //control
    input                                  rf_we,
    input                                  alu_src_sel,
    input                [            2:0] rf_wd_sel,
    input  alu_control_t                   alu_control,
    input                                  b_src_sel,
    input                                  branch,
    input                                  pc_en,
    //instr
    input                [           31:0] instr_data,
    output logic         [           31:0] instr_addr,
    //APB_BUS
    input  logic         [BIT_WIDTH - 1:0] bus_rdata,
    output logic         [BIT_WIDTH - 1:0] bus_addr,
    output logic         [BIT_WIDTH - 1:0] bus_wdata
);
    logic [31:0] id_rs1, id_rs2, id_imm, id_pc_plus_4, id_pc_plus_rs1;
    logic [31:0] ex_alu_result, ex_rs2, ex_imm, ex_pc_plus_4, ex_pc_plus_imm;
    logic ex_b_taken;
    logic [31:0] mem_alu_result, mem_dmem_rdata, mem_imm, mem_pc_plus_4, mem_pc_plus_imm;
    logic [31:0] wb_mux_out;

    assign bus_addr  = ex_alu_result;
    assign bus_wdata = id_rs2;


    dec_path U_DEC_PATH (
        .i_clk           (clk),
        .i_rst           (rst),
        //ctrl_unit
        .i_cu_rf_we      (),
        //Input
        .i_if_instr_data (),
        .i_if_pc         (),
        .i_if_pc_plus_4  (),
        .i_wb_mux_data   (wb_mux_out),
        //Output
        .o_id_rs1        (id_rs1),
        .o_id_rs2        (id_rs2),
        .o_id_imm        (id_imm),
        .o_id_pc_plus_4  (id_pc_plus_4),
        .o_id_pc_plus_rs1(id_pc_plus_rs1)
    );

    ex_path U_EX_PATH (
        .clk             (clk),
        .rst             (rst),
        //ctrl_unit
        .i_cu_alu_control(),
        .i_cu_alu_src_sel(),
        //INPUT
        .i_id_rs1        (id_rs1),
        .i_id_rs2        (id_rs2),
        .i_id_imm_data   (id_imm),
        .i_id_pc_plus_4  (id_pc_plus_4),
        .i_id_pc_plus_imm(id_pc_plus_rs1),
        //OUPUT
        .o_ex_alu_result (ex_alu_result),
        .o_ex_rs2        (ex_rs2),
        .o_ex_imm        (ex_imm),
        .o_ex_b_taken    (ex_b_taken),
        .o_ex_pc_plus_4  (ex_pc_plus_4),
        .o_ex_pc_plus_imm(ex_pc_plus_imm)
    );

    mem_path U_MEM_PATH (
        .clk              (clk),
        .rst              (rst),
        //INPUT
        .i_ex_alu_result  (ex_alu_result),
        .i_dmem_rdata     (),
        .i_ex_imm         (ex_imm),
        .i_ex_pc_plus_4   (ex_pc_plus_4),
        .i_ex_pc_plus_imm (ex_pc_plus_imm),
        //OUTPUT
        .o_mem_alu_result (mem_alu_result),
        .o_mem_dmem_rdata (mem_dmem_rdata),
        .o_mem_imm        (mem_imm),
        .o_mem_pc_plus_4  (mem_pc_plus_4),
        .o_mem_pc_plus_imm(mem_pc_plus_imm)
    );

    wb_path U_WB_PATH (
        //ctrl_unit
        .i_cu_rf_wd_sel   (),
        //INPUT
        .i_mem_alu_result (mem_alu_result),
        .i_mem_dmem_rdata (mem_dmem_rdata),
        .i_mem_imm        (mem_imm),
        .i_mem_pc_plus_imm(mem_pc_plus_imm),
        .i_mem_pc_plus_4  (mem_pc_plus_4),
        //OUTPUT
        .o_wb_mux_out     (wb_mux_out)
    );



    //PC-----------------------------------------

    pc U_PC (
        .clk         (clk),
        .rst         (rst),
        //control_unit
        .pc_en       (pc_en),
        .b_taken     (ex_b_taken),
        .branch      (branch),
        .b_src_sel   (b_src_sel),
        //data
        .rs1_plus_imm(),
        .pc_plus_imm (pc_plus_imm),
        .pc_plus_4   (o_ex_pc_plus_4),
        .o_pc        (instr_addr)
    );

endmodule

module pc (
    input               clk,
    input               rst,
    //control_unit
    input               pc_en,
    input               b_taken,
    input               branch,
    input               b_src_sel,
    //data
    input        [31:0] rs1_plus_imm,
    input        [31:0] pc_plus_imm,
    input        [31:0] pc_plus_4,
    output logic [31:0] o_pc
);

    logic [31:0] pc_reg, pc_next;
    logic j_event;

    //branch_event
    assign j_event = b_taken && branch;

    always_ff @(posedge clk or posedge rst) begin : pc_ff
        if (rst) begin
            pc_reg <= 0;
            o_pc   <= 0;
        end else begin
            pc_reg <= pc_next;
            if (pc_en) o_pc <= pc_reg;
        end
    end


    always_comb begin : pc_comb
        //mux   
        case ({
            j_event, b_src_sel
        })
            2'b00, 2'b01: pc_next = pc_plus_4;
            2'b10:        pc_next = pc_plus_imm;
            2'b11:        pc_next = rs1_plus_imm;
        endcase
    end

endmodule

