`timescale 1ns / 1ps

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


endmodule


