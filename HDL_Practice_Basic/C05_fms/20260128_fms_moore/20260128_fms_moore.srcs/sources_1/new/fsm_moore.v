`timescale 1ns / 1ps

module fsm_moore (
    input  clk,
    input  reset,
    input  sw,
    output led
);

    //state
    parameter S0 = 1'b0, S1 = 1'b1;

    //state variable
    reg currnet_state, next_state;

    //state register
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            currnet_state <= S0;
        end else begin
            currnet_state <= next_state;
        end
    end

    //next state CL
    always @(*) begin
        next_state = currnet_state;
        case (currnet_state)
            S0: begin
                if(sw) begin
                    next_state = S1;
                end
            end
            S1: begin
                if(!sw) begin
                    next_state = S0;
                end
            end
            default: next_state = currnet_state;
        endcase
    end

    //output CL
    assign led = (currnet_state == S1) ? 1'b1:1'b0;
endmodule


