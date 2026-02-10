`timescale 1ns / 1ps

module tx_sender #(
    parameter SEND_COUNT = 3'd7
)(
    input         clk,
    input         rst,
    input         send_start,
    input  [31:0] i_sender_data,
    input         i_tx_busy,
    input         i_tx_done,
    output [ 7:0] o_tx_data,
    output        tx_done
);
    localparam READY = 1'd0, ENCODER = 1'd1;
    localparam [7:0] ASCII_0 = 8'h30;

    reg c_state, n_state;
    reg [2:0] send_cnt_reg, send_cnt_next;
    reg [31:0] save_data_reg, save_data_next;
    reg [7:0] put_data_reg, put_data_next;
    reg done_reg, done_next;


    assign o_tx_data = put_data_reg;
    assign tx_done   = done_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            c_state       <= READY;
            send_cnt_reg  <= 3'b0;
            save_data_reg <= 32'b0;
            put_data_reg  <= 8'b0;
            done_reg      <= 1'b0;
        end else begin
            c_state       <= n_state;
            send_cnt_reg  <= send_cnt_next;
            save_data_reg <= save_data_next;
            put_data_reg  <= put_data_next;
            done_reg      <= done_next;
        end
    end

    always @(*) begin
        n_state        = c_state;
        send_cnt_next  = send_cnt_reg;
        save_data_next = save_data_reg;
        put_data_next  = put_data_reg;
        done_next      = done_reg;
        case (c_state)
            READY: begin
                send_cnt_next  = 3'b0;
                save_data_next = i_sender_data;
                put_data_next  = 8'b0;
                done_next      = 1'b0;
                if ((i_tx_busy == 1'b0) && (send_start)) begin
                    n_state = ENCODER;
                    if (save_data_reg[31:28] <= 4'd9)
                        put_data_next = ASCII_0 + save_data_reg[31:28];
                    else put_data_next = 8'h0;
                    done_next = 1'b1;
                end
            end
            ENCODER: begin
                put_data_next = 8'b0;
                done_next     = 1'b0;
                if (send_cnt_reg == SEND_COUNT) begin
                    n_state = READY;
                end else if ((i_tx_busy == 1'b0) && (i_tx_done)) begin
                    if (save_data_reg[31:28] <= 4'd9) begin
                        put_data_next  = ASCII_0 + save_data_reg[31:28];
                        save_data_next = {save_data_reg[31:28], 4'b0};
                        send_cnt_next  = send_cnt_reg + 3'd1;
                    end else begin
                        put_data_next = 8'h0;
                    end
                    done_next = 1'b1;
                end
            end
        endcase
    end


endmodule
