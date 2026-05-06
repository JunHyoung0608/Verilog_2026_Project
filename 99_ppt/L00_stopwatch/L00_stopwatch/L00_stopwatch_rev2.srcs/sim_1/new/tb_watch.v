`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/02/02 21:15:53
// Design Name: 
// Module Name: tb_watch
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


module tb_watch();

    
    reg clk, reset, btn_r, btn_d, btn_c, btn_l;
    reg [15:0] sw;

    wire [3:0]fnd_digit;
    wire [7:0] fnd_data;
    wire [2:0] led;

    top_stopwatch_watch u_DUT (
    .clk(clk),
    .reset(reset),
    .btn_r(btn_r),      //i_run_stop
    .btn_d(btn_d),      //i_mode_select
    .btn_c(btn_c),      //digit_chage
    .btn_l(btn_l),      //i_clear
    .sw(sw),
    .fnd_digit(fnd_digit),
    .fnd_data(fnd_data),
    .led(led)
);

initial clk = 1'b0;
always #5 clk = ~clk;

initial begin
    #0;
    reset = 1'b1;
    btn_r = 1'b0;
    btn_d = 1'b0; 
    btn_c = 1'b0; 
    btn_l = 1'b0; 
    sw = 16'b0;

    #10;
    reset = 1'b0;
    sw[1:0] = 2'b01;
    #200000;
    btn_d = 1'b1;
    
    #200000;
    btn_d = 1'b0;

    #200000;
    sw = {4'd1,4'd2,4'd3,4'd4};
    #200000;
    #200000;
    #200000;
    #200000;
    #200000;
    #200000;
    #200000;

    #200000;
    #200000;
    #200000;
    btn_r = 1'b1;
    #200000;
    btn_r = 1'b0;
    #200000;
    #200000;
    #200000;
    #200000;
    #200000;
    #200000;
    #200000;
    #200000;
    sw = {4'd5,4'd6,4'd7,4'd8};
    #200000;
    btn_r = 1'b1;
    #200000;
    btn_r = 1'b0;
    $stop;

end
endmodule
