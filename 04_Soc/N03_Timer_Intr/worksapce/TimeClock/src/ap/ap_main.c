/*
 * ap_main.c
 *
 *  Created on: 2026. 4. 28.
 *      Author: kccistc
 */

#include "ap_main.h"

#include "../driver/LED/LED.h"

hBtn_t hBtnMainMode;
mainMode_t Mainmode = UpCounter;

// void ap_init() {
//     //-------------HW-------------------------
//     Button_Init(&hBtnMainMode, GPIOA, GPIO_PIN_5);
//     LED_Init();
//     SetupInterruptSystem();
//     // 1Mhz -> 1us
//     TMR_SetPSC(TMR0, 100 - 1);
//     TMR_SetARR(TMR0, 0xffffffff);
//     TMR_StartIntr(TMR0);
//     TMR_StartTimer(TMR0);
//     // 1Khz -> 1ms
//     TMR_SetPSC(TMR1, 100 - 1);
//     TMR_SetARR(TMR1, 1000 - 1);
//     TMR_StartIntr(TMR1);
//     TMR_StartTimer(TMR1);
//     // 100hz -> 10ms
//     TMR_SetPSC(TMR2, 100 - 1);
//     TMR_SetARR(TMR2, 10000 - 1);
//     TMR_StartIntr(TMR2);
//     TMR_StartTimer(TMR2);
//     //-------------SW-------------------------
//     Watch_Init();
//     UpCounter_Init();
// }

// void ap_excute() {
//     while (1) {
//         switch (Mainmode) {
//             case UpCounter:
//                 UpCounter_Excute();
//                 if (Button_GetState(&hBtnMainMode) == ACT_PUSHED) {
//                     Mainmode = Watch;
//                     UpCounter_Init();
//                     LED_DispAllOff();
//                 }
//                 break;
//             case Watch:
//                 Watch_Excute();
//                 if (Button_GetState(&hBtnMainMode) == ACT_PUSHED) {
//                     FND_SetDP(FND_DIGIT_100, OFF);
//                     Mainmode = UpCounter;
//                     LED_DispAllOff();
//                 }
//                 break;
//             default:
//                 break;
//         }

//         // delay_ms(1);
//     }
// }

void ap_init() {
    //-------------HW-------------------------
    Button_Init(&hBtnMainMode, GPIOA, GPIO_PIN_5);
    Disp_Init();

    SetupInterruptSystem();
    TMR0_Init();  // 1Mhz -> 1us
    TMR1_Init();  // 1Khz -> 1ms
    TMR2_Init();  // 100hz -> 10ms
    //-------------SW-------------------------
    Watch_Init();
    UpCounter_Init();
}

void ap_excute() {
    while (1) {
        Disp_SetMode(Mainmode);
        switch (Mainmode) {
            case UpCounter:
                Disp_SetMode(DISP_TIME_CLOCK);
                UpCounter_Excute();
                if (Button_GetState(&hBtnMainMode) == ACT_PUSHED) {
                    Mainmode = Watch;
                    UpCounter_Init();
                }
                break;
            case Watch:
                Disp_SetMode(DISP_UP_COUNTER);
                Watch_Excute();
                if (Button_GetState(&hBtnMainMode) == ACT_PUSHED) {
                    FND_SetDP(FND_DIGIT_100, OFF);
                    Mainmode = UpCounter;
                }
                break;
            default:
                break;
        }
    }
}
