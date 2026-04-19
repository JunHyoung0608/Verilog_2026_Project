// module spi_slave (
//     input              clk,
//     input              rst,
//     //spi_protocals
//     input              sclk,
//     input              cs_n,
//     input              mosi,
//     output logic       miso,
//     //slave I/O
//     input        [7:0] slv_tx_data,
//     output logic [7:0] slv_rx_data,
//     output logic       done
// );

//     typedef enum logic [2:0] {
//         IDLE  = 3'b00,
//         START,
//         DATA,
//         READY,
//         STOP
//     } spi_state_e;

//     spi_state_e state;

//     logic sclk_ff1, sclk_ff2, sclk_posedge, sclk_negedge;
//     logic cs_n_ff1, cs_n_ff2, start;
//     logic [7:0] tx_shift_reg, rx_shift_reg;
//     logic [3:0] bit_cnt;
//     logic [1:0] mode_reg;

//     //edge_deecter
//     always_ff @(posedge clk or posedge rst) begin
//         if (rst) begin
//             sclk_ff1 <= 0;
//             sclk_ff2 <= 0;
//             cs_n_ff1 <= 0;
//             cs_n_ff2 <= 0;
//         end else begin
//             sclk_ff1 <= sclk;
//             sclk_ff2 <= sclk_ff1;
//             cs_n_ff1 <= cs_n;
//             cs_n_ff2 <= cs_n_ff1;
//         end
//     end
//     assign sclk_posedge = (sclk_ff1 && ~sclk_ff2);
//     assign sclk_negedge = (~sclk_ff1 && sclk_ff2);
//     assign start        = (~cs_n && cs_n_ff1);

//     assign miso         = (state != IDLE)? tx_shift_reg[7] : 1'b1;;

//     always_ff @(posedge clk or posedge rst) begin
//         if (rst) begin
//             state        <= IDLE;
//             //miso         <= 1'b1;
//             done         <= 1'b0;
//             tx_shift_reg <= 0;
//             rx_shift_reg <= 0;
//             slv_rx_data  <= 0;
//             bit_cnt      <= 0;
//             mode_reg     <= 0;
//         end else begin
//             done <= 1'b0;
//             case (state)
//                 IDLE: begin
//                     //miso         <= 1'b1;
//                     rx_shift_reg <= 0;
//                     tx_shift_reg <= 0;
//                     mode_reg     <= 0;
//                     if (start) begin
//                         bit_cnt      <= 0;
//                         state        <= DATA;
//                         //miso         <= slv_tx_data[7];
//                         tx_shift_reg <= slv_tx_data;
//                     end
//                 end
//                 DATA: begin
//                     if (bit_cnt == 0) begin

//                         if (sclk_negedge) begin
//                             bit_cnt      <= bit_cnt + 1;
//                             rx_shift_reg <= {rx_shift_reg[6:0], mosi};
//                             mode_reg     <= 2'd1;

//                             tx_shift_reg <= {tx_shift_reg[6:0], 1'b0};
//                         end
//                         if (sclk_posedge) begin
//                             //bit_cnt <= bit_cnt + 1;
//                             rx_shift_reg <= {rx_shift_reg[6:0], mosi};
//                             //tx_shift_reg <= {tx_shift_reg[6:0], 1'b0};
//                             mode_reg <= 2'd1;
//                         end
//                     end else if (bit_cnt < 7) begin
//                         if (mode_reg == 1) begin
//                             if (sclk_negedge) begin
//                                 //miso         <= tx_shift_reg[7];
//                                 tx_shift_reg <= {tx_shift_reg[6:0], 1'b0};
//                             end
//                             if (sclk_posedge) begin
//                                 bit_cnt <= bit_cnt + 1;
//                                 rx_shift_reg <= {rx_shift_reg[6:0], mosi};
//                             end
//                         end else begin
//                             if (sclk_posedge) begin
//                                 //miso         <= tx_shift_reg[7];
//                                 tx_shift_reg <= {tx_shift_reg[6:0], 1'b0};
//                             end
//                             if (sclk_negedge) begin
//                                 bit_cnt <= bit_cnt + 1;
//                                 rx_shift_reg <= {rx_shift_reg[6:0], mosi};
//                             end
//                         end
//                     end else if (bit_cnt == 7) begin
//                         if (mode_reg == 1) begin
//                             if (sclk_posedge) begin
//                                 bit_cnt <= bit_cnt + 1;
//                                 slv_rx_data <= rx_shift_reg;
//                                 state <= STOP;
//                             end
//                             if (sclk_negedge) begin
//                                 //miso         <= tx_shift_reg[7];
//                                 tx_shift_reg <= {tx_shift_reg[6:0], 1'b0};
//                                 //state <= READY;
//                             end
//                         end else begin
//                             if (sclk_negedge) begin
//                                 bit_cnt <= bit_cnt + 1;
//                                 slv_rx_data <= rx_shift_reg;
//                                 state <= READY;
//                             end
//                             if (sclk_posedge) begin
//                                 //miso         <= tx_shift_reg[7];
//                                 tx_shift_reg <= {tx_shift_reg[6:0], 1'b0};
//                             end
//                         end
//                     end
//                 end
//                 READY: begin
//                     if (sclk_negedge) state <= STOP;
//                 end
//                 STOP: begin
//                     if (sclk_negedge) begin
//                         done <= 1'b1;
//                         //miso <= 1'b1;
//                         state <= IDLE;
//                         rx_shift_reg <= 0;
//                         tx_shift_reg <= 0;
//                     end
//                 end
//                 default: begin
//                     state <= IDLE;
//                 end
//             endcase
//         end
//     end

// endmodule

module spi_slave (
    input              clk,
    input              rst,
    input              sclk,
    input              cs_n,
    input              mosi,
    output logic       miso,
    input        [7:0] slv_tx_data,
    output logic [7:0] slv_rx_data,
    output logic       done
);

    logic [7:0] tx_sh, rx_sh, tx_sh0;
    logic [3:0] bit_cnt;

    // [1] MISO: CS_N이 떨어지자마자 MSB가 '조합 회로'로 바로 나가야 함 (지연 0)
    assign miso = (cs_n) ? 1'b1 : tx_sh[7];



    // [2] 전송 로직: Falling Edge에서 다음 비트 준비
    always_ff @(negedge sclk or posedge cs_n or posedge rst) begin
        if (rst) tx_sh <= 8'h00;
        else if (cs_n) tx_sh <= slv_tx_data;  // 대기 중엔 계속 로드
        else tx_sh <= {tx_sh[6:0], 1'b0};
    end

    // [3] 수신 로직: Rising Edge에서 샘플링
    always_ff @(posedge sclk or posedge cs_n or posedge rst) begin
        if (rst) begin
            rx_sh <= 0;
            slv_rx_data <= 0;
            bit_cnt <= 0;
            done <= 0;
        end else if (cs_n) begin
            bit_cnt <= 0;
            done <= 0;
            slv_rx_data <= rx_sh;
        end else begin
            // MOSI 샘플링
            rx_sh <= {rx_sh[6:0], mosi};

            if (bit_cnt == 4'd7) begin
                slv_rx_data <= {rx_sh[6:0], mosi};  // 8비트 완성 즉시 저장
                done        <= 1'b1;
                bit_cnt     <= 0;
            end else begin
                bit_cnt <= bit_cnt + 1;
                done    <= 1'b0;
            end
        end
    end
endmodule
