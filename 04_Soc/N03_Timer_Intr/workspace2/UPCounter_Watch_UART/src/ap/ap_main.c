/*
 * ap_main.c
 *
 *  Created on: 2026. 4. 28.
 *      Author: kccistc
 */

#include "ap_main.h"

#include <string.h>

#include "../driver/LED/LED.h"

typedef struct {
    uint32_t SR;
    uint32_t TDR;
    uint32_t RDR;
    uint32_t CR;
} UART_Typedef_t;

#define UART_BASE_ADDR XPAR_UART_0_S00_AXI_BASEADDR
#define UART0          ((UART_Typedef_t*)(UART_BASE_ADDR))

uint8_t UART_IsAvalable(UART_Typedef_t* uart) {
    return (uart->SR & 1U << 1) ? 1 : 0;
}

uint8_t UART_IsSending(UART_Typedef_t* uart) {
    return (uart->SR & 1U << 0) ? 0 : 1;
}
void UART_Send(UART_Typedef_t* uart, uint8_t* pData, uint16_t len) {
    for (int i = 0; i < len; i++) {
        UART_SendByte(uart, pData[i]);
    }
}
void UART_SendByte(UART_Typedef_t* uart, uint8_t data) {
    while (UART_IsSending(uart));
    uart->TDR = data;
}
uint8_t UART_RecvByte(UART_Typedef_t* uart) {
    uint8_t rx_data;
    while (!UART_IsAvalable(uart));
    rx_data = uart->RDR;
    return rx_data;
}

hBtn_t hBtnMainMode;
mainMode_t Mainmode = UpCounter;

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
    // UART_Send(UART0, "Hello World KCCI STC\n", strlen("Hello World KCCI STC\n"));

    char str[] = {"Hello World KCCI STC\n"};
    uint8_t rxData;
    for (int i = 0; i < strlen(str); i++) {
        UART_SendByte(UART0, str[i]);
        rxData = UART_RecvByte(UART0);
        xil_printf("%c", rxData);
    }

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
