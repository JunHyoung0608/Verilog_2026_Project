module uart #(
    parameter int BAUD_RATE = 9_600
) (
    input              clk,
    input              rst,
    //tx port
    input        [7:0] tx_data,
    input              tx_start,
    output logic       tx,
    output logic       tx_busy,
    //rx port
    input              rx,
    output logic [7:0] rx_data,
    output logic       rx_valid
);

    logic tick;
    logic sync_rx;

    baud_rate_gen #(
        .BAUD_RATE(BAUD_RATE)
    ) U_BRG (
        .clk (clk),
        .rst (rst),
        .tick(tick)
    );

    uart_tx U_UART_TX (
        .clk     (clk),
        .rst     (rst),
        .tick    (tick),
        .tx_data (tx_data),
        .tx_start(tx_start),
        .tx      (tx),
        .tx_busy (tx_busy)
    );

    sync_2ff U_SYNC_RX (
        .clk     (clk),
        .rst     (rst),
        .async_in(rx),
        .sync_out(sync_rx)
    );

    uart_rx U_UART_RX (
        .clk     (clk),
        .rst     (rst),
        .tick    (tick),
        .rx      (sync_rx),
        .rx_data (rx_data),
        .rx_valid(rx_valid)
    );

endmodule
