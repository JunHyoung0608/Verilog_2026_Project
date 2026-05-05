`ifndef IF_SV
`define IF_SV

interface AXI_SPI_if (
    input logic clk,
    input logic rst_n
);
    localparam C_S00_AXI_DATA_WIDTH = 32;
    localparam C_S00_AXI_ADDR_WIDTH = 4;

    //master
    logic [    C_S00_AXI_ADDR_WIDTH-1 : 0] axi_awaddr;
    logic                                  axi_awvalid;
    logic                                  axi_awready;
    logic [    C_S00_AXI_DATA_WIDTH-1 : 0] axi_wdata;
    logic [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] axi_wstrb;
    logic                                  axi_wvalid;
    logic                                  axi_wready;
    logic [                         1 : 0] axi_bresp;
    logic                                  axi_bvalid;
    logic                                  axi_bready;
    logic [    C_S00_AXI_ADDR_WIDTH-1 : 0] axi_araddr;
    logic                                  axi_arvalid;
    logic                                  axi_arready;
    logic [    C_S00_AXI_DATA_WIDTH-1 : 0] axi_rdata;
    logic [                         1 : 0] axi_rresp;
    logic                                  axi_rvalid;
    logic                                  axi_rready;
    //slv
    logic [                           7:0] slv_tx_data;
    logic [                           7:0] slv_rx_data;
    logic                                  slv_done;

    clocking drv_cb @(posedge clk);
        default input #1step output #0;
        //AW
        output axi_awaddr;
        output axi_awvalid;
        input axi_awready;
        //W
        output axi_wdata;
        output axi_wstrb;
        output axi_wvalid;
        input axi_wready;
        //B
        input axi_bresp;
        input axi_bvalid;
        output axi_bready;
        //AR
        output axi_araddr;
        output axi_arvalid;
        input axi_arready;
        //R
        input axi_rdata;
        input axi_rresp;
        input axi_rvalid;
        output axi_rready;
        //SLV
        output slv_tx_data;
        input slv_rx_data;
        input slv_done;
    endclocking

    clocking mon_cb @(posedge clk);
        default input #1step;
        input axi_awaddr;
        input axi_awvalid;
        input axi_awready;
        input axi_wdata;
        input axi_wstrb;
        input axi_wvalid;
        input axi_wready;
        input axi_bresp;
        input axi_bvalid;
        input axi_bready;
        input axi_araddr;
        input axi_arvalid;
        input axi_arready;
        input axi_rdata;
        input axi_rresp;
        input axi_rvalid;
        input axi_rready;
        //slv
        input slv_tx_data;
        input slv_rx_data;
        input slv_done;
    endclocking

    modport mp_drv(clocking drv_cb, input clk, input rst_n);
    modport mp_mon(clocking mon_cb, input clk, input rst_n);
endinterface

`endif
