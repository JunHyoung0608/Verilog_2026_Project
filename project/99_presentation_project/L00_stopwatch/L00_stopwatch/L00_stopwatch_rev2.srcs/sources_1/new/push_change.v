`timescale 1ns / 1ps

module push_change (
    input clk,
    input reset,
    input btn,
    output reg d_out
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            d_out <= 1'b0;
        end else begin
            if (btn) begin
                d_out = ~d_out;
            end
        end
    end
endmodule
