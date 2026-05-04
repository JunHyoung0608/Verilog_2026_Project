/*

 * I2C.c

 *

 *  Created on: 2026. 5. 4.

 *      Author: kccistc

 */

#include "I2C.h"
#include "xil_printf.h"

// Done 비트를 클리어하는 헬퍼 함수 (반복 코드 축소)
void I2C_clear_done(I2C_Typedef_t* I2Cx) {
    I2Cx->CR = DONE_REG_CLEAR; // 하드웨어의 Done 플래그를 끄는 신호
    I2Cx->CR = 0;
}

void I2C_wait_done(I2C_Typedef_t* I2Cx) {

    while (!(I2Cx->REG3 & DONE));

}

void I2C_wait_busy(I2C_Typedef_t* I2Cx) {

    while ((I2Cx->REG3 & BUSY));

}

void I2C_start(I2C_Typedef_t* I2Cx) {
    I2Cx->CR = CMD_START;
    I2C_wait_busy(I2Cx);
    // 하드웨어가 명령을 인식할 시간만 주고 바로 비트를 내림 (재진입 방지)
    I2Cx->CR = 0;

    I2C_wait_done(I2Cx);   // 동작이 끝날 때까지 대기
    I2C_clear_done(I2Cx);  // 다음 동작을 위해 Done 클리어
}

void I2C_Wdata(I2C_Typedef_t* I2Cx, uint8_t data) {
    I2Cx->TXD = data;
    I2Cx->CR = CMD_WRITE;
    xil_printf("w1\n");
    I2C_wait_busy(I2Cx);
    I2Cx->CR = 0;
    xil_printf("w2\n");
    I2C_wait_done(I2Cx);
    I2C_clear_done(I2Cx);
    xil_printf("w3\n");
}

uint32_t I2C_Rdata(I2C_Typedef_t* I2Cx) {
    I2Cx->CR = CMD_READ;
    I2C_wait_busy(I2Cx);
    I2Cx->CR = 0;

    I2C_wait_done(I2Cx);
    I2C_clear_done(I2Cx);
    return I2Cx->RXD;
}

void I2C_stop(I2C_Typedef_t* I2Cx) {
    I2Cx->CR = CMD_STOP;
    I2C_wait_busy(I2Cx);
    I2Cx->CR = 0;

//    I2C_wait_done(I2Cx);
    I2C_clear_done(I2Cx);
    }

void I2C_Write_Byte(I2C_Typedef_t* I2Cx, uint8_t dev_addr, uint8_t data) {
    I2C_start(I2Cx);

    I2C_Wdata(I2Cx, (dev_addr << 1) & 0xFE);

    I2C_Wdata(I2Cx, data);

    I2C_stop(I2Cx);
}

uint8_t I2C_Read_Byte(I2C_Typedef_t* I2Cx, uint8_t dev_addr) {
    uint8_t data = 0;
    I2C_start(I2Cx);

    I2C_Wdata(I2Cx, (dev_addr << 1) | 0x01);

    data = (uint8_t)I2C_Rdata(I2Cx);

    I2C_stop(I2Cx);

    return data;
}
