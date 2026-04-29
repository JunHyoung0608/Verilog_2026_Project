/*
 * ap_main.h
 *
 *  Created on: 2026. 4. 28.
 *      Author: kccistc
 */

#ifndef SRC_AP_AP_MAIN_H_
#define SRC_AP_AP_MAIN_H_
#include <stdint.h>

#include "../HAL/TMR/TMR.h"
#include "../common/common.h"
#include "../driver/Button/button.h"
#include "Interrupt.h"
#include "Upcounter/UpCounter.h"
#include "Watch/Watch.h"
#include "Xintc.h"
#include "xil_exception.h"
#include "xil_printf.h"
#include "xparameters.h"

void ap_init();
void ap_excute();

#endif /* SRC_AP_AP_MAIN_H_ */
