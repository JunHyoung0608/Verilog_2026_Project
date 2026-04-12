`ifndef SEQ_ITEM_SV
`define SEQ_ITEM_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class uart_seq_item extends uvm_sequence_item;
    //tx
    logic            tx_start;
    logic      [7:0] tx_data;
    logic            uart_tx;
    logic            tx_done;
    logic            tx_busy;
    //rx
    logic            uart_rx;
    logic      [7:0] rx_data;
    logic            rx_done;


    rand logic       mode;
    rand logic [7:0] rand_data;

    //constraint c_addr {rand_data % 128 == 0;}

    `uvm_object_utils_begin(uart_seq_item)
        `uvm_field_int(tx_start, UVM_ALL_ON)
        `uvm_field_int(tx_data, UVM_ALL_ON)
        `uvm_field_int(uart_tx, UVM_ALL_ON)
        `uvm_field_int(tx_done, UVM_ALL_ON)
        `uvm_field_int(tx_busy, UVM_ALL_ON)
        `uvm_field_int(uart_rx, UVM_ALL_ON)
        `uvm_field_int(rx_data, UVM_ALL_ON)
        `uvm_field_int(rx_done, UVM_ALL_ON)
    `uvm_object_utils_end


    function new(string name = "uart_seq_item");
        super.new(name);
    endfunction  //new()

    function string convert2string();
        string op = mode ? "TX" : "RX";
        return $sformatf(
            "\t***test %s[0x%02h]*** tx_start=0%0b, tx_data=0x%02h, uart_tx=%0b | uart_rx=%0b, rx_data=0x%02h",
            op,
            rand_data,
            tx_start,
            tx_data,
            uart_tx,
            uart_rx,
            rx_data
        );
    endfunction

endclass  //component extends uvm_componet


`endif
