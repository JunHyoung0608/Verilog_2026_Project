`timescale 1ns / 1ps
interface rx_if;


endinterface  //rx_if

module tb_rx ();
    

    uart_rx_add_b_tik DUT (
        .clk    (),
        .rst    (),
        .rx     (),
        .b_tick (),
        .rx_data(),
        .rx_done()
    );
endmodule
