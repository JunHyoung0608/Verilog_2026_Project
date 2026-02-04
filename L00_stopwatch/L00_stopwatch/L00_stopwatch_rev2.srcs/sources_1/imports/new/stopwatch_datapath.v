`timescale 1ns / 1ps

module datapath (
    input         clk,
    input         reset,
    input         i_down_up,
    input         i_btn_select,
    input  [ 1:0] i_write_digit,
    input         i_read,
    input         i_clear,
    input  [15:0] i_sw,
    input         i_run_stop,
    input  [ 1:0] i_display_sel,
    output [ 6:0] o_msec,
    output [ 5:0] o_sec,
    output [ 5:0] o_min,
    output [ 4:0] o_hour
);




    wire w_tick_100hz, w_sec_tick, w_min_tick, w_hour_tick;
    wire [6:0] c_msec;
    wire [5:0] c_sec;
    wire [5:0] c_min;
    wire [4:0] c_hour;
    reg [23:0] r_setting_data;
    wire [23:0] mem_rdata;
    wire [23:0] mux_out;
    wire [6:0] sw_bottum_data, sw_top_data;
    wire [23:0] sum_time_data;

    //memory
    reg [23:0] mem[0:7];
    reg [2:0] count, next_count;

    integer i = 4'd0;

    //stopwatch mem count SL
    always @(posedge clk or posedge reset) begin
        if (reset | i_clear) begin
            count <= 3'b0;
            for (i = 4'd0; i < 4'd7; i = i + 1) begin
                mem[i] <= 23'b0;
            end
        end else begin
            if (i_write_digit == 2'b11) begin
                if (i_btn_select) begin
                    mem[count] <= {c_hour, c_min, c_sec, c_msec};
                    count <= next_count;
                end
            end
        end
    end

    //count CL
    always @(*) begin
        next_count <= count;
        if (i_write_digit == 2'b11) begin
            if (i_btn_select) begin
                next_count <= count + 3'b1;
            end
        end
    end

    //road data STOPWATCH_STOP
    assign mem_rdata = mem[i_sw[5:3]-1];

    //if don't want read_mem,mux sel  is 2'b0
    wire [1:0] mux_sel;
    assign mux_sel = ((i_display_sel == 2'b10) && (i_sw[5:3] == 3'b0))?  2'b0 : i_display_sel;
    //output fnd
    mux_4X1 U_MUX_4X1 (
        .sel   (mux_sel),
        .i_sel0({c_hour, c_min, c_sec, c_msec}),
        .i_sel1(r_setting_data),
        .i_sel2(mem_rdata),
        .i_sel3(sum_time_data),
        .o_mux (mux_out)
    );

    assign o_hour = mux_out[23:19];
    assign o_min  = mux_out[18:13];
    assign o_sec  = mux_out[12:7];
    assign o_msec = mux_out[6:0];

    //sw_to_binary
    wire w_set_time_mode = (i_write_digit == 2'b10);
    sw_to_bin U_STB_TOP (
        .i_sw(i_sw[15:8]),
        .set_time_mode({w_set_time_mode, 1'b1}),
        .o_bin(sw_top_data)
    );
    sw_to_bin U_STB_BOTTUM (
        .i_sw(i_sw[7:0]),
        .set_time_mode({w_set_time_mode, 1'b0}),
        .o_bin(sw_bottum_data)
    );

    //set_mode time display
    always @(posedge clk or posedge reset) begin
        if (reset | i_clear) begin
            r_setting_data = 24'b0;
        end else begin
            //write sw_data
            if (i_write_digit == 2'b10) begin
                r_setting_data[23:19] <= sw_top_data[4:0];
                r_setting_data[18:13] <= sw_bottum_data[5:0];
            end else if (i_write_digit == 2'b01) begin
                r_setting_data[12:7] <= sw_top_data[5:0];
                r_setting_data[6:0]  <= sw_bottum_data;
            end
        end
    end

    sum_clock U_SUM_CLOCK (
        .i_tick_data({c_hour, c_min, c_sec, c_msec}),
        .i_set_data (r_setting_data),
        .o_sum_data (sum_time_data)
    );


    //time_counter
    //hour
    tick_counter #(
        .BIT_WIDTH(5),
        .TIMES(24)
    ) hour_counter (
        .clk     (clk),
        .reset   (reset),
        .clear   (i_clear),
        .i_tick  (w_hour_tick),
        .down_up (i_down_up),
        .run_stop(i_run_stop),
        .o_count (c_hour),
        .o_tick  ()
    );
    //min
    tick_counter #(
        .BIT_WIDTH(6),
        .TIMES(60)
    ) min_counter (
        .clk     (clk),
        .reset   (reset),
        .clear   (i_clear),
        .i_tick  (w_min_tick),
        .down_up (i_down_up),
        .run_stop(i_run_stop),
        .o_count (c_min),
        .o_tick  (w_hour_tick)
    );
    //sec
    tick_counter #(
        .BIT_WIDTH(6),
        .TIMES(60)
    ) sec_counter (
        .clk     (clk),
        .reset   (reset),
        .clear   (i_clear),
        .i_tick  (w_sec_tick),
        .down_up (i_down_up),
        .run_stop(i_run_stop),
        .o_count (c_sec),
        .o_tick  (w_min_tick)
    );
    //msec
    tick_counter #(
        .BIT_WIDTH(7),
        .TIMES(100)
    ) msec_counter (
        .clk     (clk),
        .reset   (reset),
        .clear   (i_clear),
        .i_tick  (w_tick_100hz),
        .down_up (i_down_up),
        .run_stop(i_run_stop),
        .o_count (c_msec),
        .o_tick  (w_sec_tick)
    );

    tick_gen U_TICK_100Hz (
        .clk         (clk),
        .reset       (reset),
        .i_run_stop  (i_run_stop),
        .o_tick_100hz(w_tick_100hz)
    );

endmodule

module sum_clock (
    input [23:0] i_tick_data,
    input [23:0] i_set_data,
    output [23:0] o_sum_data
);
    //carry
    reg c_min, c_sec, c_msec;
    reg [7:0] r_sum_data_msec;
    reg [6:0] r_sum_data_sec;
    reg [6:0] r_sum_data_min;
    reg [5:0] r_sum_data_hour;

    assign o_sum_data = {
        r_sum_data_hour[4:0],
        r_sum_data_min[5:0],
        r_sum_data_sec[5:0],
        r_sum_data_msec[6:0]
    };

    always @(*) begin
        //msec
        if (i_tick_data[6:0] + i_set_data[6:0] > 7'd99) begin
            r_sum_data_msec = i_tick_data[6:0] + i_set_data[6:0] - 7'd99;
            c_msec = 1'b1;
        end else begin
            r_sum_data_msec = i_tick_data[6:0] + i_set_data[6:0];
            c_msec = 1'b0;
        end
        //sec
        if (i_tick_data[12:7] + i_set_data[12:7] + c_msec > 6'd59) begin
            r_sum_data_sec = i_tick_data[12:7] + i_set_data[12:7]  + c_msec - 6'd60;
            c_sec = 1'b1;
        end else begin
            r_sum_data_sec = i_tick_data[12:7] + i_set_data[12:7] + c_msec;
            c_sec = 1'b0;
        end
        //min
        if (i_tick_data[18:13] + i_set_data[18:13] + c_sec > 6'd59) begin
            r_sum_data_min = i_tick_data[18:13] + i_set_data[18:13]  + c_sec - 6'd60;
            c_min = 1'b1;
        end else begin
            r_sum_data_min = i_tick_data[18:13] + i_set_data[18:13] + c_sec;
            c_min = 1'b0;
        end
        //hour
        if (i_tick_data[23:19] + i_set_data[23:19] + c_min > 5'd23) begin
            r_sum_data_hour = i_tick_data[23:19] + i_set_data[23:19] + c_min - 5'd24;
        end else begin
            r_sum_data_hour = i_tick_data[23:19] + i_set_data[23:19] + c_min;
        end
    end


endmodule

module mux_4X1 (
    input [1:0] sel,
    input [23:0] i_sel0,
    input [23:0] i_sel1,
    input [23:0] i_sel2,
    input [23:0] i_sel3,
    output reg [23:0] o_mux
);
    always @(*) begin
        case (sel)
            2'b00: o_mux = i_sel0;
            2'b01: o_mux = i_sel1;
            2'b10: o_mux = i_sel2;
            2'b11: o_mux = i_sel3;
        endcase
    end
endmodule


module sw_to_bin (
    input  [7:0] i_sw,
    input  [1:0] set_time_mode,
    output [7:0] o_bin
);
    wire [3:0] r_digit_1, r_digit_10;
    reg [3:0] limit_top, limit_bottom;

    always @(*) begin
        case (set_time_mode)
            2'b00: begin
                limit_top = 4'ha;
                limit_bottom = 4'ha;
            end
            2'b01: begin
                limit_top = 4'h6;
                limit_bottom = 4'ha;
            end
            2'b10: begin
                limit_top = 4'h6;
                limit_bottom = 4'ha;
            end
            2'b11: begin
                limit_top = 4'h3;
                if (i_sw[7:4] == 4'h2) begin
                    limit_bottom = 4'h5;
                end else begin
                    limit_bottom = 4'ha;
                end
            end
        endcase
    end
    //checksw_data 0~9 
    assign r_digit_1 = (i_sw[3:0] < limit_bottom) ? i_sw[3:0] : 4'b0;
    assign r_digit_10 = (i_sw[7:4] < limit_top) ? i_sw[7:4] : 4'b0;

    assign o_bin = (r_digit_10 * 10) + r_digit_1;


endmodule

