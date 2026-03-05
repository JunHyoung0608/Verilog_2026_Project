`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/20 16:01:47
// Design Name: 
// Module Name: tb_gates
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


module tb_gates();

    reg a,b;
    wire y0,y2,y3,y4,y5,y6;

    //top module
    gates dut(
        .a  (a),
        .b  (b),
        .y0 (y0),
        .y1 (y1),
        .y2 (y2),
        .y3 (y3),
        .y4 (y4),
        .y5 (y5),
        .y6 (y6)
    );

    initial begin
        #0;
        a = 0;
        b = 0;

        #10;
        a = 1;
        b = 0;

        #10;
        a = 0;
        b = 1;

        #10;
        a = 1;
        b = 1;

        #10
        $stop;
    end

endmodule
