`ifndef ENVRONMENT_SV
`define ENVRONMENT_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "AXI_SPI_agent.sv"
`include "AXI_SPI_scoreboard.sv"
`include "AXI_SPI_coverage.sv"

class AXI_SPI_env extends uvm_env;
    `uvm_component_utils(AXI_SPI_env);

    AXI_SPI_agent      agt;
    AXI_SPI_scoreboard scb;
    AXI_SPI_coverage   cov;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt = AXI_SPI_agent::type_id::create("agt", this);
        scb = AXI_SPI_scoreboard::type_id::create("scb", this);
        cov = AXI_SPI_coverage::type_id::create("cov", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agt.mon.ap.connect(scb.ap_imp);
        agt.mon.ap.connect(cov.analysis_export);
    endfunction

endclass  //component extends uvm_componet


`endif
