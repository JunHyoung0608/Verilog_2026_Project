`timescale 1ns / 1ps
module tb_led_on ();


    reg clk, reset;
    reg  [2:0] sw;
    wire [1:0] led;

    led_on U_LED_ON (
        .clk(clk),
        .reset(reset),
        .sw(sw),
        .led(led)
    );

    //clk
    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        //init
        #0;
        reset = 1'b1;
        sw = 3'b000;

        #10;
        reset = 1'b0;

        #50;
        sw = 3'b001;

        #50;
        sw = 3'b010;

        #50;
        sw = 3'b100;

        #50;
        $stop;
    end


endmodule
