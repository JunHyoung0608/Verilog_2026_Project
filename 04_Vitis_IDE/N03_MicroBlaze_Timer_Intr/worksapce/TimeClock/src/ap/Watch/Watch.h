/*
 * Timer.h
 *
 *  Created on: 2026. 4. 28.
 *      Author: kccistc
 */

#ifndef SRC_AP_TIMER_TIMER_H_
#define SRC_AP_TIMER_TIMER_H_
#include <stdint.h>

#include "../../driver/Button/button.h"
#include "../../driver/FND/FND.h"
#include "xil_printf.h"

typedef struct {
    uint8_t msec;
    uint8_t sec;
    uint8_t min;
    uint8_t hour;
} Watch_Time_t;

void Watch_Init();
void Watch_Excute();
void Watch_DispLoop();
void Watch_Run();
void Time_Update();

#endif /* SRC_AP_TIMER_TIMER_H_ */
