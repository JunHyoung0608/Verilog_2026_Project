`timescale 1ns / 1ps


module tb_rx_decoder ();

    reg clk, rst, uart_rx;
    reg  [7:0] test_data;

    wire [7:0] w_rx_data;
    wire w_rx_done, w_b_tick;
    wire dcd_clear,dcd_run_stop,dcd_up,dcd_down,dcd_send_start,dcd_mode,dcd_fnd_sel;

    integer i = 0, j = 0;

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

    //---------instance-----------------
    baud_tick U_BAUD_TICK (
        .clk(clk),
        .rst(rst),
        .b_tick(w_b_tick)
    );
    uart_rx U_UART_RX (
        .clk(clk),
        .rst(rst),
        .rx(uart_rx),
        .b_tick(w_b_tick),
        .rx_data(w_rx_data),
        .rx_done(w_rx_done)
    );
    rx_decoder U_RX_DEACODER (
        .clk         (clk),
        .rst         (rst),
        .i_rx_data   (w_rx_data),
        .i_rx_done   (w_rx_done),
        .o_clear     (dcd_clear),
        .o_run_stop  (dcd_run_stop),
        .o_up        (dcd_up),
        .o_down      (dcd_down),
        .o_send_start(dcd_send_start),
        .o_mode      (dcd_mode),
        .o_fnd_sel   (dcd_fnd_sel)
    );
    //-----------task--------------------
    parameter BAUD = 9600;
    parameter BAUD_REPIOD = (100_000_000 / BAUD) * 10;  //104_160
    task uart_sender();
        begin
            #(BAUD_REPIOD);
            for (j = 0; j < 8; j = j + 1) begin
                uart_rx = test_data[j];
                #(BAUD_REPIOD);
            end
            //stop
            uart_rx = 1'b1;
            #(BAUD_REPIOD);
        end
    endtask

    //---------------sim-----------------
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst       = 1;
        uart_rx   = 1;
        test_data = 0;

        //reset
        repeat (2) @(negedge clk);
        rst = 0;



        //full case
        @(negedge clk);
        for (i = 0; i < 128; i = i + 1) begin
            test_data = i;  //ascii input
            uart_rx   = 0;  //start_bit
            uart_sender();  //data_bit
            #(BAUD_REPIOD);  //stop_bit

            if ((i == ASCII_R) || (i == ASCII_R + 20)) begin
                if (dcd_run_stop) begin
                    $display("%t, check run_stop", $time);
                end
            end else if ((i == ASCII_L) || (i == ASCII_L + 20)) begin
                if (dcd_clear) begin
                    $display("%t, check clear", $time);
                end
            end else if ((i == ASCII_U) || (i == ASCII_U + 20)) begin
                if (dcd_up) begin
                    $display("%t, check up", $time);
                end
            end else if ((i == ASCII_D) || (i == ASCII_D + 20)) begin
                if (dcd_down) begin
                    $display("%t, check down", $time);
                end
            end else if ((i == ASCII_S) || (i == ASCII_S + 20)) begin
                if (dcd_send_start) begin
                    $display("%t, check send", $time);
                end
            end else if (i == ASCII_0) begin
                if (dcd_mode) begin
                    $display("%t, check mode", $time);
                end
            end else if (i == ASCII_1) begin
                if (dcd_fnd_sel) begin
                    $display("%t, check fnd_sel", $time);
                end
            end
        end

        repeat (5) @(negedge clk);
        $stop;
    end



endmodule
