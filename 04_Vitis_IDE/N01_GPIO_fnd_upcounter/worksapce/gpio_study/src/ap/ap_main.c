/*
 * ap_main.c
 *
 *  Created on: 2026. 4. 28.
 *      Author: kccistc
 */

#include "ap_main.h"

typedef enum {
    UpCounter = 0,
    Watch
} mode_t;

hBtn_t hBtnMode;

void ap_init() {
    Button_Init(&hBtnMode, GPIOA, GPIO_PIN_2);

    Watch_Init();
    UpCounter_Init();
}

void ap_excute() {
    static mode_t mode = UpCounter;
    while (1) {
        switch (mode) {
            case UpCounter:
                UpCounter_Excute();
                if (Button_GetState(&hBtnMode) == ACT_PUSHED) {
                    mode = Watch;
                    UpCounter_Init();
                }
                break;
            case Watch:
                Watch_Excute();
                if (Button_GetState(&hBtnMode) == ACT_PUSHED) {
                    mode = UpCounter;
                }
                break;
            default:
                break;
        }

        millis_inc();
        delay_ms(1);
    }
}