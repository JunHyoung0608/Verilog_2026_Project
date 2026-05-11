`timescale 1ns / 1ps


module slave_top (
    input  wire       clk,
    input  wire       rst,
    // input  wire       sw,
    //spi
    // input  wire       sclk,
    // output wire       mosi,
    // input  wire       miso,
    // input  wire       cs_n,
    //i2c
    input  wire       scl,
    inout  wire       sda,
    //fnd
    output wire [7:0] fnd_data,
    output wire [3:0] fnd_digit,
    output wire [2:0] debug_state
);
    logic [7:0] i2c_rdata;
    logic [7:0] spi_rdata;
    logic [7:0] dispaly_data;

    i2c_salve #(
        .SLA(7'h12)
    ) U_I2C_SLV (
        .clk        (clk),
        .rst        (rst),
        // i2c port
        .scl        (scl),
        .sda        (sda),
        // external port
        .tx_data    (dispaly_data),
        .ack_in     (0),
        .rx_data    (i2c_rdata),
        .busy       (),
        .done       (done),
        .debug_state(debug_state)
    );

    // i2c_slave2 U_dasda(
    //     .clk(clk),
    //     .reset(rst),

    //     // external ic2 port
    //     .scl(scl),
    //     .sda(sda),

    //     // internal port
    //     .rx_data(i2c_rdata),
    //     .rx_valid(rx_valid)  // rx_data 정상 수신 완료 신호
    // );


    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            dispaly_data <= 0;
        end else begin
            if (done) dispaly_data <= i2c_rdata;
        end
    end



    fnd_controller U_FND_CTRL (
        .clk      (clk),
        .reset    (rst),
        .num      (i2c_rdata),
        .fnd_data (fnd_data),
        .fnd_digit(fnd_digit)
    );
endmodule
