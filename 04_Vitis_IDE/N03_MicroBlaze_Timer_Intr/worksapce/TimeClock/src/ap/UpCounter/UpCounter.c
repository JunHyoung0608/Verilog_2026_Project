/*
 * UpCounter.c
 *
 *  Created on: 2026. 4. 28.
 *      Author: kccistc
 */
#include "UpCounter.h"

hBtn_t hBtnRunStop, hBtnClear;
uint16_t counter = 0;
static upcounter_state_t upCounterState = STOP;

void UpCounter_Init() {
    Button_Init(&hBtnRunStop, GPIOA, GPIO_PIN_4);
    Button_Init(&hBtnClear, GPIOA, GPIO_PIN_5);

    FND_Init();
    counter = 0;
    upCounterState = STOP;
}

void UpCounter_Excute() {
    UpCounter_DispLoop();

    switch (upCounterState) {
        case STOP:
            UpCounter_Stop();
            if (Button_GetState(&hBtnRunStop) == ACT_PUSHED) {
                upCounterState = RUN;
            } else if (Button_GetState(&hBtnClear) == ACT_PUSHED) {
                upCounterState = CLEAR;
            }
            break;
        case RUN:
            UpCounter_Run();
            if (Button_GetState(&hBtnRunStop) == ACT_PUSHED) {
                upCounterState = STOP;
            } else if (Button_GetState(&hBtnClear) == ACT_PUSHED) {
                upCounterState = CLEAR;
            }
            break;
        case CLEAR:
            UpCounter_Clear();
            upCounterState = STOP;
            break;
        default:
            break;
    }
}

void UpCounter_DispLoop() {
    FND_DispDigit(0);
}

void UpCounter_Run() {
    static uint32_t prevTimeCounter = 0;

    if (millis() - prevTimeCounter < 100 - 1)
        return;

    prevTimeCounter = millis();

    FND_SetNum(counter++);
}

void UpCounter_Stop() {
    FND_SetNum(counter);
}

void UpCounter_Clear() {
    counter = 0;
    FND_SetNum(counter);
}