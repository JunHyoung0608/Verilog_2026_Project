`timescale 1ns / 1ps

module tb_dut;

    // intput
    reg  clk;
    reg  rst;
    reg  din_bit;

    // output
    wire dout_bit;

    // DUT
    detect0101_mealy dut (
        .clk(clk),
        .reset(rst),
        .din_bit(din_bit),
        .dout_bit(dout_bit)
    );

    always #5 clk = ~clk;

    initial begin
        // init
        clk = 0;
        rst = 1;
        din_bit = 0;

        // reset
        #10;
        rst = 0;
        #10;
        // pattern 1010_100110100110
        #10 din_bit = 1;
        #10 din_bit = 0;
        #10 din_bit = 1;
        #10 din_bit = 0;
        #10 din_bit = 1;
        #10 din_bit = 0;
        #20 din_bit = 1;
        #20 din_bit = 0;
        #10 din_bit = 1;
        #10 din_bit = 0;
        #20 din_bit = 1;
        #20 din_bit = 0;
        // stop
        #100 $stop;
    end


endmodule


