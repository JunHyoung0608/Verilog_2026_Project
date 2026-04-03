`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/26 09:34:29
// Design Name: 
// Module Name: ckl_div
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


module clk_div (
    input      clk,
    input      reset,
    output reg clk_2,
    output reg clk_10
);

    reg [3:0] counter;

    //clk_2
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            clk_2 <= 1'b0;
        end else begin
            clk_2 <= ~clk_2;
        end
    end

    //clk_10_tick
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            clk_10 <= 1'b0;
        end else begin
            if (counter == 9) begin
                clk_10 <= 1'b1;
            end else begin
                clk_10 <= 1'b0;
            end
        end
    end


    //counter for clk_10
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 4'b0;
        end else begin
            if (counter == 9) begin
                counter <= 0;
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule
