`timescale 1ns / 1ps

module top_stopwatch_watch (
    input         clk,
    input         rst,
    input         btn_l,  //clear
    input         btn_r,  //run_stop
    input         btn_u,  //up
    input         btn_d,  //down
    input  [2:0] sw,          //[2] fnd diplay(hour/min or sec/msec) [1] mode [0] mode select
    output [3:0] fnd_digit,
    output [7:0] fnd_data,
    output [2:0] led  //mode: 0~1 run: 2
);

    wire w_bd_clear, w_bd_run_stop, w_bd_down, w_bd_up;
    wire w_c_run_stop, w_c_down_up, w_c_mode;
    wire [1:0] w_c_clear, w_c_time_modify;
    wire [23:0] w_dp_stopwatch_time, w_dp_watch_time, w_dp_select_time;

    //-----------------output------------------------
    // assign led[2]   = w_c_run_stop;
    // assign led[1:0] = (w_c_mode) ? 2'b10 : 2'b01;
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
        .i_clear      (w_bd_clear),
        .i_run_stop   (w_bd_run_stop),
        .i_up         (w_bd_up),
        .i_down       (w_bd_down),
        .i_mode_done  (sw[0]),
        .i_mode       (sw[1]),
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
        .sel_display(sw[2]),
        .fnd_in_data(w_dp_select_time),
        .fnd_digit  (fnd_digit),
        .fnd_data   (fnd_data)
    );


endmodule
