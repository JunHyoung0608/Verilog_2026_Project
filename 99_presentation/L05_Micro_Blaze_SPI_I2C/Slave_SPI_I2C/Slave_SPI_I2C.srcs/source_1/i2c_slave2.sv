`timescale 1ns / 1ps

module i2c_slave2 (
    input logic clk,
    input logic reset,

    // external ic2 port
    input logic scl,
    inout logic sda,

    // internal port
    output logic [7:0] rx_data,
    output logic       rx_valid  // rx_data 정상 수신 완료 신호
);

    parameter [6:0] SLAVE_ADDR = 7'h22;  // 주소 임의의 값

    // 3-state buffer
    logic sda_o, sda_i;
    assign sda_i = sda;
    assign sda   = sda_o ? 1'bz : 1'b0;

    // SCL, SDA edge signal
    logic scl_rising, scl_falling, sda_rising, sda_falling;

    // SCL edge detector
    edge_detector U_SCL_EDGE (
        .clk         (clk),
        .reset       (reset),
        .data_in     (scl),         // master가 주는 slc input
        .rising_edge (scl_rising),
        .falling_edge(scl_falling)
    );

    // SDA edge detector
    edge_detector U_SDA_EDGE (
        .clk         (clk),
        .reset       (reset),
        .data_in     (sda_i),       // master가 주는 sda input
        .rising_edge (sda_rising),
        .falling_edge(sda_falling)
    );

    // START, STOP condition
    logic start_sig;
    logic stop_sig;
    assign start_sig = scl & sda_falling;  // sc1 = 1 이고, sda 1->0
    assign stop_sig  = scl & sda_rising;  // scl = 1 이고, sda 0->1

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        RX_ADDR,
        ACK_ADDR,
        RX_DATA,
        ACK_DATA
    } i2c_state_e;

    i2c_state_e state;

    logic [2:0] bit_cnt;
    logic [7:0] rx_shift_reg;  // rx_data 임시 저장 레지스터

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            state        <= IDLE;
            sda_o        <= 1'b1;  // Z상태 (pull-up register) ***
            bit_cnt      <= 0;
            rx_shift_reg <= 0;
            rx_data      <= 0;
            rx_valid     <= 0;
        end else begin
            rx_valid <= 0; // 무조건 수신 완료되었을 때만 1 (딱 1clk만)
            if (stop_sig) begin
                state <= IDLE;
                sda_o <= 1'b1;
            end else if (start_sig) begin
                state   <= RX_ADDR;
                bit_cnt <= 0;
                sda_o   <= 1'b1;
            end else begin
                case (state)
                    IDLE: begin
                        sda_o = 1'b1;
                    end

                    RX_ADDR: begin
                        if (scl_rising) begin
                            // read address data
                            rx_shift_reg <= {rx_shift_reg[6:0], sda_i};
                            if (bit_cnt == 7) begin
                                state <= ACK_ADDR;
                            end else begin
                                bit_cnt = bit_cnt + 1;
                            end
                        end
                    end

                    ACK_ADDR: begin
                        if (scl_falling) begin
                            if (sda_o == 1'b1) begin
                                if(rx_shift_reg[7:1] == SLAVE_ADDR && rx_shift_reg[0] == 1'b0) begin
                                    // rx_shift_reg[0] => read or write
                                    // master가 slave에게 write => 1
                                    // master가 slave 데이터 read => 0
                                    // FND에 데이터 WRITE => rx_shift_reg[0] = 0
                                    sda_o <= 1'b0;  // ACK (주소 일치)
                                end else begin
                                    state <= IDLE;  // NACK (주소 불일치)
                                end
                            end else begin
                                sda_o   <= 1'b1;
                                bit_cnt <= 0;
                                state   <= RX_DATA;
                            end
                        end
                    end

                    RX_DATA: begin
                        if (scl_rising) begin
                            // read rx_data
                            rx_shift_reg <= {rx_shift_reg[6:0], sda_i};
                            if (bit_cnt == 7) begin
                                state <= ACK_DATA;
                            end else begin
                                bit_cnt <= bit_cnt + 1;
                            end
                        end
                    end

                    ACK_DATA: begin
                        if (scl_falling) begin
                            if (sda_o == 1'b1) begin
                                sda_o    <= 1'b0;  // 수신 완료 (ACK)
                                rx_data  <= rx_shift_reg;
                                rx_valid <= 1'b1;
                            end else begin
                                sda_o   <= 1'b1;
                                bit_cnt <= 0;
                                state   <= RX_DATA;
                            end
                        end
                    end

                    default: begin
                        state <= IDLE;
                    end
                endcase
            end
        end
    end

endmodule

`timescale 1ns / 1ps

module edge_detector (
    input  logic clk,
    input  logic reset,
    input  logic data_in,
    output logic rising_edge,
    output logic falling_edge
);

    // 1개의 플립플롭(prev_data) 대신 3개의 플립플롭을 직렬로 연결
    logic [2:0] sync_reg; 

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // I2C나 SPI 라인은 통신을 안 할 때 보통 1(High)을 유지하므로 1로 초기화
            sync_reg <= 3'b111; 
        end else begin
            // 들어온 데이터를 맨 오른쪽([0])에 밀어넣고, 기존 값은 왼쪽으로 쉬프트
            sync_reg <= {sync_reg[1:0], data_in}; 
        end
    end

    // sync_reg[0]: 외부 비동기 신호의 충격(메타스테빌리티)을 받아내는 총알받이 (사용 X)
    // sync_reg[1]: 1클럭 지나서 완전히 안정화된 '현재 데이터' (기존의 data_in 역할)
    // sync_reg[2]: 1클럭 더 지난 '과거 데이터' (기존의 prev_data 역할)

    // 과거(2)가 0이고 현재(1)가 1이면 Rising
    assign rising_edge  = (~sync_reg[2]) & (sync_reg[1]); 

    // 과거(2)가 1이고 현재(1)가 0이면 Falling
    assign falling_edge = (sync_reg[2])  & (~sync_reg[1]); 
    
endmodule
