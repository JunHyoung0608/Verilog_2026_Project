`timescale 1ns / 1ps

// `define LED_CL 1


`ifdef LED_CL
module led_on_3bit (
    input            clk,
    input            reset,
    input      [2:0] sw,
    output reg [2:0] led
);

    reg [2:0] currnet_state, next_state;
    parameter [2:0] S0 = 3'd0, S1 = 3'd1, S2 = 3'd2, S3 = 3'd3, S4 = 3'd4;
    
    //state register SL
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            currnet_state <= S0;
        end else begin
            currnet_state <= next_state;
        end
    end

    //next_CL
    always @(*) begin
        next_state = currnet_state;
        case (currnet_state)
            S0: next_state = (sw == 3'b001) ? S1 : 
                             (sw == 3'b010) ? S2 : currnet_state;
            S1: next_state = (sw == 3'b010) ? S2 : currnet_state;
            S2: next_state = (sw == 3'b100) ? S3 : currnet_state;
            S3: next_state = (sw == 3'b000) ? S0 :
                             (sw == 3'b011) ? S1 : 
                             (sw == 3'b111) ? S4 : currnet_state;
            S4: next_state = (sw == 3'b000) ? S0 : currnet_state;
            default: next_state = currnet_state;
        endcase
    end
    
    //led_on
    always @(*) begin
        case (currnet_state)
            S0: led = 3'b000;
            S1: led = 3'b001;
            S2: led = 3'b010;
            S3: led = 3'b100;
            S4: led = 3'b111;
            default: led = 3'b000;
        endcase
    end
endmodule
`else
module led_on_3bit (
    input        clk,
    input        reset,
    input  [2:0] sw,
    output [2:0] led
);

    reg [2:0] currnet_state, next_state;

    parameter [2:0] S0 = 3'd0, S1 = 3'd1, S2 = 3'd2, S3 = 3'd3, S4 = 3'd4;
    
    //state register SL
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            currnet_state <= S0;
        end else begin
            currnet_state <= next_state;
        end
    end

    //next_CL
    always @(*) begin
        next_state = currnet_state;
        case (currnet_state)
            S0: next_state = (sw == 3'b001) ? S1 : 
                             (sw == 3'b010) ? S2 : currnet_state;
            S1: next_state = (sw == 3'b010) ? S2 : currnet_state;
            S2: next_state = (sw == 3'b100) ? S3 : currnet_state;
            S3: next_state = (sw == 3'b000) ? S0 :
                             (sw == 3'b011) ? S1 : 
                             (sw == 3'b111) ? S4 : currnet_state;
            S4: next_state = (sw == 3'b000) ? S0 : currnet_state;
            default: next_state = currnet_state;
        endcase
    end

    //led_on
    reg [2:0] currnet_led, next_led;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            currnet_led <= 3'b000;
        end else begin
            currnet_led <= next_led;
        end
    end
    
    always @(*) begin
        next_led = currnet_led;
        case (currnet_state)
            S0: next_led = 3'b000;
            S1: next_led = 3'b001;
            S2: next_led = 3'b010;
            S3: next_led = 3'b100;
            S4: next_led = 3'b111;
            default: next_led = 3'b000;
        endcase
    end

    assign led = currnet_led;

endmodule
`endif