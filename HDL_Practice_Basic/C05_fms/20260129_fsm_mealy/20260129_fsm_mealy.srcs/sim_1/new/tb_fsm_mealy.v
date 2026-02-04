`timescale 1ns / 1ps

module tb_fsm_mealy();

    reg clk, reset, din_bit;
    wire dout_bit;


    fms_mealy U_FMS_MEALY(
        .clk(clk),
        .reset(reset),
        .din_bit(din_bit),
        .dout_bit(dout_bit)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        #0;
        reset = 1'b1;
        din_bit = 1'b0;

        #10;
        reset = 1'b0;

        #20;
        din_bit = 1'b1;
        #30;
        din_bit = 1'b0;
        #10;
        din_bit = 1'b1;
        #10;
    end

endmodule
