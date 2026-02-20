`timescale 1ns / 1ps

module top_module (
    input  clk,
    input  rst,
    output fnd_,

    input RX,
    output TX
);

    uart_interface U_UART_INFC (
        .iClk   (clk),
        .iRst   (rst),
        .iUartRx(RX),
        .oUartTx(TX),

        .iSenderData (),
        .iSenderValid(),
        .oSenderReady(),

        .oDecoderData (),
        .oDecoderValid()
    );

    sender U_SENDER (
        .clk           (clk),
        .rst           (rst),
        .i_c_mode      (),
        .i_start       (),
        .i_dec_data    (),
        .i_sender_ready(),
        .send_data     (),
        .send_valid    ()
    );
endmodule
