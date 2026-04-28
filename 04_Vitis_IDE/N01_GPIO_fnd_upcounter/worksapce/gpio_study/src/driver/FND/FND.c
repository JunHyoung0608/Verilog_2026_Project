/*
 * FND.c
 *
 *  Created on: 2026. 4. 28.
 *      Author: kccistc
 */
#include "FND.h"

#include <stdint.h>

#include "xil_printf.h"

uint16_t fndNumData = 0;

void FND_Init() {
    // GPIO 설정
    GPIO_SetMode(FND_FONT_PORT, FND_COM_DIG_1 | FND_COM_DIG_2 | GPIO_PIN_2 | GPIO_PIN_3 | GPIO_PIN_4 | GPIO_PIN_5 | GPIO_PIN_6 | GPIO_PIN_7, OUTPUT);
    GPIO_SetMode(FND_COM_PORT, FND_COM_DIG_1 | FND_COM_DIG_2 | FND_COM_DIG_3 | FND_COM_DIG_4, OUTPUT);
}
void FND_SetComPort(GPIO_Typedef_t* FND_Port, uint32_t Seg_Pin, int OnOff) {
    GPIO_WritePin(FND_Port, Seg_Pin, OnOff);
}
void FND_DispDigit(uint8_t dot) {
    static uint8_t fndDigState = 0;
    fndDigState = (fndDigState + 1) % 4;

    switch (fndDigState) {
        case 0: FND_DispDigit_1(dot & 0x01); break;
        case 1: FND_DispDigit_10(dot & 0x02); break;
        case 2: FND_DispDigit_100(dot & 0x04); break;
        case 3:
            FND_DispDigit_1000(dot & 0x08);
            break;
            // default: FND_DispDigit_1(0); break;
    }
}
void FND_DispDigit_1(int dot) {
    uint8_t fndFont[16] = {0xc0, 0xf9, 0xa4, 0xb0, 0x99, 0x92, 0x82, 0xf8, 0x80, 0x90,
                           0x88, 0x83, 0xc6, 0xa1, 0x86, 0x8e};
    // num의 자리수 분리
    uint8_t digitData1 = fndNumData % 10;
    uint8_t fnd_data = fndFont[digitData1];
    if (dot) fnd_data &= ~(0x80);

    FND_DispAllOff();
    GPIO_WritePort(FND_FONT_PORT, fnd_data);
    FND_SetComPort(FND_COM_PORT, FND_COM_DIG_1, ON);
}
void FND_DispDigit_10(int dot) {
    uint8_t fndFont[16] = {0xc0, 0xf9, 0xa4, 0xb0, 0x99, 0x92, 0x82, 0xf8, 0x80, 0x90,
                           0x88, 0x83, 0xc6, 0xa1, 0x86, 0x8e};
    // data의 자리수 분리
    uint8_t digitData10 = (fndNumData / 10) % 10;
    uint8_t fnd_data = fndFont[digitData10];
    if (dot) fnd_data &= ~(0x80);

    FND_DispAllOff();
    GPIO_WritePort(FND_FONT_PORT, fnd_data);
    FND_SetComPort(FND_COM_PORT, FND_COM_DIG_2, ON);
}
void FND_DispDigit_100(int dot) {
    uint8_t fndFont[16] = {0xc0, 0xf9, 0xa4, 0xb0, 0x99, 0x92, 0x82, 0xf8, 0x80, 0x90,
                           0x88, 0x83, 0xc6, 0xa1, 0x86, 0x8e};
    // data의 자리수 분리
    uint8_t digitData100 = (fndNumData / 100) % 10;
    uint8_t fnd_data = fndFont[digitData100];
    if (dot) fnd_data &= ~(0x80);

    FND_DispAllOff();
    GPIO_WritePort(FND_FONT_PORT, fnd_data);
    FND_SetComPort(FND_COM_PORT, FND_COM_DIG_3, ON);
}
void FND_DispDigit_1000(int dot) {
    uint8_t fndFont[16] = {0xc0, 0xf9, 0xa4, 0xb0, 0x99, 0x92, 0x82, 0xf8, 0x80, 0x90,
                           0x88, 0x83, 0xc6, 0xa1, 0x86, 0x8e};
    // data의 자리수 분리
    uint8_t digitData1000 = (fndNumData / 1000) % 10;
    uint8_t fnd_data = fndFont[digitData1000];
    if (dot) fnd_data &= ~(0x80);

    FND_SetComPort(FND_COM_PORT, FND_COM_DIG_1 | FND_COM_DIG_2 | FND_COM_DIG_3 | FND_COM_DIG_4, OFF);
    GPIO_WritePort(FND_FONT_PORT, fnd_data);
    FND_SetComPort(FND_COM_PORT, FND_COM_DIG_4, ON);
}
void FND_SetNum(uint16_t num) {
    fndNumData = num;
}
void FND_DispAllOn() {
    FND_SetComPort(FND_COM_PORT, FND_COM_DIG_1 | FND_COM_DIG_2 | FND_COM_DIG_3 | FND_COM_DIG_4, ON);
}
void FND_DispAllOff() {
    FND_SetComPort(FND_COM_PORT, FND_COM_DIG_1 | FND_COM_DIG_2 | FND_COM_DIG_3 | FND_COM_DIG_4, OFF);
}
