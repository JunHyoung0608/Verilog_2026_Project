/*
 * Interrupt.c
 *
 *  Created on: 2026. 4. 29.
 *      Author: kccistc
 */
#include "Interrupt.h"

#include "ap_main.h"

XIntc IntrController;

void TMR0_ISR(void* callbackRef) {
}

// 1msec intterupt service route
void TMR1_ISR(void* callbackRef) {
    millis_inc();
    FND_DispDigit();
    LED_IncLoopMove();
}

void TMR2_ISR(void* callbackRef) {
    Watch_IncTime();
}

int SetupInterruptSystem() {
    int status;
    // 1. �씤�꽣�읇�듃 而⑦듃濡ㅻ윭 珥덇린�솕
    status = XIntc_Initialize(&IntrController, INTC_DEV_ID);
    if (status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    // 2-1. TMR1_ISR �븿�닔瑜� Intc�� �뿰寃�
    status = XIntc_Connect(&IntrController, TMR1_DEV_ID, (XInterruptHandler)TMR1_ISR, (void*)0);
    if (status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    // 2-2. TMR2_ISR �븿�닔瑜� Intc�� �뿰寃�
    status = XIntc_Connect(&IntrController, TMR2_DEV_ID, (XInterruptHandler)TMR2_ISR, (void*)0);
    if (status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    // 3. Interrupt Controller �떆�옉(Hardware Mode)
    status = XIntc_Start(&IntrController, XIN_REAL_MODE);
    if (status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    // 4. 媛곴컖�쓽 �씤�꽣�읇�듃 梨꾨꼸 �솢�꽦�솕
    XIntc_Enable(&IntrController, TMR1_DEV_ID);
    XIntc_Enable(&IntrController, TMR2_DEV_ID);

    // 5. MicroBlaze�쓽 Exception 珥덇린�솕 諛� �솢�꽦�솕
    Xil_ExceptionInit();
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
                                 (Xil_ExceptionHandler)XIntc_InterruptHandler,
                                 &IntrController);
    Xil_ExceptionEnable();

    return XST_SUCCESS;
}
