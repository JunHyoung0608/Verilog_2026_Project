`timescale 1ns / 1ps

module led_on (
    input            clk,
    input            reset,
    input      [2:0] sw,
    output reg [1:0] led
);
    //state
    reg [1:0] currnet_state, next_state;
    parameter [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            currnet_state <= S0;
        end else begin
            currnet_state <= next_state;
        end
    end

    always @(*) begin
        // this always initialize
        next_state = currnet_state;
        case (currnet_state)
            S0: next_state = (sw == 3'b001) ? S1 : S0;
            S1: next_state = (sw == 3'b010) ? S2 : S1;
            S2: next_state = (sw == 3'b100) ? S0 : S2;
            default: next_state = currnet_state;
        endcase
    end

    // //led_on
    // assign led =(currnet_state == S2)? 2'b11 :
    //             (currnet_state == S1)? 2'b01 :
    //             2'b00;
    always @(*) begin
        case (currnet_state)
            S0: led = 2'b00;
            S1: led = 2'b01;
            S2: led = 2'b11;
            default: led = 2'b00;
        endcase
    end

endmodule
