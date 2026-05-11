module spi_slave (
    input              clk,
    input              rst,
    //spi_protocals
    input              sclk,
    input              cs_n,
    input              mosi,
    output logic       miso,
    //slave I/O
    input        [7:0] slv_tx_data,
    output logic [7:0] slv_rx_data,
    output logic       done
);

    typedef enum logic [1:0] {
        IDLE  = 2'b00,
        START,
        DATA,
        STOP
    } spi_state_e;

    spi_state_e state;

    logic sclk_ff1, sclk_posedge, sclk_negedge;
    logic cs_n_ff1, start;
    logic [7:0] tx_shift_reg, rx_shift_reg;
    logic [2:0] bit_cnt;
    logic [1:0] mode_reg;

    //edge_deecter
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            sclk_ff1 <= 0;
            cs_n_ff1 <= 0;
        end else begin
            sclk_ff1 <= sclk;
            cs_n_ff1 <= cs_n;
        end
    end
    assign sclk_posedge = (sclk && ~sclk_ff1);
    assign sclk_negedge = (~sclk && sclk_ff1);
    assign start        = (~cs_n && cs_n_ff1);

    assign miso         = tx_shift_reg[7];

always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state        <= IDLE;
            done         <= 1'b0;
            tx_shift_reg <= 8'h0;
            rx_shift_reg <= 8'h0;
            slv_rx_data  <= 8'h0;
            bit_cnt      <= 3'd0;
        end else begin
            done <= 1'b0;
            
            case (state)
                IDLE: begin
                    if (start) begin
                        tx_shift_reg <= slv_tx_data;
                        bit_cnt      <= 3'd0;
                        state        <= DATA;
                    end
                end

                DATA: begin
                    // MOSI 샘플링 (Mode 0: Rising Edge)
                    if (sclk_posedge) begin
                        rx_shift_reg <= {rx_shift_reg[6:0], mosi};
                    end
                    
                    // MISO 업데이트 (Mode 0: Falling Edge)
                    if (sclk_negedge) begin
                        if (bit_cnt == 3'd7) begin
                            slv_rx_data <= {rx_shift_reg[6:0], mosi}; // 마지막 비트 처리
                            state <= STOP;
                        end else begin
                            tx_shift_reg <= {tx_shift_reg[6:0], 1'b0};
                            bit_cnt <= bit_cnt + 1;
                        end
                    end
                end

                STOP: begin
                    // CS_N이 올라가거나 전송이 완전히 끝났을 때
                    if (cs_n) begin
                        done  <= 1'b1;
                        state <= IDLE;
                    end
                end
            endcase
        end
    end

endmodule
