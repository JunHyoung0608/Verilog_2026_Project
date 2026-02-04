`timescale 1ns / 1ps

module detect0101_mealy(
    input clk,
    input reset,
    input din_bit,
    output dout_bit
    );

    reg [1:0] current_s, next_s;

    parameter [1:0] S0 = 2'd0,
                    S1 = 2'd1,
                    S2 = 2'd2,
                    S3 = 2'd3;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_s <= S0;
        end else begin
            current_s <= next_s;
        end
    end

    always @(*) begin
        case(current_s)
            S0: if (din_bit == 1'b0) next_s = S1;
                else                 next_s = current_s;  
            S1: if (din_bit == 1'b0) next_s = current_s;
                else                 next_s = S2;
            S2: if (din_bit == 1'b0) next_s = S3;
                else                 next_s = S0;
            S3: if (din_bit == 1'b0) next_s = S1;
                else                 next_s = S0;
            default: next_s = current_s;
        endcase
    end

    assign dout_bit = ((current_s == S3) && (din_bit == 1'b1))? 1'b1 : 1'b0;

endmodule


module detect0101_moore(
    input clk,
    input reset,
    input din_bit,
    output dout_bit
    );

    reg [2:0] current_s, next_s;

    parameter [2:0] S0 = 3'd0,
                    S1 = 3'd1,
                    S2 = 3'd2,
                    S3 = 3'd3,
                    S4 = 3'd4;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_s <= S0;
        end else begin
            current_s <= next_s;
        end
    end

    always @(*) begin
        case(current_s)
            S0: if (din_bit == 1'b0) next_s = S1;
                else                 next_s = current_s;  
            S1: if (din_bit == 1'b0) next_s = current_s;
                else                 next_s = S2;
            S2: if (din_bit == 1'b0) next_s = S3;
                else                 next_s = S0;
            S3: if (din_bit == 1'b0) next_s = S1;
                else                 next_s = S4;
            S4: if (din_bit == 1'b0) next_s = S1;
                else                 next_s = S0;
            default: next_s = current_s;
        endcase
    end

    assign dout_bit = (current_s == S4)? 1'b1 : 1'b0;
endmodule