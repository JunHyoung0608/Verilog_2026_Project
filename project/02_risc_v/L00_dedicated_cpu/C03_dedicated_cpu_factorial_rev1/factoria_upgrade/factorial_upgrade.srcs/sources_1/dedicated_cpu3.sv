`timescale 1ns / 1ps


module dedicated_cpu3 (
    input        clk,
    input        rst,
    output [7:0] out
);
    logic w_asrc_sel;
    logic w_aload, w_sumload, w_out_sel, w_equal;

    control_unit U_CTRL_UNIT (
        .clk      (clk),
        .rst      (rst),
        .i_equal  (w_equal),
        .o_src_sel(w_src_sel),
        .o_aload  (w_aload),
        .o_sumload(w_sumload),
        .o_out_sel(w_out_sel)
    );

    datapath U_DATAPATH (
        .clk      (clk),
        .rst      (rst),
        .i_src_sel(w_src_sel),
        .i_aload  (w_aload),
        .i_sumload(w_sumload),
        .i_out_sel(w_out_sel),
        .o_equal  (w_equal),
        .o_out    (out)
    );


endmodule


module control_unit (
    input              clk,
    input              rst,
    input        [7:0] i_a,
    input              i_equal,
    output logic       o_src_sel,
    output logic       o_aload,
    output logic       o_sumload,
    output logic       o_out_sel
);
    typedef enum logic [2:0] {
        IDLE,
        S1,
        S2,
        S3,
        S4
    } state_t;

    state_t c_state, n_state;




    always_ff @(posedge clk or posedge rst) begin : ctrl_u_ff
        if (rst) begin
            c_state <= IDLE;
        end else begin
            c_state <= n_state;
        end
    end

    always_comb begin : state_comb
        n_state = c_state;
        case (c_state)
            IDLE: n_state = S1;
            S1: begin
                if (i_equal) n_state = S4;
                else n_state = S2;
            end
            S2:   n_state = S3;
            S3:   n_state = S1;
        endcase
    end

    always_comb begin : output_comb
        o_src_sel = 0;
        o_aload   = 0;
        o_sumload = 0;
        o_out_sel = 0;
        case (c_state)
            IDLE: begin
                o_src_sel = 0;
                o_aload   = 1;
                o_sumload = 1;
                o_out_sel = 0;
            end
            S1: begin
                o_src_sel = 0;
                o_aload   = 0;
                o_sumload = 0;
                o_out_sel = 0;
            end
            S2: begin
                o_src_sel = 1;
                o_aload   = 0;
                o_sumload = 1;
                o_out_sel = 0;
            end
            S3: begin
                o_src_sel = 1;
                o_aload   = 1;
                o_sumload = 0;
                o_out_sel = 1;
            end
            S4: begin
                o_src_sel = 0;
                o_aload   = 0;
                o_sumload = 0;
                o_out_sel = 1;
            end
        endcase
    end

endmodule



module datapath #(
    parameter BIT_WIDTH = 8,
    ADDR = 4
) (
    input clk,
    input rst,

    //write
    input                           we,
    input        [$clog2(ADDR-1):0] waddr,
    input        [   BIT_WIDTH-1:0] wdata,
    //read
    input        [$clog2(ADDR-1):0] raddr0,
    output logic [   BIT_WIDTH-1:0] rd0,
    input        [$clog2(ADDR-1):0] raddr1,
    output logic [   BIT_WIDTH-1:0] rd1,

    output       o_equal,
    output [7:0] o_out
);
    logic [7:0] w_alu_out, w_reg_mux_out;


    mux_2x1 U_REG_MUX (
        .i_a       (8'b1),
        .i_b       (w_alu_out),
        .i_asrc_sel(i_reg_sel),
        .o_mux_out (w_reg_mux_out)
    );

    register #(
        .BIT_WIDTH(BIT_WIDTH),
        .ADDR     (ADDR)
    ) U_register (
        .clk   (clk),
        .rst   (rst),
        //write
        .we    (i_we),
        .waddr (i_waddr),
        .wdata (w_reg_mux_out),
        //read
        .raddr0(i_raddr0),
        .rd0    (w_rd0),
        .raddr1(i_raddr1),
        .rd1    (w_rd1)
    );


    alu U_ALU (
        .i_rd0     (w_rd0),
        .i_rd1     (w_rd1),
        .o_alu_out(w_alu_out)
    );

    lt10_compa U_10_COMP (
        .i_data (w_rdata0),
        .o_equal(o_equal)
    );

endmodule


module register #(
    parameter BIT_WIDTH = 8,
    ADDR = 4
) (
    input                           clk,
    input                           rst,
    //write
    input                           we,
    input        [$clog2(ADDR-1):0] waddr,
    input        [   BIT_WIDTH-1:0] wdata,
    //read
    input        [$clog2(ADDR-1):0] raddr0,
    output logic [   BIT_WIDTH-1:0] rd0,
    input        [$clog2(ADDR-1):0] raddr1,
    output logic [   BIT_WIDTH-1:0] rd1
);
    logic [7:0] mem[0:$clog2(ADDR)-1];

    assign rd0 = mem[raddr0];
    assign rd1 = mem[raddr1];


    always_ff @(posedge clk or posedge rst) begin : areg_ff
        if (rst) begin
        end else begin
            if (we) begin
                mem[waddr] = wdata;
            end
        end
    end

endmodule


module alu (
    input  [7:0] i_rd0,
    input  [7:0] i_rd1,
    output [7:0] o_alu_out
);

    assign o_alu_out = i_rd0 + i_rd1;

endmodule


module mux_2x1 (
    input  [7:0] i_a,
    input  [7:0] i_b,
    input        i_asrc_sel,
    output [7:0] o_mux_out
);
    assign o_mux_out = (i_asrc_sel) ? i_b : i_a;
endmodule

module lt10_compa (
    input  [7:0] i_data,
    output       o_equal
);
    assign o_equal = (i_data == 11);
endmodule


