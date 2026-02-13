`timescale 1ns / 1ps

module top_top_sr04 (
    input        clk,
    input        rst,
    input        btn,
    input        sw,
    input        echo,
    output       trigger,
    output [7:0] fnd_data,
    output [3:0] fnd_digit
);

    wire w_bd_btn;
    wire [9:0] w_sr_dist_sr04;

    // btn_debounce U_BD (
    //     .clk  (clk),
    //     .reset(rst),
    //     .i_btn(btn),
    //     .o_btn(w_bd_btn)
    // );

    top_sr04 U_SR04 (
        .clk      (clk),
        .rst      (rst),
        .start    (btn),
        .echo     (echo),
        .trigger  (trigger),
        .o_dist_sr04(w_sr_dist_sr04)
    );

    fnd_controller U_FND (
        .clk        (clk),
        .reset      (rst),
        .sel_display(sw),
        .fnd_in_data({14'b0,w_sr_dist_sr04}),
        .fnd_data   (fnd_data),
        .fnd_digit  (fnd_digit),
        .send_data  ()
    );
endmodule
