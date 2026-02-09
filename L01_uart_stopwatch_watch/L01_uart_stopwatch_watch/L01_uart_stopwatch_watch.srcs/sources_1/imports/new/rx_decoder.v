    `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/02/08 15:27:19
// Design Name: 
// Module Name: rx_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module rx_decoder (
    input        clk,
    input        rst,
    input  [7:0] i_rx_data,
    input        i_rx_done,
    output       o_clear,
    output       o_run_stop,
    output       o_up,
    output       o_down,
    output       o_sw1
);
    localparam [7:0] ASCII_R = 8'h52,
                    ASCII_L = 8'h4c,
                    ASCII_U = 8'h55,
                    ASCII_D = 8'h44,
                    ASCII_S = 8'h53;

    reg clear_reg, run_reg, up_reg, down_reg, sw1_reg;

    assign o_clear = clear_reg;
    assign o_run = run_reg;
    assign o_up = up_reg;
    assign o_down = down_reg;
    assign o_sw1 = sw1_reg;




    always @(posedge clk or posedge rst) begin
        if (rst) begin
            run_reg   <= 1'b0;
            clear_reg <= 1'b0;
            up_reg    <= 1'b0;
            down_reg  <= 1'b0;
            sw1_reg <= 1'b0;
        end else begin
            if (i_rx_done) begin
                if ((i_rx_data == ASCII_R) || (i_rx_data == (ASCII_R + 8'h20))) begin
                    run_reg <= 1'b1;
                end else if((i_rx_data == ASCII_L) || (i_rx_data == (ASCII_L + 8'h20))) begin
                    clear_reg <= 1'b1;
                end else if((i_rx_data == ASCII_U) || (i_rx_data == (ASCII_U + 8'h20))) begin
                    up_reg <= 1'b1;
                end else if ((i_rx_data == ASCII_D) || (i_rx_data == (ASCII_D + 8'h20))) begin
                    down_reg <= 1'b1;
                end else if ((i_rx_data == ASCII_S) || (i_rx_data == (ASCII_S + 8'h20))) begin
                    sw1_reg <= 1'b1;
                end
            end else begin
                run_reg   <= 1'b0;
                clear_reg <= 1'b0;
                up_reg    <= 1'b0;
                down_reg  <= 1'b0;
                sw1_reg <= 1'b0;
            end
        end
    end




endmodule
