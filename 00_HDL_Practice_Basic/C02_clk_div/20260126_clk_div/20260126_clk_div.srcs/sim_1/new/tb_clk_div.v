`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/26 09:40:28
// Design Name: 
// Module Name: tb_clk_div
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


module tb_clk_div ();

    reg clk, reset;
    wire clk_2, clk_10;

    clk_div U_CLK_DIV (
        .clk  (clk),
        .reset(reset),
        .clk_2(clk_2),
        .clk_10(clk_10)
    );

    //clk
    initial clk = 0;
    always #5 clk = ~clk;



    initial begin
        #0;
        reset = 1;
        
        #20;
        reset = 0;

        #1000;
        $stop;

    end
endmodule
