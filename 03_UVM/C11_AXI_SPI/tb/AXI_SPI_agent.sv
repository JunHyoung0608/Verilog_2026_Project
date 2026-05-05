`ifndef AGENT_SV
`define AGENT_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "AXI_SPI_seq_item.sv"
`include "AXI_SPI_driver.sv"
`include "AXI_SPI_monitor.sv"


typedef uvm_sequencer#(AXI_SPI_seq_item) AXI_SPI_sequencer;

class AXI_SPI_agent extends uvm_agent;
    `uvm_component_utils(AXI_SPI_agent);

    AXI_SPI_driver                drv;
    AXI_SPI_monitor               mon;
    uvm_sequencer #(AXI_SPI_seq_item) sqr;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv = AXI_SPI_driver::type_id::create("drv", this);
        mon = AXI_SPI_monitor::type_id::create("mon", this);
        sqr = AXI_SPI_sequencer::type_id::create("sqr", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction

endclass  //component extends uvm_componet


`endif
