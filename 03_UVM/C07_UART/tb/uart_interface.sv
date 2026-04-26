`ifndef IF_SV
`define IF_SV

interface uart_if (
    input logic clk,
    input logic rst
);
    //tx
    logic       tx_start;
    logic [7:0] tx_data;
    logic       uart_tx;
    logic       tx_done;
    logic       tx_busy;
    //rx
    logic       uart_rx;
    logic [7:0] rx_data;
    logic       rx_done;

    clocking drv_cb @(posedge clk);
        default input #1step output #0;
        //tx
        output tx_start;
        output tx_data;
        input uart_tx;
        input tx_done;
        input tx_busy;
        //rx
        output uart_rx;
        input rx_data;
        input rx_done;
    endclocking

    clocking mon_cb @(posedge clk);
        default input #1step;
        //tx
        input tx_start;
        input tx_data;
        input uart_tx;
        input tx_done;
        input tx_busy;
        //rx
        input uart_rx;
        input rx_data;
        input rx_done;
    endclocking

    modport mp_drv(clocking drv_cb, input clk, input rst);
    modport mp_mon(clocking mon_cb, input clk, input rst);
endinterface

`endif
