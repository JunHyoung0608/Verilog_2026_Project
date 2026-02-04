`timescale 1ns / 1ps

module top_10000_counter (
    input        clk,
    input        reset,
    output [7:0] fnd_data,
    output [3:0] fnd_digit
);

    wire w_tick_10hz;
    wire [13:0] w_counter_out;

    fnd_controller u_fnd_cntl (
        .clk        (clk),
        .reset      (reset),
        .fnd_in_data(w_counter_out),
        .fnd_data   (fnd_data),
        .fnd_digit  (fnd_digit)
    );

    counter_10000 u_counter_10000 (
        .clk(clk),
        .reset(reset),
        .i_tick(w_tick_10hz),
        .counter_out(w_counter_out)
    );

    tick_generator u_tick_gen (
        .clk(clk),
        .reset(reset),
        .o_tick_10hz(w_tick_10hz)
    );

endmodule


module counter_10000 (
    input         clk,
    input         reset,
    input         i_tick,
    output [13:0] counter_out
);

    reg [13:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 14'b0;
        end else begin
            if (i_tick) begin
                counter <= counter + 14'b1;
                if (counter == 14'd9999) begin
                counter <= 14'b0;
                end
            end
        end
    end

    assign counter_out = counter;

endmodule


