`ifndef SEQ_ITEM_SV
`define SEQ_ITEM_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class AXI_SPI_seq_item extends uvm_sequence_item;
    localparam C_S00_AXI_DATA_WIDTH = 32;
    localparam C_S00_AXI_ADDR_WIDTH = 4;
    //master
    logic      [    C_S00_AXI_ADDR_WIDTH-1 : 0] axi_awaddr;
    logic                                       axi_awvalid;
    logic                                       axi_awready;
    rand logic [    C_S00_AXI_DATA_WIDTH-1 : 0] axi_wdata;
    logic      [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] axi_wstrb;
    logic                                       axi_wvalid;
    logic                                       axi_wready;
    logic      [                         1 : 0] axi_bresp;
    logic                                       axi_bvalid;
    logic                                       axi_bready;
    logic      [    C_S00_AXI_ADDR_WIDTH-1 : 0] axi_araddr;
    logic                                       axi_arvalid;
    logic                                       axi_arready;
    logic      [    C_S00_AXI_DATA_WIDTH-1 : 0] axi_rdata;
    logic      [                         1 : 0] axi_rresp;
    logic                                       axi_rvalid;
    logic                                       axi_rready;
    //slv
    rand logic [                         7 : 0] slv_tx_data;
    logic      [                         7 : 0] slv_rx_data;
    logic                                       slv_done;

    

    `uvm_object_utils_begin(AXI_SPI_seq_item)
    //master
        `uvm_field_int(axi_awaddr, UVM_ALL_ON)
        `uvm_field_int(axi_awvalid, UVM_ALL_ON)
        `uvm_field_int(axi_awready, UVM_ALL_ON)
        `uvm_field_int(axi_wdata, UVM_ALL_ON)
        `uvm_field_int(axi_wstrb, UVM_ALL_ON)
        `uvm_field_int(axi_wvalid, UVM_ALL_ON)
        `uvm_field_int(axi_wready, UVM_ALL_ON)
        `uvm_field_int(axi_bresp, UVM_ALL_ON)
        `uvm_field_int(axi_bvalid, UVM_ALL_ON)
        `uvm_field_int(axi_bready, UVM_ALL_ON)
        `uvm_field_int(axi_araddr, UVM_ALL_ON)
        `uvm_field_int(axi_arvalid, UVM_ALL_ON)
        `uvm_field_int(axi_arready, UVM_ALL_ON)
        `uvm_field_int(axi_rdata, UVM_ALL_ON)
        `uvm_field_int(axi_rresp, UVM_ALL_ON)
        `uvm_field_int(axi_rvalid, UVM_ALL_ON)
        `uvm_field_int(axi_rready, UVM_ALL_ON)
    //slv
        `uvm_field_int(slv_tx_data, UVM_ALL_ON)
        `uvm_field_int(slv_rx_data, UVM_ALL_ON)
        `uvm_field_int(slv_done, UVM_ALL_ON)
    `uvm_object_utils_end


    function new(string name = "AXI_SPI_seq_item");
        super.new(name);
    endfunction  //new()

    function string convert2string();
        return $sformatf(
            "AXI_SPI_Item: [Write] addr=0x%0h, data=0x%0h, strb=0b%0b, resp=0x%0h | [Read] addr=0x%0h, data=0x%0h, resp=0x%0h | [Slave] tx=0x%0h, rx=0x%0h, done=%0b",
            axi_awaddr,
            axi_wdata,
            axi_wstrb,
            axi_bresp,
            axi_araddr,
            axi_rdata,
            axi_rresp,
            slv_tx_data,
            slv_rx_data,
            slv_done
        );
    endfunction

endclass  //component extends uvm_componet


`endif
