`timescale 1ns / 1ps


module tb_rx_decoder ();

    reg clk, rst, rx_done;
    reg [7:0] rx_data;

    wire dcd_clear,dcd_run_stop,dcd_up,dcd_down,dcd_send_start,dcd_mode,dcd_fnd_sel;

    integer i = 0;

    localparam [7:0] ASCII_R = 8'h52,
                     ASCII_L = 8'h4c,
                     ASCII_U = 8'h55, 
                     ASCII_D = 8'h44,
                     ASCII_S = 8'h53,
                     ASCII_0 = 8'h30,
                     ASCII_1 = 8'h31;

    reg [55:0] put_data = {
        ASCII_R, ASCII_L, ASCII_U, ASCII_D, ASCII_S, ASCII_0, ASCII_1
    };


    rx_decoder U_RX_DEACODER (
        .clk         (clk),
        .rst         (rst),
        .i_rx_data   (rx_data),
        .i_rx_done   (rx_done),
        .o_clear     (dcd_clear),
        .o_run_stop  (dcd_run_stop),
        .o_up        (dcd_up),
        .o_down      (dcd_down),
        .o_send_start(dcd_send_start),
        .o_mode      (dcd_mode),
        .o_fnd_sel   (dcd_fnd_sel)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 1;
        rx_done = 0;
        rx_data = 0;
        repeat (2) @(negedge clk);
        rst = 0;

        @(negedge clk);
        for (i = 0; i < 7; i = i + 1) begin
            @(negedge clk);
            rx_data  = put_data[55:48];
            put_data = put_data << 8;
            rx_done  = 1;
            @(negedge clk);
            rx_done = 0;
        end

        //full case
        @(negedge clk);
        for (i = 0; i < 128; i = i + 1) begin
            @(negedge clk);
            rx_data  = i;
            rx_done  = 1;
            @(negedge clk);
            rx_done = 0;
            if ((i == ASCII_R) ||  (i == (ASCII_R+8'h20)) ||
                (i == ASCII_L) ||  (i == (ASCII_L+8'h20)) ||
                (i == ASCII_U) ||  (i == (ASCII_U+8'h20)) ||
                (i == ASCII_D) ||  (i == (ASCII_D+8'h20)) ||
                (i == ASCII_S) ||  (i == (ASCII_S+8'h20)) ||
                (i == ASCII_0) ||
                (i == ASCII_1)) begin
            if (dcd_clear)
                $display("%t: Pass %s", $time, i);
            if (dcd_run_stop)
                $display("%t: Pass %s", $time, i);
            if (dcd_up)
                $display("%t: Pass %s", $time, i);
            if (dcd_down)
                $display("%t: Pass %s", $time, i);
            if (dcd_send_start)
                $display("%t: Pass %s", $time, i);
            if (dcd_mode)
                $display("%t: Pass %s", $time, i);
            if (dcd_fnd_sel)
                $display("%t: Pass %s", $time, i);
            end
        end

        repeat (5) @(negedge clk);
        $stop;
    end



endmodule
