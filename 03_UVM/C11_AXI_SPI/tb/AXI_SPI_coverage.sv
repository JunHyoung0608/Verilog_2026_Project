`ifndef COVERAGE_SV
`define COVERAGE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "AXI_SPI_seq_item.sv"

class AXI_SPI_coverage extends uvm_subscriber #(AXI_SPI_seq_item);
    `uvm_component_utils(AXI_SPI_coverage);

    AXI_SPI_seq_item tx;

    covergroup AXI_SPI_cg;
        cp_axi_wdata: coverpoint tx.axi_wdata[7:0] {
            bins zero_val = {8'h00};
            bins FF_val = {8'hff};
            bins walking_ones[] = {8'h01, 8'h02, 8'h04, 8'h08, 8'h10, 8'h20, 8'h40, 8'h80};
            bins walking_zeros[] = {8'hFE, 8'hFD, 8'hFB, 8'hF7, 8'hEF, 8'hDF, 8'hBF, 8'h7F};
        }
        cp_slv_tx_data: coverpoint tx.slv_tx_data[7:0] {
            bins zero_val = {8'h00};
            bins FF_val = {8'hff};
            bins point_ones[] = {8'h01, 8'h02, 8'h04, 8'h08, 8'h10, 8'h20, 8'h40, 8'h80};
            bins point_zeros[] = {8'hFE, 8'hFD, 8'hFB, 8'hF7, 8'hEF, 8'hDF, 8'hBF, 8'h7F};
        }
    endgroup

    function new(string name = "COV", uvm_component c);
        super.new(name, c);
        AXI_SPI_cg = new();
    endfunction  //new()

    virtual function void write(AXI_SPI_seq_item t);
        tx = t;
        AXI_SPI_cg.sample();
        `uvm_info(get_type_name(), $sformatf("counter_cg sampled: %s", tx.convert2string()),
                  UVM_MEDIUM);
    endfunction

    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf(
                  "\
        \n===== Coverage Summary =====\
        \n  cp_axi_wdata    : %.1f%%\
        \n  cp_slv_tx_data  : %.1f%%\
        \n============================",
                  AXI_SPI_cg.cp_axi_wdata.get_coverage(),
                  AXI_SPI_cg.cp_slv_tx_data.get_coverage()
                  ), UVM_LOW);
    endfunction
endclass  

`endif
