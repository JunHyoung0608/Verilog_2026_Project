`timescale 1ns / 1ps

module tb_top_adder ();

    reg clk, reset;

    wire [7:0] fnd_data;
    wire [3:0] fnd_digit;


    top_10000_counter u_top_10000_counter (
        .clk      (clk),
        .reset    (reset),
        .fnd_data (fnd_data),
        .fnd_digit(fnd_digit)
    );

    //clk
    always #5 clk = ~clk;

    initial begin
        //init
        #0;
        reset = 1'b1;
        clk = 1'b0;

        //reset
        #40;
        reset = 1'b0;



    end

endmodule
