`ifndef SEQ_ITEM_SV
`define SEQ_ITEM_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class SPI_seq_item extends uvm_sequence_item;
    logic             m_cpol;
    logic             m_cpha;
    logic             m_clk_div;
    randc logic [7:0] m_tx_data;
    logic             m_start;
    logic       [7:0] m_rx_data;
    logic             m_done;
    logic             m_busy;

    randc logic [7:0] s_slv_tx_data;
    logic       [7:0] s_slv_rx_data;
    logic             s_done;
    //-----------local---------------

    // constraint c_addr {paddr % 4 == 0;}

    `uvm_object_utils_begin(SPI_seq_item)
        `uvm_field_int(m_cpol, UVM_ALL_ON)
        `uvm_field_int(m_clk_div, UVM_ALL_ON)
        `uvm_field_int(m_tx_data, UVM_ALL_ON)
        `uvm_field_int(m_start, UVM_ALL_ON)
        `uvm_field_int(m_rx_data, UVM_ALL_ON)
        `uvm_field_int(m_done, UVM_ALL_ON)
        `uvm_field_int(m_busy, UVM_ALL_ON)

        `uvm_field_int(s_slv_tx_data, UVM_ALL_ON)
        `uvm_field_int(s_slv_rx_data, UVM_ALL_ON)
        `uvm_field_int(s_done, UVM_ALL_ON)
    `uvm_object_utils_end


    function new(string name = "SPI_seq_item");
        super.new(name);
    endfunction  //new()

    function string convert2string();
        //string op = pwrite ? "WRITE" : "READ";
        logic [1:0] mode = {m_cpol, m_clk_div};
        return $sformatf(
            "\n[%0d]m_cpol=%01b, m_clk_div=%01b, m_tx_data=0x%02h, m_start=%01b, m_rx_data=%02h ,m_done=%01b,\
             m_busy=%01b,\n s_slv_tx_data=%02h, s_slv_rx_data=%02h, s_done=%01b",
            mode,
            m_cpol,
            m_clk_div,
            m_tx_data,
            m_start,
            m_rx_data,
            m_done,
            m_busy,
            s_slv_tx_data,
            s_slv_rx_data,
            s_done
        );
    endfunction

endclass  //component extends uvm_componet


`endif
