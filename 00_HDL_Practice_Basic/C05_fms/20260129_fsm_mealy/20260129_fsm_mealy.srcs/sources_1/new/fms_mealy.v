`timescale 1ns / 1ps

module fms_mealy (
    input  clk,
    input  reset,
    input  din_bit,
    output dout_bit
);

    reg [2:0] currnet_state, next_state;

    parameter [2:0] start =3'd0, rd0_once = 3'd1, rd1_once = 3'd2, rd0_twice = 3'd3, rd1_twice = 3'd4;

    always @(posedge clk or reset) begin
        if (reset) begin
            currnet_state <= start;
        end else begin
            currnet_state <= next_state;
        end
    end

    always @(*) begin
        case (currnet_state)
            start:
            next_state = (din_bit == 1'b0) ? rd0_once:
                         (din_bit == 1'b1) ? rd1_once: start;
            rd0_once:
            next_state = (din_bit == 1'b0) ? rd0_twice: 
                         (din_bit == 1'b1) ? rd1_once: start;
            rd1_once:
            next_state = (din_bit == 1'b0) ? rd0_once:
                         (din_bit == 1'b1) ? rd1_twice: start;
            rd0_twice:
            next_state = (din_bit == 1'b0) ? rd0_twice:
                         (din_bit == 1'b1) ? rd1_once: start;
            rd1_twice:
            next_state = (din_bit == 1'b0) ? rd0_once:
                         (din_bit == 1'b1) ? rd1_twice: start;
            default: next_state = start;
        endcase
    end

    assign dout_bit = (((currnet_state == rd0_twice) && (din_bit == 1'b0) || 
                        (currnet_state == rd1_twice) && (din_bit == 1'b1))) ? 1'b1 : 1'b0;
endmodule
