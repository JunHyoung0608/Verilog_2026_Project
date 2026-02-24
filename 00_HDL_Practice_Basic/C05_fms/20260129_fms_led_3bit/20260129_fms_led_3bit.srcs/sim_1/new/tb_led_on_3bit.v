`timescale 1ns / 1ps


module tb_led_on_3bit();

    reg clk, reset;
    reg [2:0] sw;
    wire [2:0] led;

    led_on_3bit U_LED3_ON(
        .clk(clk),
        .reset(reset),
        .sw(sw),
        .led(led)
    );


    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        //init
        reset = 1'b1;
        sw = 3'b000;

        //reset
        #10;
        reset = 1'b0;

        #10;
        sw = 3'b001;
        #10;
        sw = 3'b010;
        #10;
        sw = 3'b100;
        #10;    //3
        sw = 3'b011;
        #10;    //s1
        sw = 3'b010;
        #10;    //s3
        sw = 3'b000;
        #10;    //s0
        sw = 3'b010;
        #10;    //s2
        sw = 3'b100;
        #10;    //s3
        sw = 3'b111;
        #10;    //s4
        sw = 3'b000;
        #10;    //s0


        #10;
        $stop;


    end
endmodule
