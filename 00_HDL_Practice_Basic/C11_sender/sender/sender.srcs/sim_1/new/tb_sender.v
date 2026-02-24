`timescale 1ns / 1ps

module tb_sender ();

    reg clk, rst, i_start, i_sender_ready;
    reg [1:0] i_c_mode;
    reg [31:0] i_dec_data;
    wire [7:0] send_data;
    wire send_valid;

    // sender DUT (
    //     .clk           (clk),
    //     .rst           (rst),
    //     .i_c_mode      (i_c_mode),
    //     .i_start       (i_start),
    //     .i_dec_data    (i_dec_data),
    //     .i_sender_ready(i_sender_ready),
    //     .send_data     (send_data),
    //     .send_valid    (send_valid)
    // );

    AsciiSenderFsm DUT (
        .iClk          (clk),
        .iRstn         (rst),
        .i_c_mode      (i_c_mode),
        .i_start       (i_start),
        .i_dec_data    (i_dec_data),
        .i_sender_ready(i_sender_ready),

        .send_data (send_data),
        .send_valid(send_valid)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 1;
        i_c_mode = 0;
        i_start = 0;
        i_dec_data = 0;
        i_sender_ready = 1;

        #10;
        rst = 0;

        i_dec_data = {4'd2, 4'd0, 4'd2, 4'd6, 4'd0, 4'd2, 4'd3, 4'd5};
        i_start = 1;
        #10;
        i_start = 0;

        #(500);
        i_dec_data = {4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd2, 4'd3, 4'd5};
        i_start = 1;
        #10;
        i_start = 0;

        //SR04
        #(500);
        i_c_mode = 2;
        i_dec_data = {4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd3, 4'd6, 4'd9};
        i_start = 1;
        #10;
        i_start = 0;
        #(500);
        i_dec_data = {4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd6, 4'd9};
        i_start = 1;
        #10;
        i_start = 0;

        //DHT11
        #(500);
        i_c_mode = 3;
        i_dec_data = {4'd6, 4'd3, 4'd0, 4'd0, 4'd3, 4'd6, 4'd0, 4'd5};
        i_start = 1;
        #10;
        i_start = 0;
        #(500);
        i_c_mode = 3;
        i_dec_data = {4'd0, 4'd0, 4'd3, 4'd4, 4'd0, 4'd6, 4'd0, 4'd5};
        i_start = 1;
        #10;
        i_start = 0;

        //DHT11 + i_sender_ready issue
        #(500);
        i_c_mode = 3;
        i_dec_data = {4'd6, 4'd3, 4'd0, 4'd0, 4'd3, 4'd6, 4'd0, 4'd5};
        i_start = 1;
        #10;
        i_start = 0;
        #30;
        i_sender_ready = 0;
        #(100);
        i_sender_ready = 1;

        #(500);
        $stop;
    end

endmodule
