module led_spead (
    input  logic       clk,
    input  logic       rst,
    input  logic       done,
    input  logic [7:0] d_in,
    output logic [9:0] d_out
);
    logic [7:0] d_in_reg;
    logic [4:0] mux_in;  // 255/10 = 25이므로 5비트 필요

    // Step 1: 입력 샘플링 (Done 신호에 맞춰 안정적으로 캡처)
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            d_in_reg <= 8'd0;
        end else if (done) begin
            if (d_in != 8'hff) d_in_reg <= d_in;
        end
    end

    // Step 2: 나눗셈 연산
    // 조합 회로로 선언하여 d_in_reg가 변할 때 즉시 mux_in 계산
    assign mux_in = d_in_reg / 10;

    // Step 3 & 4: Case 문을 이용한 LED 패턴 결정 및 출력 레지스터화
    // "0일 때 깜빡임" 문제를 방지하기 위해 출력을 FF(Always_ff)로 처리합니다.
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            d_out <= 10'd0;
        end else begin
            case (mux_in)
                5'd0:    d_out <= 10'd0;
                5'd1:    d_out <= 10'd1;
                5'd2:    d_out <= 10'd3;
                5'd3:    d_out <= 10'd7;
                5'd4:    d_out <= 10'd15;
                5'd5:    d_out <= 10'd31;
                5'd6:    d_out <= 10'd63;
                5'd7:    d_out <= 10'd127;
                5'd8:    d_out <= 10'd255;
                5'd9:    d_out <= 10'd511;
                5'd10:   d_out <= 10'd1023;
                // 100(10'd10)보다 큰 값이 들어올 경우 (배터리 100% 초과 상황 등)
                default: d_out <= 10'd0;
            endcase
        end
    end
endmodule
