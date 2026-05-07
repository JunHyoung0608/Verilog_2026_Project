/*
 * DispService.c
 *
 *  Created on: 2026. 5. 6.
 *      Author: kccistc
 */
#include "DispService.h"

hLed hLedTimeClockMode;
hLed hLedWatchMode;
hLed hLedTimehMode_hhmm;
hLed hLedTimehMode_ssms;
hLed hLedShift;

void Disp_SetMode(int mode) {
    if (mode == DISP_TIME_CLOCK) {
        Led_On(&hLedTimeClockMode);
        Led_off(&hLedWatchMode);
    } else if (mode == DISP_UP_COUNTER) {
        Led_On(&hLedWatchMode);
        Led_off(&hLedTimeClockMode);
        Led_off(&hLedTimehMode_hhmm);
        Led_off(&hLedTimehMode_ssms);
    }
}

void Disp_SetTimeMode(int mode) {
    if (mode == DISP_TIME_HHMM) {
        Led_On(&hLedTimehMode_hhmm);
        Led_off(&hLedTimehMode_ssms);
    } else {
        Led_On(&hLedTimehMode_ssms);
        Led_off(&hLedTimehMode_hhmm);
    }
}

void Disp_Init() {
    FND_Init();
    Led_Init(&hLedTimeClockMode, LED_MODE_UP_COUNTER_PORT, LED_MODE_UP_COUNTER_PIN);
    Led_Init(&hLedWatchMode, LED_MODE_Watch_PORT, LED_MODE_Watch_PIN);
    Led_Init(&hLedTimehMode_hhmm, LED_TIME_MODE_HH_MM_PORT, LED_TIME_MODE_HH_MM_PIN);
    Led_Init(&hLedTimehMode_ssms, LED_TIME_MODE_SS_MS_PORT, LED_TIME_MODE_SS_MS_PIN);
    Led_Init(&hLedShift, LED_PORT, GPIO_PIN_3 | GPIO_PIN_2 | GPIO_PIN_1 | GPIO_PIN_0);

    Disp_SetMode(DISP_TIME_CLOCK);
    Disp_SetMode(DISP_TIME_HHMM);
}

void Disp_SetShiftMode() {
}

void Disp_TimeHHMM() {
}

void Disp_TimeSSMS() {
}
void Disp_UpCounter(uint16_t num) {
    FND_SetNum(num);
}

void Disp_Watch(uint16_t num) {
    FND_SetNum(num);
}

void Disp_ISR_Excute() {
    FND_DispDigit();
}

void Disp_shiftLed(int mode) {
    static uint8_t ledShiftPosData = 1;
    uint8_t ledPortData;
    uint8_t ledOutData;

    if (mode == DISP_TIME_CLOCK) {
        ledShiftPosData = (ledShiftPosData << 3) | (ledShiftPosData >> 1);
    } else {
        ledShiftPosData = (ledShiftPosData >> 3) | (ledShiftPosData << 1);
    }
    ledPortData = hLedShift.GPIOx->ODR;
    ledOutData = (ledPortData & 0xf0) | (ledShiftPosData & 0x0f);
    Led_WritePort(&hLedShift, ledOutData);
}
