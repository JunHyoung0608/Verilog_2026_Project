`timescale 1ns / 1ps

module tb_top ();

    reg clk, reset;

    // reg mode, run_stop, claer, tick;
    // wire [13:0] counter_out;

    // counter_10000 U_COUNTER_10000(
    //     .clk(clk),
    //     .reset(reset),
    //     .mode(mode),
    //     .run_stop(run_stop),
    //     .clear(clear),
    //     .i_tick(tick),
    //     .counter_out(counter_out)
    // );

    reg  [2:0] sw;
    wire [7:0] fnd_data;
    wire [3:0] fnd_digit;

    top_10000_counter U_TOP (
        .clk(clk),
        .reset(reset),
        .sw(sw),
        .fnd_data(fnd_data),
        .fnd_digit(fnd_digit)
    );

    //sw[0]     mode = 0: upcount     mode = 1: downcount
    //sw[1]     run_stop = 0: stop    run_stop = 1: run
    //sw[2]     clear = 0: nothing    clear = 1: claer count vlaue


    //clk
    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        //init
        #0;
        reset = 1'b1;
        sw = 3'b0;
        

        //reset
        #40;
        reset = 1'b0;

        #10;
        sw[1] = 1'b1;

        //clear
        //run_stop
        //mode

    end

endmodule

