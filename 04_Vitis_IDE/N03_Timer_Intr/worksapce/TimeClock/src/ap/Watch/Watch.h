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
#include "../../driver/LED/LED.h"
#include "../DispService/DispService.h"
#include "../ap_main.h"
#include "xil_printf.h"

typedef struct {
    uint8_t hour;
    uint8_t min;
    uint8_t sec;
    uint8_t msec;
} WatchTime_t;

extern WatchTime_t Time;
typedef enum TimeMode {
    HourMin = 0,
    SecMSec
} TimeMode_t;

void Watch_Init();
void Watch_SetTime(uint8_t hh, uint8_t mm, uint8_t ss, uint8_t ms);
void Watch_Excute();
void Watch_IncTime();
void Watch_DispTime();
void Watch_DispHourMin();
void Watch_DispSecMSec();

#endif /* SRC_AP_TIMER_TIMER_H_ */
