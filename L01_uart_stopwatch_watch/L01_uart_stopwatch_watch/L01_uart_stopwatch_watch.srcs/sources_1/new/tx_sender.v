`timescale 1ns / 1ps

module tx_sender (
    input clk,
    input rst,
    input send_command,
    input [31:0] i_sender_data,
    input i_sender_done,
    output [3:0] o_tx_data,
    output tx_done
);
localparam READY = 1'b0, SAND = 1'b1;


reg c_state, n_state;
reg [3:0] counter_reg, counter_next;
reg [7:0] tx_data_reg, tx_data_next;
reg tx_done_reg, tx_done_next;


assign o_tx_data = tx_data_reg[31:28];
assign tx_done = tx_done_reg;


    always @(posedge clk or rst) begin
        if(rst) begin
            c_state <= READY;
            counter_reg <= 4'b0;
            tx_data_reg <= i_sender_data[31:28];
        end else begin
            c_state <= n_state;
            counter_reg <= counter_next;
            tx_data_reg <= tx_data_next;
        end
    end

    always @(*) begin
        n_state = c_state;
        tx_data_next = tx_data_reg;
        counter_next = counter_reg;
        tx_done_next = tx_done_reg;
        if (c_state == READY)
            tx_data_next = i_sender_data[31:28];
            counter_next = 4'b0;
            if (send_command) begin
                n_state = SAND;
                tx_data_next = i_sender_data[31:28];
                tx_done_next = 1'b1;
            end
        else begin
            if (i_sender_done) begin
                tx_done_next = 1'b1;
                tx_data_next = {tx_data_reg[27:0],4'b0};
                counter_next = counter_reg + 4'b1;
            end else begin
                tx_done_next = 1'b0;
            end

        end
    end
    

endmodule
