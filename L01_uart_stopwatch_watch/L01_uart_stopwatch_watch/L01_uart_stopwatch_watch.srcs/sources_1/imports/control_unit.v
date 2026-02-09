`timescale 1ns / 1ps


module control_unit (
    input        clk,
    input        rst,
    input        i_clear,
    input        i_run_stop,
    input        i_up,
    input        i_down,
    input        i_mode,
    output [1:0] o_clear,
    output       o_run_stop,
    output       o_down_up,
    output [1:0] o_time_modify,
    output       o_mode,
    output [2:0] test_mode
);


    //mode=> 0: stopwatch 1: watch
    //----------------------stopwatch--------------------
    //clear=> 0: off 1: on
    //run_stop=> 0: stop 1:run
    //down_up=> 0: up 1:down
    //----------------------watch--------------------
    //time_modify=> [0]:minus [1] plus
<<<<<<< HEAD
    localparam [2:0] IDLE = 3'd0, STOPWATCH_CLEAR = 3'd1,STOPWATCH_STOP=3'd2, STOPWATCH_RUN=3'd3, WATCH = 3'd4;
=======
    localparam [2:0] IDLE = 3'd0, STOPWATCH_STOP=3'd1, STOPWATCH_RUN=3'd2, WATCH = 3'd3;
>>>>>>> cc80950e3a5adc7b2e0a8044a772210a9e73d1f9
    reg [2:0] c_state, n_state;
    reg [1:0] clear_reg, clear_next;
    reg run_stop_reg, run_stop_next;
    reg down_up_reg, down_up_next;
    reg [1:0] time_modify_reg, time_modify_next;
    reg mode_next, mode_reg;

    assign o_clear = clear_reg;
    assign o_run_stop = run_stop_reg;
    assign o_down_up  = down_up_reg;
    assign o_time_modify = time_modify_reg;
    assign o_mode    = mode_reg;


    assign test_mode = c_state;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            c_state <= IDLE;
            clear_reg <= 2'b0;
            run_stop_reg <= 1'b0;
            down_up_reg <= 1'b0;
            time_modify_reg <= 2'b0;
            mode_reg <= 2'b0;
        end else begin
            c_state <= n_state;
            clear_reg <= clear_next;
            run_stop_reg <= run_stop_next;
            down_up_reg <= down_up_next;
            time_modify_reg <= time_modify_next;
            mode_reg <= mode_next;
        end
    end

    //move state
    always @(*) begin
        n_state = c_state;
        case (c_state)
            IDLE: begin
<<<<<<< HEAD
                if (i_mode) begin
                    n_state = WATCH;
                end else begin
                    n_state = STOPWATCH_STOP;
                end
            end
            STOPWATCH_CLEAR: begin
                n_state = STOPWATCH_STOP;
            end
            STOPWATCH_STOP: begin
                if (i_mode) begin
                    n_state = WATCH;
                end else if (i_clear) begin
                    n_state = STOPWATCH_CLEAR;
=======
                n_state = STOPWATCH_STOP;
            end
            STOPWATCH_STOP: begin
                if (i_mode) begin
                        n_state = WATCH;
>>>>>>> cc80950e3a5adc7b2e0a8044a772210a9e73d1f9
                end else if (i_run_stop) begin
                    n_state = STOPWATCH_RUN;
                end 
            end
            STOPWATCH_RUN: begin
                if (i_mode) begin
<<<<<<< HEAD
                    n_state = WATCH;
                end else if (i_clear) begin
                    n_state = STOPWATCH_CLEAR;
=======
                        n_state = WATCH;
>>>>>>> cc80950e3a5adc7b2e0a8044a772210a9e73d1f9
                end else if (i_run_stop) begin
                    n_state = STOPWATCH_STOP;
                end
            end
            WATCH: begin
                if (i_mode == 1'b0) begin
<<<<<<< HEAD
                    n_state = STOPWATCH_CLEAR;
=======
                    n_state = STOPWATCH_STOP;
>>>>>>> cc80950e3a5adc7b2e0a8044a772210a9e73d1f9
                end
            end
        endcase
    end

    //output
    //mode=> 0: stopwatch 1: watch
    //----------------------stopwatch--------------------
    //clear=> [0]: clear stopwatch 1: clear watch
    //run_stop=> 0: stop 1:run
    //down_up=> 0: up 1:down
    //----------------------watch--------------------
    //time_modify=> [0]:minus [1] plus
    always @(*) begin
        clear_next       = clear_reg;
        run_stop_next    = run_stop_reg;
        down_up_next     = down_up_reg;
        time_modify_next = time_modify_reg;
        mode_next        = mode_reg;

        //mode_reg
        if (c_state == WATCH) begin
            mode_next = 1'b1;
        end else begin
            mode_next = 1'b0;
            if (i_clear) begin
                clear_next = 2'b1;
            end
        end
        //other
        case (c_state)
            IDLE: begin
                clear_next    = 2'b11;
                run_stop_next = 1'b0;
                down_up_next  = 1'b0;
                time_modify_next = 2'b0;
            end
            STOPWATCH_STOP: begin
                clear_next    = 2'b0;
                run_stop_next = 1'b0;
                if (i_down) begin
                    down_up_next = ~down_up_reg;
                end
                time_modify_next = 2'b0;
            end
            STOPWATCH_RUN: begin
                clear_next    = 2'b0;
                run_stop_next = 1'b1;
                if (i_down) begin
                    down_up_next = 1'b1;
                end else if (i_up) begin
                    down_up_next = 1'b0;
                end
                time_modify_next = 2'b0;
            end
            WATCH: begin
                if (i_clear) begin
                    clear_next = 2'b11;
                end else begin
                    clear_next = 2'b01;
                end
                run_stop_next = 1'b0;
                down_up_next  = 1'b0;
                if (i_up) begin
                    time_modify_next = 2'b10;
                end else if (i_down) begin
                    time_modify_next = 2'b01;
                end else begin
                    time_modify_next = 2'b0;
                end
            end
        endcase
    end


endmodule
