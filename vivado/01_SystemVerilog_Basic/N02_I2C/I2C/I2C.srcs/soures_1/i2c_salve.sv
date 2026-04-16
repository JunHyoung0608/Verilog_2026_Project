module i2c_salve (
    input        clk,
    input        rst,
    // i2c port
    input        scl,
    inout        sda,
    // external port
    input  [7:0] tx_data,
    output [7:0] rx_data,
    output       busy
);

    typedef enum logic [2:0] {
        IDLE     = 3'b0,
        ADDR,
        DATA,
        DATA_ACK,
        STOP
    } i2c_state_e;

    logic scl_ff1, scl_ff2, scl_posedge;
    i2c_state_e state;
    logic [2:0] bit_cnt;
    logic step;
    logic [6:0] addr_reg;


    assign busy = (state != IDLE);

    always_ff @(posedge clk or posedge rst) begin : blockName
        if (rst) begin
            scl_ff1 <= 1'b0;
            scl_ff2 <= 1'b0;
        end else begin
            scl_ff1 <= scl;
            scl_ff2 <= scl_ff1;
        end
    end
    assign scl_posedge = (scl_ff1 & ~scl_ff2);

    always_ff @(posedge clk or posedge rst) begin : i2c_salve
        if (rst) begin
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    if (!scl) begin
                        state <= ADDR;
                    end
                end
                ADDR: begin
                    if (bit_cnt < 7) begin

                    end
                end
                DATA: begin
                end
                DATA_ACK: begin
                end
                STOP: begin
                end
                default: begin
                end
            endcase
        end
    end
endmodule
