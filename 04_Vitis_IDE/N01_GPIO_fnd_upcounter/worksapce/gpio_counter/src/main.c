#include <stdint.h>

#include "sleep.h"
#include "xil_printf.h"
#include "xparameters.h"

typedef struct {
    uint32_t CR;
    uint32_t IDR;
    uint32_t ODR;
} GPIO_Typedef_t;

#define GPIOA_CR  (*(uint32_t*)(XPAR_GPIO_0_S00_AXI_BASEADDR + 0x00))
#define GPIOA_IDR (*(uint32_t*)(XPAR_GPIO_0_S00_AXI_BASEADDR + 0x04))
#define GPIOA_ODR (*(uint32_t*)(XPAR_GPIO_0_S00_AXI_BASEADDR + 0x08))

#define GPIOB_CR  (*(uint32_t*)(XPAR_GPIO_1_S00_AXI_BASEADDR + 0x00))
#define GPIOB_IDR (*(uint32_t*)(XPAR_GPIO_1_S00_AXI_BASEADDR + 0x04))
#define GPIOB_ODR (*(uint32_t*)(XPAR_GPIO_1_S00_AXI_BASEADDR + 0x08))

#define GPIOC_CR  (*(uint32_t*)(XPAR_GPIO_2_S00_AXI_BASEADDR + 0x00))
#define GPIOC_IDR (*(uint32_t*)(XPAR_GPIO_2_S00_AXI_BASEADDR + 0x04))
#define GPIOC_ODR (*(uint32_t*)(XPAR_GPIO_2_S00_AXI_BASEADDR + 0x08))

//----------------------study code------------------------------------------

#define GPIOA ((GPIO_Typedef_t*)(XPAR_GPIO_0_S00_AXI_BASEADDR))
#define GPIOB ((GPIO_Typedef_t*)(XPAR_GPIO_1_S00_AXI_BASEADDR))
#define GPIOC ((GPIO_Typedef_t*)(XPAR_GPIO_2_S00_AXI_BASEADDR))

void GPIO_SetMode(GPIO_Typedef_t* GPIOx, int GPIO_PIN_x, int IO_SET) {
    GPIOx->CR &= (IO_SET << GPIO_PIN_x);
}

void GPIO_WritePin(GPIO_Typedef_t* GPIOx, int GPIO_PIN_x, int RESET) {
    GPIOx->ODR &= (RESET) ? ~(1 << GPIO_PIN_x) : (1 << GPIO_PIN_x);
}

int main() {
    GPIOA->CR = 0x00;
    GPIOB->CR = 0xff;
    GPIOC->CR = 0xff;

    GPIO_SetMode(GPIOA, GPIO_PIN_0, INPUT);
    GPIO_SetMode(GPIOA, GPIO_PIN_1, INPUT);
    GPIO_SetMode(GPIOA, GPIO_PIN_2, INPUT);
    GPIO_SetMode(GPIOA, GPIO_PIN_3, INPUT);

    while (1) {
        GPIOB->ODR = 0x00;

        GPIO_WritePin(GPIOA, GPIO_PIN_0, RESET);
        GPIO_WritePin(GPIOA, GPIO_PIN_1, SET);

        if (GPIO_ReadPIn(GPIOA, GPIO_PIN_0)) {
            GPIOC->ODR &= ~(1 << 0);
            GPIO_WritePin(GPIOA, GPIO_PIN_0, RESET);
        } else if ((GPIOA->IDR & (1 << 1))) {
            GPIOC->ODR &= ~(1 << 1);
        } else if ((GPIOA->IDR & (1 << 2))) {
            GPIOC->ODR &= ~(1 << 2);
        } else if ((GPIOA->IDR & (1 << 3))) {
            GPIOC->ODR &= ~(1 << 3);
        } else {
            GPIOC->ODR |= 0xf;
        }
    }
}