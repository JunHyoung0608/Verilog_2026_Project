`ifndef DRIVER_SV
`define DRIVER_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "SPI_seq_item.sv"

class SPI_driver extends uvm_driver #(SPI_seq_item);
    `uvm_component_utils(SPI_driver);

    virtual SPI_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual SPI_if)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "driver에서 uvm_config_db 에러 발생");
    endfunction


    virtual task run_phase(uvm_phase phase);
        run_init();
        wait (vif.rst == 0);
        `uvm_info(get_type_name(), "리셋 해제 확인. 트랜잭션 대기 중 ...", UVM_MEDIUM)

        forever begin
            SPI_seq_item tx;
            seq_item_port.get_next_item(tx);
            drive_SPI(tx);
            seq_item_port.item_done();
        end
    endtask

    task run_init();
        vif.drv_cb.m_clk_div <= 4;
    endtask  //

    task drive_SPI(SPI_seq_item tx);
        // 1. 이전 작업이 완전히 끝났는지 확인 (m_done까지 체크하면 더 안전합니다)
        wait (!vif.drv_cb.m_busy && !vif.drv_cb.m_done);

        // 2. 설정 값과 Slave 데이터를 '미리' 세팅 (Start 1클럭 전)
        @(vif.drv_cb);
        vif.drv_cb.m_cpol        <= tx.m_cpol;
        vif.drv_cb.m_cpha        <= tx.m_cpha;
        vif.drv_cb.m_tx_data     <= tx.m_tx_data;
        vif.drv_cb.s_slv_tx_data <= tx.s_slv_tx_data;  // Slave 데이터 미리 준비

        // 3. Start 신호 인가 및 약간의 유지
        @(vif.drv_cb);
        vif.drv_cb.m_start <= 1;

        // DUT가 확실히 인지하도록 1~2클럭 유지 (필요 시)
        @(vif.drv_cb);
        vif.drv_cb.m_start <= 0;

        // 4. 통신 완료 대기
        wait (vif.drv_cb.m_done);

        // 5. 완료 후 안정화를 위한 여유 시간 (Guard Time)
        // 이 시간이 짧으면 다음 트랜잭션의 시작이 꼬일 수 있습니다.
        repeat (5) @(vif.drv_cb);

        `uvm_info(get_type_name(), $sformatf("drv SPI 구동 완료: %s", tx.convert2string()),
                  UVM_MEDIUM)
    endtask

endclass  //component extends uvm_componet


`endif
