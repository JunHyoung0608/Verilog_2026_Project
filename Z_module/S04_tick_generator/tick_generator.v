`timescale 1ns / 1ps
`define tick_count 10

//10hz
module tick_generator (
    input      clk,
    input      reset,
    output reg o_tick_10hz
);

    reg [$clog2(`tick_count)-1:0] r_counter;

    //r_counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            r_counter <= 0;
        end else begin
            if (r_counter == (`tick_count - 1)) begin
                r_counter <= 0;
            end else begin
                r_counter <= r_counter + 1;
            end
        end
    end

    //o_tick_counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            o_tick_10hz <= 1'b0;
        end else begin
            if (r_counter == (`tick_count - 1)) begin
                o_tick_10hz <= 1'b1;
            end else begin
                o_tick_10hz <= 1'b0;
            end
        end
    end

endmodule

