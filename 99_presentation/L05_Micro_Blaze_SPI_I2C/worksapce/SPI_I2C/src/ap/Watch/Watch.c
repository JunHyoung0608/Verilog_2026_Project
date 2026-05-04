/*
 * Watch.c
 *
 *  Created on: 2026. 4. 28.
 *      Author: kccistc
 */
#include "Watch.h"

WatchTime_t Time;
hBtn_t hBtnTimeMode;
TimeMode_t TimeMode = HourMin;

void Watch_Init() {
    Button_Init(&hBtnTimeMode, GPIOA, GPIO_PIN_6);

    FND_Init();
    Watch_SetTime(12, 0, 0, 0);
}

void Watch_SetTime(uint8_t hh, uint8_t mm, uint8_t ss, uint8_t ms) {
    Time.hour = hh;
    Time.min = mm;
    Time.sec = ss;
    Time.msec = ms;
}

void Watch_Excute() {
    LED_StateDisp(1, TimeMode);

    Watch_DispTime();
}

void Watch_IncTime() {
    if (Time.msec < 100 - 1) {
        Time.msec++;
        return;
    }
    Time.msec = 0;
    if (Time.sec < 60 - 1) {
        Time.sec++;
        return;
    }
    Time.sec = 0;

    if (Time.min < 60 - 1) {
        Time.min++;
        return;
    }
    Time.min = 0;

    if (Time.hour < 60 - 1) {
        Time.hour++;
        return;
    }
    Time.hour = 0;
}

void Watch_DispTime() {
    switch (TimeMode) {
        case HourMin:
            Watch_DispHourMin();
            if (Button_GetState(&hBtnTimeMode) == ACT_PUSHED) {
                TimeMode = SecMSec;
            }
            break;
        case SecMSec:
            Watch_DispSecMSec();
            if (Button_GetState(&hBtnTimeMode) == ACT_PUSHED) {
                TimeMode = HourMin;
            }
            break;
        default:
            break;
    }

    if (Time.msec < 50) {
        FND_SetDP(FND_DIGIT_100, ON);
    } else {
        FND_SetDP(FND_DIGIT_100, OFF);
    }
}

void Watch_DispHourMin() {
    uint16_t timeNum = Time.hour * 100 + Time.min;
    FND_SetNum(timeNum);
}
void Watch_DispSecMSec() {
    uint16_t timeNum = Time.sec * 100 + Time.msec;
    FND_SetNum(timeNum);
}