`ifndef IF_SV
`define IF_SV

interface uart_if (
    input logic clk,
    input logic rst
);
    //tx port
    logic [7:0] tx_data;
    logic       tx_start;
    logic       tx;
    logic       tx_busy;
    //rx port
    logic       rx;
    logic [7:0] rx_data;
    logic       rx_valid;

    clocking drv_cb @(posedge clk);
        default input #1step output #0;
        //tx port
        output tx_data;
        output tx_start;
        output tx;
        output tx_busy;
        //rx port
        input rx;
        input rx_data;
        input rx_valid;
    endclocking

    clocking mon_cb @(posedge clk);
        default input #1step;
        //tx port
        input tx_data;
        input tx_start;
        input tx;
        input tx_busy;
        //rx port
        input rx;
        input rx_data;
        input rx_valid;
    endclocking

    modport mp_drv(clocking drv_cb, input clk, input rst);
    modport mp_mon(clocking mon_cb, input clk, input rst);
endinterface

`endif
