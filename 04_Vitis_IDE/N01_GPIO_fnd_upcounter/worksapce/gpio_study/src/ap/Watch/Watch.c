/*
 * Watch.c
 *
 *  Created on: 2026. 4. 28.
 *      Author: kccistc
 */
#include "Watch.h"

hBtn_t hBtnUpDown, hBtnSetTime, hBtnMode;

typedef struct {
    uint8_t msec;
    uint8_t sec;
    uint8_t min;
    uint8_t hour;
} Watch_Time_t;

Watch_Time_t* Time;

void Watch_Init() {
    FND_Init();
    Time->sec = 0, Time->min = 0, Time->hour = 0;
}

void Watch_Excute() {
    Watch_DispLoop();
    Watch_Run();
}

void Watch_DispLoop() {
    if (Time->msec > 50)
        FND_DispDigit(0x4);
    else if (Time->msec <= 50)
        FND_DispDigit(0x0);
}

void Watch_Run() {
    static uint32_t prevTimeCounter = 0;
    int num = Time->min * 100 + Time->sec;

    // delay 1sec x 10배
    // if (millis() - prevTimeCounter < 10 - 1)
    //     return;
    // prevTimeCounter = millis();

    // display
    FND_SetNum(num);

    Time_Update();
}

void Time_Update() {
    Time->msec++;

    if (Time->msec == 100) {
        Time->sec++;
        Time->msec = 0;
        if (Time->sec == 60) {  // sec
            Time->sec = 0;
            Time->min++;
            if (Time->min == 60) {  // min
                Time->min = 0;
                Time->hour++;
            }
            if (Time->hour == 24) {  // hour
                Time->hour = 0;
            }
        }
    }
}