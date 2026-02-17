`timescale 1ns / 1ps


module tb_sr04_ctrl ();

    reg clk, rst, start, echo;
    wire trigger;
    wire [7:0]fnd_data;
    wire [3:0] fnd_digit;
    // wire [23:0] dist_sr04;
    integer SR04_Operation = 80_000;  //80us
    reg [8:0] set_Distance = 0;  //cm
    integer TIME_START = 0, TIME_REG = 0;


    // top_sr04 DUT (
    //     .clk(clk),
    //     .rst(rst),
    //     .start(start),
    //     .echo(echo),
    //     .trigger(trigger),
    //     .o_dist_sr04(dist_sr04)
    // );
    top_top_sr04 DUT (
        .clk      (clk),
        .rst      (rst),
        .btn      (start),
        .sw       (0),
        .echo     (echo),
        .trigger  (trigger),
        .fnd_data (fnd_data),
        .fnd_digit(fnd_digit)
    );

    task sr04();
        begin
            TIME_START = 0;
            TIME_REG   = 0;
            repeat (10) @(posedge clk);
            //start
            @(posedge clk);
            start = 1;
            repeat (2000) @(posedge clk);
            start = 0;

            //trigger check
            wait (trigger);
            TIME_START = $time;
            wait (!trigger);
            $display(
                "%t, \tTREAGER ==> start = %d, \tend = %d, \tlength = %d ns",
                $time, TIME_START, $time, ($time - TIME_START));
            TIME_START = 0;

            //SR04_Operation
            #(SR04_Operation);

            //senser output
            echo = 1;
            TIME_START = $time;
            #(set_Distance * 58 * 1000);
            echo = 0;
            TIME_REG = $time - TIME_START;
            #1;
            // $display(
            //     "%t, \tset_Distance = %dcm, \tdist_sr04 = %d%d, \techo_time = %dus,\tus/58[echo_time] = %d",
            //     $time, set_Distance, dist_sr04[23:8], dist_sr04[7:0],
            //     TIME_REG / 1000, TIME_REG / 58000);
        end
    endtask

    initial clk = 0;
    always #5 clk = ~clk;



    initial begin
        rst   = 1;
        start = 0;
        echo  = 0;
        repeat (5) @(negedge clk);
        rst = 0;

        set_Distance = 60;
        sr04();

        repeat (10) @(negedge clk);

        set_Distance = 240;
        sr04();

        repeat (10) @(negedge clk);

        set_Distance = 400;
        sr04();

        repeat (10) @(negedge clk);

        set_Distance = 500;
        sr04();
        $stop;
    end


endmodule
