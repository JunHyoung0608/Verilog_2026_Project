`timescale 1ns / 1ps


module tb_adder ();

    // tb_adder local variabel
    reg [7:0] a, b;
    // reg c_in;
    wire [7:0] sum;
    wire carry;


    full_adder_8bit dut(
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );


    integer i = 0, j = 0;

    initial begin
        #0;
        a = 8'b0;
        b = 8'b0;

        #10
        for (i=0;i<256;i=i+1) begin
            for (j=0;j<256;j=j+1)begin
                a = i;
                b = j;

                #10;
            end

        end
        

        $stop;
    end


endmodule
