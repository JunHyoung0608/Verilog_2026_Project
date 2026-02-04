`timescale 1ns / 1ps

module top_stopwatch_watch (
    input         clk,
    input         reset,
    input         btn_r,      //i_run_stop
    input         btn_d,      //i_mode_select
    input         btn_c,
    input         btn_l,      //i_clear
    input  [15:0] sw,
    output [ 3:0] fnd_digit,
    output [ 7:0] fnd_data,
    output [ 2:0] led         //mode: 0~1 run: 2
);

    wire w_run_stop, w_clear, w_down_up, w_read;
    wire [1:0] w_write_digit, w_display_sel;
    wire [2:0] w_mode;
    wire o_btn_run_stop, o_btn_select, o_btn_run_clear, o_btn_time_change, w_btn_fnd_sel;
    wire [23:0] w_stopwatch_time;


    assign led[2]   = w_run_stop;
    assign led[1:0] = w_mode;

    //btn_debounce
    btn_debounce U_BD_RUNSTOP (
        .clk  (clk),
        .reset(reset),
        .i_btn(btn_r),
        .o_btn(o_btn_run_stop)
    );
    btn_debounce U_BD_MODE_SELECT (
        .clk  (clk),
        .reset(reset),
        .i_btn(btn_d),
        .o_btn(o_btn_select)
    );
    btn_debounce U_BD_CLEAR (
        .clk  (clk),
        .reset(reset),
        .i_btn(btn_l),
        .o_btn(o_btn_run_clear)
    );
    btn_debounce U_BD_TIME_CHANGE (
        .clk  (clk),
        .reset(reset),
        .i_btn(btn_c),
        .o_btn(o_btn_time_change)
    );
    push_change U_PUSH_CHANGE (
        .clk  (clk),
        .reset(reset),
        .btn  (o_btn_time_change),
        .d_out(w_btn_fnd_sel)
    );

    //control_unit
    control_unit U_CONTROL_UNIT (
        .clk          (clk),
        .reset        (reset),
        .i_sw         (sw[2:0]),
        .i_mode_select(o_btn_select),
        .i_run_stop   (o_btn_run_stop),
        .i_clear      (o_btn_run_clear),
        .o_down_up    (w_down_up),
        .o_write_digit(w_write_digit),
        .o_read       (w_read),
        .o_run_stop   (w_run_stop),
        .o_clear      (w_clear),
        .o_display_sel(w_display_sel),
        .o_mode       (w_mode)
    );

    //datapath
    datapath U_DATAPATH (
        .clk           (clk),
        .reset         (reset),
        .i_down_up     (w_down_up),
        .i_btn_select  (o_btn_select),
        .i_write_digit (w_write_digit),
        .i_read        (w_read),
        .i_clear       (w_clear),
        .i_sw          (sw),
        .i_run_stop    (w_run_stop),
        .i_display_sel (w_display_sel),
        .o_msec        (w_stopwatch_time[6:0]),    //7bit
        .o_sec         (w_stopwatch_time[12:7]),   //6bit  
        .o_min         (w_stopwatch_time[18:13]),  //6bit      
        .o_hour        (w_stopwatch_time[23:19])   //5bit
    );



    //fnd_ctlr
    fnd_controller U_FND_CNTL (
        .clk          (clk),
        .reset        (reset),
        .i_write_digit(w_write_digit),
        .btn_fnd_sel  (w_btn_fnd_sel),
        .fnd_in_data  (w_stopwatch_time),
        .fnd_digit    (fnd_digit),
        .fnd_data     (fnd_data)
    );


endmodule
