`ifndef DRIVER_SV
`define DRIVER_SV

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

class I2C_driver extends uvm_driver #(I2C_seq_item);
    `uvm_component_utils(I2C_driver);

    virtual I2C_if vif;

    typedef enum logic [1:0] {
        IDLE = 2'b0,
        ADDR,
        DATA,
        STOP
    } i2c_state_e;
    i2c_state_e state;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual I2C_if)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "driver에서 uvm_config_db 에러 발생");
    endfunction


    virtual task run_phase(uvm_phase phase);
        I2C_init();
        wait (vif.rst == 0);
        `uvm_info(get_type_name(), "리셋 해제 확인. 트랜잭션 대기 중 ...", UVM_MEDIUM)

        forever begin
            I2C_seq_item tr;
            seq_item_port.get_next_item(tr);
            drive_I2C(tr);
            seq_item_port.item_done();
        end
    endtask

    task I2C_init();
        state = IDLE;
        cmd_init(0);
        vif.drv_cb.m_tx_data <= 0;
        vif.drv_cb.m_ack_in  <= 0;
        //-------------slave------------
        vif.drv_cb.s_tx_data <= 0;
        vif.drv_cb.s_ack_in  <= 0;
    endtask

    task cmd_init(int num);
        vif.drv_cb.cmd_start <= (num == 1);
        vif.drv_cb.cmd_write <= (num == 2);
        vif.drv_cb.cmd_read  <= (num == 3);
        vif.drv_cb.cmd_stop  <= (num == 4);
        @(vif.drv_cb);
        vif.drv_cb.cmd_start <= 0;
        vif.drv_cb.cmd_write <= 0;
        vif.drv_cb.cmd_read  <= 0;
        vif.drv_cb.cmd_stop  <= 0;
    endtask

    task drive_I2C(I2C_seq_item tr);
        @(vif.drv_cb);
        `uvm_info(get_type_name(), $sformatf("IDLE: %s", tr.convert2string()), UVM_MEDIUM)
        wait (!vif.drv_cb.m_busy);
        @(vif.drv_cb);
        //START
        cmd_init(1);
        wait (vif.drv_cb.m_done);
        @(vif.drv_cb);

        //ADDR
        vif.drv_cb.m_tx_data <= {8'h12, tr.m_is_read};
        `uvm_info(get_type_name(), $sformatf("start->ADDR"), UVM_MEDIUM)
        cmd_init(2);
        vif.drv_cb.s_tx_data <= tr.s_tx_data;
        wait (vif.drv_cb.m_done);
        @(vif.drv_cb);

        //DATA
        if (tr.m_is_read) begin
            cmd_init(3);
        end else begin
            vif.drv_cb.m_tx_data <= tr.m_tx_data;
            cmd_init(2);
        end
        `uvm_info(get_type_name(), $sformatf("ADDR->DATA"), UVM_MEDIUM)
        wait (vif.drv_cb.m_done);
        @(vif.drv_cb);

        
        wait (vif.drv_cb.m_done);
        @(vif.drv_cb);

        `uvm_info(get_type_name(), $sformatf("DATA->STOP"), UVM_MEDIUM)
        cmd_init(4);

        wait (vif.drv_cb.m_done);
        @(vif.drv_cb);


        `uvm_info(get_type_name(), $sformatf("drv I2C 구동 완료: %s", tr.convert2string()),
                  UVM_MEDIUM)
    endtask

endclass  //component extends uvm_componet


`endif
