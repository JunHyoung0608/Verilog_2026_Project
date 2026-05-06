/*
 * I2C.c
 *
 *  Created on: 2026. 5. 4.
 *      Author: kccistc
 */
#include "I2C_test.h"

#include "../../driver/Button/button.h"
#include "../../driver/I2C/I2C.h"
#include "../../driver/LED/LED.h"
#include "../../driver/FND/FND.h"
#include "xil_printf.h"

#define MODE_IDLE  0
#define MODE_WRITE 1
#define MODE_READ  2

hBtn_t hI2C_write, hI2C_raed;

typedef enum I2C_state {
    I2C_IDLE = 0,
    I2C_ADDR,
    I2C_WDATA,
    I2C_RDATA,
    I2C_STOP
} I2C_state_t;

I2C_state_t I2C_state = I2C_IDLE;

void I2C_Init() {
    Button_Init(&hI2C_write, GPIOA, GPIO_PIN_4);
    Button_Init(&hI2C_raed, GPIOA, GPIO_PIN_6);
	FND_Init();
    LED_Init();
}

void I2C_excute() {
    static uint8_t cnt = 0;
    static uint16_t rdata = 0;

    if (Button_GetState(&hI2C_write) == ACT_PUSHED) {
        xil_printf("PUSH_BTN%d\n",cnt);
        I2C_Write_Byte(I2C_PORT, 0x12, cnt++);
    } else if (Button_GetState(&hI2C_raed) == ACT_PUSHED) {
        xil_printf("PUSH_BTN\n");
        rdata = I2C_Read_Byte(I2C_PORT, 0x12);
    }
    if(cnt == 256) cnt = 0;
    FND_SetNum(rdata);
}
