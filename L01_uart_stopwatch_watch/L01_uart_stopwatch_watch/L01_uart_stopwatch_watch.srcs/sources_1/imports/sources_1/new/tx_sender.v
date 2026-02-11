`timescale 1ns / 1ps

module tx_sender #(
    parameter SEND_DATA_WITCH = 8
) (
    input         clk,
    input         rst,
    input         send_start,
    input  [31:0] i_sender_data,
    input         i_tx_busy,
    input         i_tx_done,
    output [ 7:0] o_send_data,
    output        o_send_done
);
    localparam [1:0] READY = 2'd0, START = 2'd1, ENCODER = 2'd2, STOP = 2'd3;
    localparam [7:0] ASCII_0 = 8'h30, ASCII_LF = 8'h0a;
    localparam [39:0] TIME_TEXT = {
        8'h54, 8'h49, 8'h4d, 8'h45, 8'h3a
    };  //[T,I,M,E,:]

    reg [1:0] c_state, n_state;
    reg [2:0] text_cnt_reg, text_cnt_next;
    reg [39:0] text_time_reg, text_time_next;
    reg [2:0] send_cnt_reg, send_cnt_next;
    reg [31:0] save_data_reg, save_data_next;
    reg [7:0] put_data_reg, put_data_next;
    reg done_reg, done_next;


    assign o_send_data = put_data_reg;
    assign o_send_done = done_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            c_state       <= READY;
            text_cnt_reg  <= 2'b0;
            text_cnt_reg <= TIME_TEXT;
            send_cnt_reg  <= 3'b0;
            save_data_reg <= 32'b0;
            put_data_reg  <= 8'b0;
            done_reg      <= 1'b0;
        end else begin
            c_state       <= n_state;
            text_cnt_reg  <= text_cnt_next;
            text_time_reg <= text_time_next;
            send_cnt_reg  <= send_cnt_next;
            save_data_reg <= save_data_next;
            put_data_reg  <= put_data_next;
            done_reg      <= done_next;
        end
    end

    always @(*) begin
        n_state        = c_state;
        text_cnt_next  = text_cnt_reg;
        text_time_next = text_time_reg;
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
                text_cnt_next = 3'b0;
                text_time_next = TIME_TEXT;
                if ((i_tx_busy == 1'b0) && (send_start)) begin
                    n_state = START;
                end
            end
            START: begin
                put_data_next = 8'b0;
                done_next     = 1'b0;
                if (text_cnt_reg == 3'd5) begin
                    n_state = ENCODER;
                end
                if (text_cnt_reg == 3'd0) begin
                    put_data_next = text_time_reg[39:32];
                    text_time_next = {text_time_reg[31:0],8'b0};
                    done_next = 1'b1;
                    text_cnt_next = text_cnt_reg + 3'b1;
                end else begin
                    if (i_tx_done) begin
                        put_data_next = text_time_reg[39:32];
                        text_time_next = {text_time_reg[31:0],8'b0};
                        done_next = 1'b1;
                        text_cnt_next = text_cnt_reg + 3'b1;
                    end
                end
            end
            ENCODER: begin
                put_data_next = 8'b0;
                done_next     = 1'b0;
                if (send_cnt_reg == SEND_DATA_WITCH) begin
                    n_state = STOP;
                end else if (i_tx_done) begin
                    put_data_next  = ASCII_0 + {4'b0, save_data_reg[31:28]};
                    save_data_next = {save_data_reg[27:0], 4'b0};
                    send_cnt_next  = send_cnt_reg + 3'd1;
                    done_next = 1'b1;
                end
            end
            STOP: begin
                put_data_next = 8'b0;
                done_next     = 1'b0;
                if (i_tx_done) begin
                    n_state = READY;
                    put_data_next = ASCII_LF;
                    done_next = 1'b1;
                end
            end
        endcase
    end


endmodule
