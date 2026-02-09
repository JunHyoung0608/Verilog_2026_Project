`timescale 1ns / 1ps

module top_uart_stopwatch_watch (
    input        clk,
    input        rst,
    input        btn_r,
    input        btn_l,
    input        btn_u,
    input        btn_d,
    input  [1:0] sw,
    input        uart_rx,
    output [3:0] fnd_digit,
    output [7:0] fnd_data,
    output [2:0] led,
    output       uart_tx
);
<<<<<<< HEAD
    wire w_b_tick, w_rx_done, w_rx_clear, w_rx_run_stop, w_rx_up, w_rx_down, w_push_mode,w_rx_fnd_sel,w_rx_mode, w_sel_display;
=======


    wire w_b_tick, w_rx_done, w_rx_clear, w_rx_run_stop, w_rx_up, w_rx_down, w_rx_sw1, w_sc_sw1;
>>>>>>> cc80950e3a5adc7b2e0a8044a772210a9e73d1f9
    wire [7:0] w_rx_data;
    //----------------Uart-------------------------
    baud_tick U_BAUD_TICK (
        .clk(clk),
        .rst(rst),
        .b_tick(w_b_tick)
    );

    uart_tx U_UART_TX (
        .clk(clk),
        .rst(rst),
        .tx_start(w_rx_done),
        .b_tick(w_b_tick),
        .tx_data(w_rx_data),
        .tx_busy(),
        .tx_done(),
        .uart_tx(uart_tx)
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
        .clk       (clk),
        .rst       (rst),
        .i_rx_data (w_rx_data),
        .i_rx_done (w_rx_done),
        .o_clear   (w_rx_clear),
        .o_run_stop(w_rx_run_stop),
        .o_up      (w_rx_up),
        .o_down    (w_rx_down),
<<<<<<< HEAD
        .o_mode     (w_rx_mode),
        .o_fnd_sel (w_rx_fnd_sel)
    );
    //------------------------sw_changer---------------------

    push_change U_PUSH_MODE (
        .clk  (clk),
        .rst  (rst),
        .d_in (sw[0]),
        .push (w_rx_mode),
        .d_out(w_push_mode)
    );

    push_change U_PUSH_FND (
        .clk  (clk),
        .rst  (rst),
        .d_in (sw[1]),
        .push (w_rx_fnd_sel),
        .d_out(w_sel_display)
    );
=======
        .o_sw1     (w_rx_sw1)
    );


    push_change U_SWC (
        .clk  (clk),
        .rst  (rst),
        .d_in (sw[1]),
        .push (w_rx_sw1),
        .d_out(w_sc_sw2)
    );

>>>>>>> cc80950e3a5adc7b2e0a8044a772210a9e73d1f9


    wire w_bd_clear, w_bd_run_stop, w_bd_down, w_bd_up;
    wire w_c_run_stop, w_c_down_up, w_c_mode;
    wire [1:0] w_c_clear, w_c_time_modify;
    wire [23:0] w_dp_stopwatch_time, w_dp_watch_time, w_dp_select_time;

    //-----------------btn_debounce------------------------
    btn_debounce U_BD_CLEAR (
        .clk  (clk),
        .reset(rst),
        .i_btn(btn_l),
        .o_btn(w_bd_clear)
    );
    btn_debounce U_BD_RUNSTOP (
        .clk  (clk),
        .reset(rst),
        .i_btn(btn_r),
        .o_btn(w_bd_run_stop)
    );
    btn_debounce U_BD_UP (
        .clk  (clk),
        .reset(rst),
        .i_btn(btn_u),
        .o_btn(w_bd_up)
    );
    btn_debounce U_BD_DOWN (
        .clk  (clk),
        .reset(rst),
        .i_btn(btn_d),
        .o_btn(w_bd_down)
    );
    //-----------------control_unit------------------------
    control_unit U_CTLR_UNIT (
        .clk          (clk),
        .rst          (rst),
        .i_clear      (w_bd_clear || w_rx_clear),
        .i_run_stop   (w_bd_run_stop || w_rx_run_stop),
        .i_up         (w_bd_up || w_rx_up),
        .i_down       (w_bd_down || w_rx_down),
<<<<<<< HEAD
        .i_mode       (w_push_mode),
=======
        .i_mode       (sw[0]),
>>>>>>> cc80950e3a5adc7b2e0a8044a772210a9e73d1f9
        .o_clear      (w_c_clear),
        .o_run_stop   (w_c_run_stop),
        .o_down_up    (w_c_down_up),
        .o_time_modify(w_c_time_modify),
        .o_mode       (w_c_mode),
        .test_mode    (led)
    );
    //-----------------datapath------------------------
    datapath_stopwatch U_DP_STOPWATCH (
        .clk       (clk),
        .reset     (rst),
        .i_clear   (w_c_clear[0]),
        .i_down_up (w_c_down_up),
        .i_run_stop(w_c_run_stop),
        .o_msec    (w_dp_stopwatch_time[6:0]),    //7bit
        .o_sec     (w_dp_stopwatch_time[12:7]),   //6bit  
        .o_min     (w_dp_stopwatch_time[18:13]),  //6bit      
        .o_hour    (w_dp_stopwatch_time[23:19])   //5bit
    );
    datapath_watch U_DP_WATCH (
        .clk          (clk),
        .reset        (rst),
        .i_clear      (w_c_clear[1]),
        .i_time_modify(w_c_time_modify),
        .o_msec       (w_dp_watch_time[6:0]),    //7bit
        .o_sec        (w_dp_watch_time[12:7]),   //6bit  
        .o_min        (w_dp_watch_time[18:13]),  //6bit      
        .o_hour       (w_dp_watch_time[23:19])   //5bit
    );
    mux_2X1 #(
        .BIT_WIDTH(24)
    ) U_MUX_2X1 (
        .sel(w_c_mode),
        .i_sel0(w_dp_stopwatch_time),
        .i_sel1(w_dp_watch_time),
        .o_mux(w_dp_select_time)
    );
    //-----------------fnd_ctlr------------------------
    fnd_controller U_FND_CNTL (
        .clk        (clk),
        .reset      (rst),
<<<<<<< HEAD
        .sel_display(w_sel_display),
=======
        .sel_display(w_sc_sw2),
>>>>>>> cc80950e3a5adc7b2e0a8044a772210a9e73d1f9
        .fnd_in_data(w_dp_select_time),
        .fnd_digit  (fnd_digit),
        .fnd_data   (fnd_data)
    );

endmodule
