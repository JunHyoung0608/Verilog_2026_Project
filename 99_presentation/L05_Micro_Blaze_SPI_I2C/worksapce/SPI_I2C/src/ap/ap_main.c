/*
 * ap_main.c
 *
 *  Created on: 2026. 4. 28.
 *      Author: kccistc
 */

#include "ap_main.h"

hBtn_t hBtnMainMode;
mainMode_t Mainmode = UpCounter;

void ap_init() {
    //-------------HW-------------------------
//    Button_Init(&hBtnMainMode, GPIOA, GPIO_PIN_5);
    LED_Init();
    SetupInterruptSystem();
    // 1Mhz -> 1us
    TMR_SetPSC(TMR0, 100 - 1);
    TMR_SetARR(TMR0, 0xffffffff);
    TMR_StartIntr(TMR0);
    TMR_StartTimer(TMR0);
    // 1Khz -> 1ms
    TMR_SetPSC(TMR1, 100 - 1);
    TMR_SetARR(TMR1, 1000 - 1);
    TMR_StartIntr(TMR1);
    TMR_StartTimer(TMR1);
    // 100hz -> 10ms
    TMR_SetPSC(TMR2, 100 - 1);
    TMR_SetARR(TMR2, 10000 - 1);
    TMR_StartIntr(TMR2);
    TMR_StartTimer(TMR2);
    //-------------SW-------------------------
    I2C_Init();
}

void ap_excute() {
	I2C_excute();
}
