/*

 * I2C.c

 *

 *  Created on: 2026. 5. 4.

 *      Author: kccistc

 */

#include "I2C.h"

#include "xil_printf.h"

// Done 비트를 클리어하는 헬퍼 함수 (반복 코드 축소)
void I2C_CR_Clear(I2C_Typedef_t* I2Cx) {
    I2Cx->CR = DONE_REG_CLEAR;  // 하드웨어의 Done 플래그를 끄는 신호
    I2Cx->CR = 0;
}

void I2C_wait_done(I2C_Typedef_t* I2Cx) {
    xil_printf("%x\n", I2Cx->CR);
    while (!(I2Cx->REG3 & DONE)){
    	xil_printf("%x    %x\n", I2Cx->CR, I2Cx->REG3);
    }
}

void I2C_wait_busy(I2C_Typedef_t* I2Cx) {
    while ((I2Cx->REG3 & BUSY));
}

void I2C_start(I2C_Typedef_t* I2Cx) {
    I2Cx->CR = CMD_START;
    // 하드웨어가 명령을 인식할 시간만 주고 바로 비트를 내림 (재진입 방지)
     I2Cx->CR = 0;

    I2C_wait_done(I2Cx);  // 동작이 끝날 때까지 대기
    I2C_CR_Clear(I2Cx);   // 다음 동작을 위해 Done 클리어
}

void I2C_Wdata(I2C_Typedef_t* I2Cx, uint8_t data) {
    I2Cx->TXD = data;
    I2Cx->CR = CMD_WRITE;
    I2Cx->CR = 0;
    I2C_wait_done(I2Cx);
    I2C_CR_Clear(I2Cx);
}

uint32_t I2C_Rdata(I2C_Typedef_t* I2Cx) {
    I2Cx->CR = CMD_READ;
    I2Cx->CR = 0;
    I2C_wait_done(I2Cx);
    I2C_CR_Clear(I2Cx);
    return I2Cx->RXD;
}

void I2C_stop(I2C_Typedef_t* I2Cx) {
    I2Cx->CR = CMD_STOP;
    I2Cx->CR = 0;
    //    I2C_wait_done(I2Cx);
    I2C_CR_Clear(I2Cx);
}

void I2C_Write_Byte(I2C_Typedef_t* I2Cx, uint8_t dev_addr, uint8_t data) {
    I2C_CR_Clear(I2Cx);

    I2C_start(I2Cx);

    I2C_Wdata(I2Cx, (dev_addr << 1) & 0xFE);

    I2C_Wdata(I2Cx, data);

    I2C_stop(I2Cx);
}

uint8_t I2C_Read_Byte(I2C_Typedef_t* I2Cx, uint8_t dev_addr) {
    I2C_CR_Clear(I2Cx);

    uint8_t data = 0;
    I2C_start(I2Cx);

    I2C_Wdata(I2Cx, (dev_addr << 1) | 0x01);

    data = (uint8_t)I2C_Rdata(I2Cx);

    I2C_stop(I2Cx);

    return data;
}
