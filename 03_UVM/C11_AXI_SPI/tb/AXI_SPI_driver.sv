`ifndef DRIVER_SV
`define DRIVER_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "AXI_SPI_seq_item.sv"

class AXI_SPI_driver extends uvm_driver #(AXI_SPI_seq_item);
    `uvm_component_utils(AXI_SPI_driver);

    virtual AXI_SPI_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual AXI_SPI_if)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "driver에서 uvm_config_db 에러 발생");
    endfunction


    virtual task run_phase(uvm_phase phase);
        AXI_SPI_bus_init();
        wait (vif.rst_n == 1);
        `uvm_info(get_type_name(), "리셋 해제 확인. 트랜잭션 대기 중 ...", UVM_MEDIUM)

        forever begin
            AXI_SPI_seq_item tx;
            seq_item_port.get_next_item(tx);
            drive_AXI_SPI(tx);
            seq_item_port.item_done();
        end
    endtask

    task AXI_SPI_bus_init();
        //AW
        vif.axi_awaddr  <= 0;
        vif.axi_awvalid <= 0;
        //W
        vif.axi_wdata   <= 0;
        vif.axi_wstrb   <= 0;
        vif.axi_wvalid  <= 0;
        //B
        vif.axi_bready  <= 0;
        //AR
        vif.axi_araddr  <= 0;
        vif.axi_arvalid <= 0;
        //R
        vif.axi_rready  <= 0;
    endtask

    task axi_write_bus(logic [3:0] addr, logic [31:0] data);
        fork
            // Address Channel
            begin
                vif.drv_cb.axi_awaddr  <= addr;
                vif.drv_cb.axi_awvalid <= 1'b1;
                @(vif.drv_cb);
                while (!vif.drv_cb.axi_awready) @(vif.drv_cb);
                vif.drv_cb.axi_awvalid <= 1'b0;
            end
            // Data Channel
            begin
                vif.drv_cb.axi_wdata  <= data;
                vif.drv_cb.axi_wvalid <= 1'b1;
                vif.drv_cb.axi_wstrb  <= 4'hF;
                @(vif.drv_cb);
                while (!vif.drv_cb.axi_wready) @(vif.drv_cb);
                vif.drv_cb.axi_wvalid <= 1'b0;
            end
        join

        // Response Channel (B)
        vif.drv_cb.axi_bready <= 1'b1;
        @(vif.mon_cb);  // 혹은 drv_cb
        while (!vif.drv_cb.axi_bvalid) @(vif.drv_cb);
        vif.drv_cb.axi_bready <= 1'b0;
    endtask

    task drive_AXI_Read(logic [3:0] addr);
        // 주소 채널은 핸드셰이크가 필요함
        vif.drv_cb.axi_araddr  <= addr;
        vif.drv_cb.axi_arvalid <= 1'b1;
        vif.drv_cb.axi_rready  <= 1'b1;  // 미리 1로 셋팅

        @(vif.drv_cb);
        wait (vif.drv_cb.axi_arready);
        vif.drv_cb.axi_arvalid <= 1'b0;

        // 데이터 채널: 이미 rready가 1이므로 rvalid가 뜨는 순간 바로 끝남
        wait (vif.drv_cb.axi_rvalid);
    endtask

    task drive_AXI_SPI(AXI_SPI_seq_item tx);
        `uvm_info(get_type_name(), "AXI Write Transaction Start", UVM_HIGH)

        //STEP1 :TXD 세팅
        @(vif.drv_cb);
        vif.drv_cb.slv_tx_data <= tx.slv_tx_data;

        axi_write_bus(4'h4, tx.axi_wdata);
        `uvm_info(get_type_name(), "STEP1 : AXI TXD Set", UVM_HIGH)
        @(vif.drv_cb);

        //STEP2 : SPI start
        axi_write_bus(4'h0, 32'h410);
        `uvm_info(get_type_name(), "STEP22 : SPI start = 1", UVM_HIGH)
        axi_write_bus(4'h0, 32'h010);
        `uvm_info(get_type_name(), "STEP3 : SPI start = 0", UVM_HIGH)

        //STEP3 : SPI DONE
        wait (vif.drv_cb.slv_done);
        @(vif.drv_cb);

        //STEP4 : Read SPI miso
        drive_AXI_Read(4'h8);

        `uvm_info(get_type_name(), $sformatf("drv AXI_SPI 구동 완료: %s", tx.convert2string()),
                  UVM_MEDIUM)
    endtask

endclass  //component extends uvm_componet


`endif
