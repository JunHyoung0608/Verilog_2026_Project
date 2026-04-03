`timescale 1ns / 1ps


module tb_fsm_moore();

    reg clk, reset, sw;
    wire led;


    fsm_moore U_FSM_MOORE(
        .clk(clk),
        .reset(reset),
        .sw(sw),
        .led(led)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        //init
        #0;
        reset = 1'b1;
        sw = 0;

        #40;
        reset = 1'b0;

        #100;
        sw = 1;

        #100;
        sw = 0;
    end
endmodule

