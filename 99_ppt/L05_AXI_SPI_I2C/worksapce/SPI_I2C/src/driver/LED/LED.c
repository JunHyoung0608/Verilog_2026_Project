/*
 * LED.c
 *
 *  Created on: 2026. 4. 30.
 *      Author: kccistc
 */
#include "LED.h"

#define LED_PORT GPIOC

#define LED_DIGIT_0   GPIO_PIN_0
#define LED_DIGIT_1   GPIO_PIN_1
#define LED_DIGIT_2   GPIO_PIN_2
#define LED_DIGIT_3   GPIO_PIN_3
#define LED_DIGIT_4   GPIO_PIN_4
#define LED_DIGIT_5   GPIO_PIN_5
#define LED_DIGIT_6   GPIO_PIN_6
#define LED_DIGIT_7   GPIO_PIN_7
#define LED_DIGIT_ALL 0xff

#define LED_ON  1
#define LED_OFF 0

void LED_Init() {
    GPIO_SetMode(LED_PORT, LED_DIGIT_ALL, OUTPUT);
}

void LED_SetComPort(uint32_t LED_Pin, int OnOff) {
    GPIO_WritePin(LED_PORT, LED_Pin, OnOff);
}

void LED_StateDisp(int MainMode, int TimeMode) {
    LED_StatePinsOff();

    switch (MainMode) {
        case 0:  // UpCounter
            LED_SetComPort(LED_DIGIT_7, LED_ON);
            break;
        case 1:  // Watch
            LED_SetComPort(LED_DIGIT_6, LED_ON);
            if (TimeMode == 0)
                LED_SetComPort(LED_DIGIT_5, LED_ON);
            else
                LED_SetComPort(LED_DIGIT_4, LED_ON);
            break;
        default:
            break;
    }
}

void LED_IncLoopMove() {
    static uint8_t led_cnt = 0;
    static int time_msec = 0;

    LED_LoopPinsOff();

    time_msec++;
    switch (Mainmode) {
        case UpCounter:
            if (time_msec >= 100) {
                time_msec = 0;
                led_cnt = (led_cnt + 1) % 4;
            }
            break;
        case Watch:
            if (time_msec >= 500) {
                time_msec = 0;
                led_cnt = (led_cnt + 3) % 4;
            }
            break;

        default:
            break;
    }

    LED_SetComPort((1 << led_cnt), LED_ON);
}

void LED_StatePinsOff() {
    GPIO_WritePin(LED_PORT, LED_DIGIT_4 | LED_DIGIT_5 | LED_DIGIT_6 | LED_DIGIT_7, LED_OFF);
}

void LED_LoopPinsOff() {
    GPIO_WritePin(LED_PORT, LED_DIGIT_0 | LED_DIGIT_1 | LED_DIGIT_2 | LED_DIGIT_3, LED_OFF);
}

void LED_DispAllOn() {
    LED_SetComPort(LED_DIGIT_ALL, LED_ON);
}

void LED_DispAllOff() {
    LED_SetComPort(LED_DIGIT_ALL, LED_OFF);
}
