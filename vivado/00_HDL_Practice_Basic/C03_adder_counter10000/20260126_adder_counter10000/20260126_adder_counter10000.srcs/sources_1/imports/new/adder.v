`timescale 1ns / 1ps

module top_adder (
    input        clk,
    input        reset,
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] fnd_data,
    output [3:0] fnd_digit
);

    wire [7:0] w_sum;
    wire       w_c;
    wire [13:0] w_counter_out;

    fnd_controller u_fnd_cntl (
        .clk      (clk),
        .reset    (reset),
        .sum      (w_counter_out),
        .fnd_data (fnd_data),
        .fnd_digit(fnd_digit)
    );

    counter_1000 u_counter_1000(
    .clk(clk),
    .reset(reset),
    .counter_out(w_counter_out)
);


    full_adder_8bit u_adder (
        .a    (a),
        .b    (b),
        .sum  (w_sum),
        .carry(w_c)
    );

endmodule


module counter_1000 (
    input         clk,
    input         reset,
    output [13:0] counter_out
);

    reg [13:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 14'b0;
        end else begin
            if (counter == 14'd9999) begin
                counter <= 14'b0;
            end else begin
                counter <= counter + 14'b1;
            end
        end
    end

    assign counter_out = counter;

endmodule

module full_adder_8bit (
    input  [7:0] a,
    input  [7:0] b,
    //    input        c_in,
    output [7:0] sum,
    output       carry
);

    wire c_out_fa4;

    full_adder_4bit u_fa_4bit_0 (
        .a    (a[3:0]),
        .b    (b[3:0]),
        .c_in (1'b0),
        .sum  (sum[3:0]),
        .carry(c_out_fa4)
    );

    full_adder_4bit u_fa_4ibt_1 (
        .a    (a[7:4]),
        .b    (b[7:4]),
        .c_in (c_out_fa4),
        .sum  (sum[7:4]),
        .carry(carry)
    );

endmodule



module full_adder_4bit (
    input [3:0] a,
    input [3:0] b,
    input c_in,
    output [3:0] sum,
    output carry
);

    wire carry_fa0, carry_fa1, carry_fa2, carry_fa3;

    full_adder U_FA0 (
        .a    (a[0]),
        .b    (b[0]),
        .c_in (c_in),
        .sum  (sum[0]),
        .carry(carry_fa0)
    );

    full_adder U_FA1 (
        .a    (a[1]),
        .b    (b[1]),
        .c_in (carry_fa0),
        .sum  (sum[1]),
        .carry(carry_fa1)
    );

    full_adder U_FA2 (
        .a    (a[2]),
        .b    (b[2]),
        .c_in (carry_fa1),
        .sum  (sum[2]),
        .carry(carry_fa2)
    );

    full_adder U_FA3 (
        .a    (a[3]),
        .b    (b[3]),
        .c_in (carry_fa2),
        .sum  (sum[3]),
        .carry(carry)
    );


endmodule

module full_adder (
    input  a,
    input  b,
    input  c_in,
    output sum,
    output carry
);
    wire sum_ha0;
    wire carry_ha0, carry_ha1;

    half_adder U_HA0 (
        .a    (a),
        .b    (b),
        .sum  (sum_ha0),
        .carry(carry_ha0)
    );

    half_adder U_HA1 (
        .a    (sum_ha0),
        .b    (c_in),
        .sum  (sum),
        .carry(carry_ha1)
    );

    assign carry = carry_ha1 | carry_ha0;

endmodule


module half_adder (
    input  a,
    input  b,
    output sum,
    output carry
);

    assign sum   = a ^ b;
    assign carry = a & b;

    // xor u1(sum0, a, b);
    // xor  u1(sum1, a, b);
    // and (carry, a, b);


endmodule
