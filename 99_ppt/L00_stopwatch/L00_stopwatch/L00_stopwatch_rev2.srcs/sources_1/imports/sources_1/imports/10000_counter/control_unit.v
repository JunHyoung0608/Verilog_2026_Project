`timescale 1ns / 1ps

`define MODE_CLOCK

module control_unit (
    input            clk,
    input            reset,
    input      [2:0] i_sw,
    input            i_mode_select,
    input            i_run_stop,
    input            i_clear,
    output reg       o_down_up,
    output reg [1:0] o_write_digit,
    output reg       o_read,
    output reg       o_run_stop,
    output reg       o_clear,
    output reg [1:0] o_display_sel,
    output reg [1:0] o_mode
);


    localparam [2:0] IDLE = 3'd0, 
                     CLOCK_CLEAR = 3'd1, CLOCK_SET0 = 3'd2, CLOCK_SET1 = 3'd3, CLOCK_RUN = 3'd4,
                     STOPWATCH_CLEAR = 3'd5, STOPWATCH_STOP = 3'd6,   STOPWATCH_RUN = 3'd7;

    //reg variable
    reg [2:0] current_st, next_st;


    //satate register SL
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_st <= IDLE;
        end else begin
            current_st <= next_st;
        end
    end

    //state
    always @(*) begin
        next_st = current_st;
        //i_mode_select
        if (i_mode_select) begin
            case (current_st)
                IDLE:
                if (i_sw[1:0] == 2'b01) next_st = CLOCK_CLEAR;
                else if (i_sw[1:0] == 2'b10) next_st = STOPWATCH_CLEAR;
                else next_st = current_st;
                CLOCK_SET0:
                if (i_sw[1:0] == 2'b010) next_st = STOPWATCH_CLEAR;
                else next_st = current_st;
                CLOCK_SET1:
                if (i_sw[1:0] == 2'b10) next_st = STOPWATCH_CLEAR;
                else next_st = current_st;
                STOPWATCH_STOP:
                if (i_sw[1:0] == 2'b01) next_st = CLOCK_CLEAR;
                else next_st = current_st;
            endcase
            //i_run_stop
        end else if (i_run_stop) begin
            case (current_st)
                //CLOCK
                CLOCK_SET0:     next_st = CLOCK_SET1;
                CLOCK_SET1:     next_st = CLOCK_RUN;
                CLOCK_RUN:      next_st = CLOCK_CLEAR;
                //STOPWATCH
                STOPWATCH_STOP: next_st = STOPWATCH_RUN;
                STOPWATCH_RUN:  next_st = STOPWATCH_STOP;
                default:        next_st = current_st;
            endcase
            //i_clear
        end else if (i_clear) begin
            case (current_st)
                CLOCK_SET0:     next_st = CLOCK_CLEAR;
                CLOCK_SET1:     next_st = CLOCK_CLEAR;
                CLOCK_RUN:      next_st = CLOCK_CLEAR;
                //STOPWATCH
                STOPWATCH_STOP: next_st = STOPWATCH_CLEAR;
                STOPWATCH_RUN:  next_st = STOPWATCH_CLEAR;
                default:        next_st = current_st;
            endcase
            //auto move state(clear)
        end else begin
            case (current_st)
                CLOCK_CLEAR:     next_st = CLOCK_SET0;
                STOPWATCH_CLEAR: next_st = STOPWATCH_STOP;
                default:         next_st = current_st;
            endcase
        end
    end

    //output
    always @(*) begin
        //init
        o_down_up = 0;
        o_write_digit = 2'b00;
        o_read = 1'b0;
        o_run_stop = 1'b0;
        o_clear = 1'b0;
        o_display_sel = 2'b00;
        o_mode = 2'b0;
        //DOWN_UP: DOWN = 1 UP = 0
        //WRITE_DIGIT: [1] hour,min [0] sec,msec
        //RUN_STOP: RUN = 1 STOP = 0
        //o_display_sel: tick_count = 0, setting_time = 1, read_data = 2, sum_time = 3
        case (current_st)
            CLOCK_CLEAR: begin
                o_clear = 1'b1;
                o_mode  = 2'b01;
            end
            CLOCK_RUN: begin
                o_run_stop = 1'b1;
                o_mode = 2'b01;
                o_display_sel = 2'b11;
            end
            CLOCK_SET0: begin
                o_write_digit = 2'b10;
                o_display_sel = 2'b01;
                o_mode = 2'b01;
            end
            CLOCK_SET1: begin
                o_write_digit = 2'b01;
                o_display_sel = 2'b01;
                o_mode = 2'b01;
            end
            STOPWATCH_CLEAR: begin
                o_clear = 1'b1;
                o_mode  = 2'b10;
            end
            STOPWATCH_RUN: begin
                o_run_stop = 1'b1;
                o_write_digit = 2'b11;
                o_mode = 2'b10;
                if (i_sw[2]) begin
                    o_down_up = 1'b1;
                end else begin
                    o_down_up = 1'b0;
                end
            end
            STOPWATCH_STOP: begin
                o_read = 1'b1;
                o_display_sel = 2'b10;
                o_mode = 2'b10;
            end
            default: begin
                o_write_digit = 2'b00;
                o_read = 1'b0;
                o_run_stop = 1'b0;
                o_clear = 1'b0;
                o_display_sel = 2'b00;
                o_mode = 2'b0;
            end
        endcase
    end
endmodule
