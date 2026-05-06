module virtual_battery (
    input              clk,
    input              rst,
    input              charge_en,
    output logic [6:0] soc_int,    // 0~100
    output logic [6:0] soc_dec,    // 0~99
    output logic [8:0] v_batt,     // 부하전압 (예: 3700 -> 3.70V 단위 고정소수점)
    output logic       batt_low,
    output logic       batt_full
);

    logic [23:0] timer_cnt;
    localparam TARGET_CNT = 24'd10_000_000 - 1;  // 0.1sec @ 100MHz

    logic [13:0] soc_raw;

    // 1. 0.1sec 타이머
    always_ff @(posedge clk or posedge rst) begin
        if (rst) timer_cnt <= 24'd0;
        else if (timer_cnt >= TARGET_CNT) timer_cnt <= 24'd0;
        else timer_cnt <= timer_cnt + 1'b1;
    end

    // 2. SOC 충방전 로직
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            soc_raw <= 14'd5000;  // 초기값 50.00%
        end else if (timer_cnt == TARGET_CNT) begin
            if (charge_en && (soc_raw < 14'd10000)) soc_raw <= soc_raw + 14'd1;
            else if (!charge_en && (soc_raw > 14'd0)) soc_raw <= soc_raw - 14'd1;
        end
    end

    // 3. SOC 정수/소수부 분리 (타이밍을 위해 FF 사용 권장)
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            soc_int <= 7'd0;
            soc_dec <= 7'd0;
        end else begin
            soc_int <= soc_raw / 100;
            soc_dec <= soc_raw % 100;
        end
    end

    // 4. 부하전압 LUT (Look-Up Table)
    // soc_int(0~100)를 기준으로 전압(mV)을 매핑
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            v_batt <= 8'd37;
        end else begin
            case (soc_int)
                // SOC 구간별 전압 강하 곡선 (단위: mV)
                7'd100: v_batt <= 8'd42;  // 만충
                7'd90:  v_batt <= 8'd41;
                7'd80:  v_batt <= 8'd40;
                7'd70:  v_batt <= 8'd39;
                7'd60:  v_batt <= 8'd38;
                7'd50:  v_batt <= 8'd37;  // 공칭 전압
                7'd40:  v_batt <= 8'd36;
                7'd30:  v_batt <= 8'd35;
                7'd20:  v_batt <= 8'd34;  // Low 경계
                7'd10:  v_batt <= 8'd32;  // 급격한 하강 시작
                7'd5:   v_batt <= 8'd30;
                7'd0:   v_batt <= 8'd27;  // 종지 전압
                default: begin
                    // 10단위 사이의 값은 간단하게 유지하거나 범위를 좁혀 구현 가능
                    if (soc_int > 90) v_batt <= 8'd41;
                    else if (soc_int > 50) v_batt <= 8'd37;
                    else if (soc_int > 20) v_batt <= 8'd35;
                    else v_batt <= 8'd31;
                end
            endcase
        end
    end

    // 5. 상태 알림
    assign batt_full = (soc_raw >= 14'd10000);
    assign batt_low  = (soc_raw <= 14'd2000);  // 20% 이하일 때 알림

endmodule
