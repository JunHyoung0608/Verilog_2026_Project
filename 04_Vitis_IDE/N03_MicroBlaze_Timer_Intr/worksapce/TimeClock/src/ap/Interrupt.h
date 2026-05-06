/*
 * Interrupt.h
 *
 *  Created on: 2026. 4. 29.
 *      Author: kccistc
 */

#ifndef SRC_COMMON_INTERRUPT_H_
#define SRC_COMMON_INTERRUPT_H_

#include "../common/common.h"
#include "DispService/DispService.h"
#include "UpCounter/UpCounter.h"
#include "Watch/Watch.h"
#include "Xintc.h"
#include "xil_exception.h"
#include "xil_printf.h"

#define INTC_DEV_ID XPAR_INTC_0_DEVICE_ID
#define TMR1_DEV_ID XPAR_TMR_1_DEVICE_ID
#define TMR2_DEV_ID XPAR_TMR_2_DEVICE_ID

void TMR1_ISR(void* callbackRef);
void TMR2_ISR(void* callbackRef);
int SetupInterruptSystem();

void TMR0_Init();
void TMR1_Init();
void TMR2_Init();

#endif /* SRC_COMMON_INTERRUPT_H_ */
