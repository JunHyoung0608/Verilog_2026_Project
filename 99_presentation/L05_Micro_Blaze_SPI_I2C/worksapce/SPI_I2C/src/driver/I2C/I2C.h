/*
 * I2C.h
 *
 *  Created on: 2026. 5. 4.
 *      Author: kccistc
 */

#ifndef SRC_DRIVER_I2C_I2C_H_
#define SRC_DRIVER_I2C_I2C_H_
#include <stdint.h>

#include "../../HAL/GPIO/GPIO.h"
#include "xparameters.h"

typedef struct {
    uint32_t CR;
    uint32_t TXD;
    uint32_t RXD;
    uint32_t REG3;
} I2C_Typedef_t;

#define I2C_PORT ((I2C_Typedef_t*)(XPAR_I2C_MASTER_0_S00_AXI_BASEADDR))

#define CMD_START 0x00000001
#define CMD_WRITE 0x00000002
#define CMD_READ  0x00000004
#define CMD_STOP  0x00000008
#define ACK_IN    0x00000010
#define DONE_REG_CLEAR 0x20

#define ACK_OUT 0x01
#define BUSY      0x2
#define DONE      0x4

void I2C_clear_done(I2C_Typedef_t* I2Cx);
void I2C_wait_done(I2C_Typedef_t* I2Cx);
void I2C_wait_busy(I2C_Typedef_t* I2Cx);
void I2C_stop(I2C_Typedef_t* I2Cx);
void I2C_start(I2C_Typedef_t* I2Cx);
void I2C_Wdata(I2C_Typedef_t* I2Cx, uint8_t addr);
uint32_t I2C_Rdata(I2C_Typedef_t* I2Cx);
void I2C_Write_Byte(I2C_Typedef_t* I2Cx, uint8_t dev_addr, uint8_t data);
uint8_t I2C_Read_Byte(I2C_Typedef_t* I2Cx, uint8_t dev_addr);
#endif /* SRC_DRIVER_I2C_I2C_H_ */
