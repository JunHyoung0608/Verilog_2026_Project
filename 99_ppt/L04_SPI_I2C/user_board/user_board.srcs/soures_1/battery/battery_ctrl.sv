module battery_ctrl (
    input              clk,
    input              rst,
    input              start,
    output logic [7:0] soc_data,
    output logic       read_done,
    input        [7:0] rx_data,
    input              done,
    input              busy,
    input              ack_out,
    output logic       ack_in,
    output logic [7:0] tx_data,
    output logic       cmd_start,
    output logic       cmd_write,
    output logic       cmd_read,
    output logic       cmd_stop
);

    typedef enum logic [2:0] {
        IDLE  = 0,
        START,
        ADDR,
        WRITE,
        READ,
        STOP
    } i2c_state_e;

    i2c_state_e       state;
    logic             start_reg;
    logic             s_interrupt;
    logic       [7:0] rx_soc_int;
    parameter SLA_W = {7'h12, 1'b0};
    parameter SLA_R = {7'h12, 1'b1};

    // [수정] 100ms 대기를 위해 카운터 폭 증가 (100MHz 기준 10,000,000)
    logic [23:0] poll_cnt;


    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state       <= IDLE;
            cmd_start   <= 1'b0;
            cmd_write   <= 1'b0;
            cmd_read    <= 1'b0;
            cmd_stop    <= 1'b0;
            tx_data     <= 8'b0;
            ack_in      <= 1'b1;
            poll_cnt    <= 24'd0;
            start_reg   <= 1'b0;
            s_interrupt <= 1'b0;
            read_done   <= 1'b0;
        end else begin
            read_done <= 1'b0;
            if (start) start_reg <= 1'b1;
            case (state)
                IDLE: begin
                    if (start_reg) s_interrupt <= 1'b1;
                    cmd_start <= 1'b0;
                    cmd_write <= 1'b0;
                    cmd_read  <= 1'b0;
                    cmd_stop  <= 1'b0;

                    if (!busy) begin
                        state <= START;
                    end
                end
                // ... (START, ADDR, WRITE, READ, STOP 상태 코드는 이전과 100% 동일) ...
                START: begin
                    cmd_start <= 1'b1;
                    cmd_write <= 1'b0;
                    cmd_read  <= 1'b0;
                    cmd_stop  <= 1'b0;
                    if (done) begin
                        state <= ADDR;
                    end
                end
                ADDR: begin
                    cmd_start <= 1'b0;
                    cmd_write <= 1'b1;
                    cmd_read  <= 1'b0;
                    cmd_stop  <= 1'b0;
                    tx_data   <= s_interrupt ? SLA_W : SLA_R;
                    if (done) begin
                        if (s_interrupt) begin
                            start_reg   <= 0;
                            s_interrupt <= 0;
                            state       <= WRITE;
                        end else begin
                            state <= READ;
                        end
                    end
                end
                WRITE: begin
                    cmd_start <= 1'b0;
                    cmd_write <= 1'b1;
                    cmd_read  <= 1'b0;
                    cmd_stop  <= 1'b0;
                    tx_data   <= 8'b1;
                    if (done) begin
                        state <= STOP;
                    end
                end
                READ: begin
                    cmd_start <= 1'b0;
                    cmd_write <= 1'b0;
                    cmd_read  <= 1'b1;
                    cmd_stop  <= 1'b0;
                    tx_data   <= 8'b0;
                    if (done) begin
                        soc_data <= rx_data;
                        state <= STOP;
                    end
                end
                STOP: begin
                    cmd_start <= 1'b0;
                    cmd_write <= 1'b0;
                    cmd_read  <= 1'b0;
                    cmd_stop  <= 1'b1;
                    if (done) begin
                        ack_in <= 1'b1;
                        state <= IDLE;
                        read_done <= 1'b1;
                    end
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
