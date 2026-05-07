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

void LED_Init();
void LED_SetComPort(uint32_t LED_Pin, int OnOff);
void LED_StateDisp(int MainMode, int TimeMode);
void LED_IncLoopMove();
void LED_StatePinsOff();
void LED_LoopPinsOff();
void LED_DispAllOn();
void LED_DispAllOff();

#define LED_MODE_UP_COUNTER_PORT GPIOC
#define LED_MODE_UP_COUNTER_PIN  GPIO_PIN_7
#define LED_MODE_Watch_PORT      GPIOC
#define LED_MODE_Watch_PIN       GPIO_PIN_6
#define LED_TIME_MODE_HH_MM_PORT GPIOC
#define LED_TIME_MODE_HH_MM_PIN  GPIO_PIN_5
#define LED_TIME_MODE_SS_MS_PORT GPIOC
#define LED_TIME_MODE_SS_MS_PIN  GPIO_PIN_4

typedef struct
{
    GPIO_Typedef_t* GPIOx;
    uint32_t GPIO_Pin;
} hLed;

void Led_Init(hLed* hled, GPIO_Typedef_t* GPIOx, uint32_t GPIO_Pin);
void Led_On(hLed* hled);
void Led_off(hLed* hled);
void Led_Toggle(hLed* hled);
void Led_WritePort(hLed* hled, uint8_t data);
void Led_ReadPort(hLed* hled);

#endif /* SRC_DRIVER_LED_LED_H_ */
