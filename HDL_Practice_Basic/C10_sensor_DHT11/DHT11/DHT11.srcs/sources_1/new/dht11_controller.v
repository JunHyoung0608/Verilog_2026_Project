`timescale 1ns / 1ps

module dht11_controller (
    input         clk,
    input         rst,
    input         start,
    output [15:0] humidity,
    output [15:0] temperature,
    output        dht11_done,
    output        dht11_valid,
    output [ 3:0] debug,
    inout         dhtio
);
    wire tick_10us;

    tick_gen #(
        .CLK      (100_000_000),
        .FREQUENCY(100_000)
    ) U_TICK_10US (
        .clk       (clk),
        .reset     (rst),
        .i_run_stop(1),
        .o_tick    (tick_10us)
    );

    parameter [2:0] IDLE = 0, START = 1, WAIT = 2, SYNC_L = 3, SYNC_H = 4, 
                    DATA_SYNC = 5, DATA_C = 6, STOP = 7;
    reg [2:0] c_state, n_state;
    reg dhtio_reg, dhtio_next;
    //for 19msec count by 10usec tick
    reg [$clog2(1900)-1:0] tick_cnt_reg, tick_cnt_next;
    reg io_sel_reg, io_sel_next;

    assign dhtio = (io_sel_reg) ? dhtio_reg : 1'bz;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            c_state      <= 3'b0;
            dhtio_reg    <= 1'b1;
            tick_cnt_reg <= 0;
            io_sel_reg   <= 1'b1;
        end else begin
            c_state      <= n_state;
            dhtio_reg    <= dhtio_next;
            tick_cnt_reg <= tick_cnt_next;
            io_sel_reg   <= io_sel_next;
        end
    end

    always @(*) begin
        n_state       = c_state;
        dhtio_next    = dhtio_reg;
        tick_cnt_next = tick_cnt_reg;
        io_sel_next   = io_sel_reg;
        case (c_state)
            IDLE: begin
                if (start) begin
                    n_state = START;
                end
            end
            START: begin
                dhtio_next = 1'b0;
                if (tick_10us) begin
                    tick_cnt_next = tick_cnt_reg + 1;
                    if (tick_cnt_reg == 1900) begin
                        n_state = WAIT;
                        tick_cnt_next = 0;
                    end
                end
            end
            WAIT: begin
                dhtio_next = 1'b1;
                if (tick_10us) begin
                    tick_cnt_next = tick_cnt_reg + 1;
                    if (tick_cnt_reg == 3) begin
                        n_state     = SYNC_L;
                        io_sel_next = 1'b0;
                    end
                end
            end
            SYNC_L: begin
                if (tick_10us) begin
                    if (dhtio == 1) begin
                        n_state = SYNC_H;
                    end
                end
            end
            SYNC_H: begin
                if (tick_10us) begin
                    if (dhtio == 0) begin
                        n_state = DATA_SYNC;
                    end
                end
            end
            DATA_SYNC: begin
                if (tick_10us) begin
                    if (dhtio == 1) begin
                        n_state = DATA_C;
                    end
                end
            end
            DATA_C: begin
                if (tick_10us) begin
                    if (dhtio == 1) begin
                        tick_cnt_next = tick_cnt_reg + 1;

                    end else begin
                        n_state = STOP;
                    end
                end
            end
            STOP: begin
                if (tick_10us) begin
                    tick_cnt_next = tick_cnt_reg + 1;
                    if (tick_cnt_reg == 5) begin
                        io_sel_next = 1'b1;
                        dhtio_next  = 1'b1;
                        n_state     = IDLE;
                    end
                end
            end
        endcase
    end

endmodule
