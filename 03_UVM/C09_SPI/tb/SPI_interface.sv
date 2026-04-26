`ifndef IF_SV
`define IF_SV

interface SPI_if (
    input logic clk,
    input logic rst
);
    logic       m_cpol;
    logic       m_cpha;
    logic       m_clk_div;
    logic [7:0] m_tx_data;
    logic       m_start;
    logic [7:0] m_rx_data;
    logic       m_done;
    logic       m_busy;

    logic [7:0] s_slv_tx_data;
    logic [7:0] s_slv_rx_data;
    logic       s_done;

    clocking drv_cb @(posedge clk);
        default input #1step output #0;
        output m_cpol;
        output m_cpha;
        output m_clk_div;
        output m_tx_data;
        output m_start;
        input m_rx_data;
        input m_done;
        input m_busy;

        output s_slv_tx_data;
        input s_slv_rx_data;
        input s_done;
    endclocking

    clocking mon_cb @(posedge clk);
        default input #1step;
        input m_cpol;
        input m_cpha;
        input m_clk_div;
        input m_tx_data;
        input m_start;
        input m_rx_data;
        input m_done;
        input m_busy;

        input s_slv_tx_data;
        input s_slv_rx_data;
        input s_done;

    endclocking

    modport mp_drv(clocking drv_cb, input clk, input rst);
    modport mp_mon(clocking mon_cb, input clk, input rst);
endinterface

`endif
