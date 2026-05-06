/*
 * LED.h
 *
 *  Created on: 2026. 4. 30.
 *      Author: kccistc
 */

#ifndef SRC_DRIVER_LED_LED_H_
#define SRC_DRIVER_LED_LED_H_
#include "../../HAL/GPIO/GPIO.h"
#include "../../ap/ap_main.h"
#include "xparameters.h"

void LED_Init();
void LED_SetComPort(uint32_t LED_Pin, int OnOff);
void LED_StateDisp(int MainMode, int TimeMode);
void LED_IncLoopMove();
void LED_StatePinsOff();
void LED_LoopPinsOff();
void LED_DispAllOn();
void LED_DispAllOff();

#endif /* SRC_DRIVER_LED_LED_H_ */
