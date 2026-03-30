#include<stdint.h>
//-------------------<SYS CHECK>-----------------------------
#define SYS_ERR             (-1)
#define SYS_OK              (0)
//-------------------<ADDR>-----------------------------
//BASE
#define APB_BRAM            (0x10000000)
#define APB_PERIPHERAL_BASE (0x20000000)
#define APB_GPO             (APB_PERIPHERAL_BASE + 0x0000U)
#define APB_GPI             (APB_PERIPHERAL_BASE + 0x1000U)
#define APB_GPIO            (APB_PERIPHERAL_BASE + 0x2000U)
#define APB_FND             (APB_PERIPHERAL_BASE + 0x3000U)
#define APB_UART            (APB_PERIPHERAL_BASE + 0x4000U)
//OFFSET
#define APB_GPO_CTRL         (APB_GPO + 0x00U)
#define APB_GPO_ODATA        (APB_GPO + 0x04U)
#define APB_GPI_CTRL         (APB_GPI + 0x00U)
#define APB_GPI_IDATA        (APB_GPI + 0x04U)
#define APB_GPIO_CTRL        (APB_GPIO + 0x00U)
#define APB_GPIO_ODATA       (APB_GPIO + 0x04U)
#define APB_GPIO_IDATA       (APB_GPIO + 0x08U)
#define APB_FND_CTRL         (APB_FND + 0x00U)
#define APB_FND_ODATA        (APB_FND + 0x04U)
#define APB_UART_CTRL        (APB_UART + 0x00U)
#define APB_UART_BAUD        (APB_UART + 0x04U)
#define APB_UART_STATUS      (APB_UART + 0x08U)
#define APB_UART_TXDATA      (APB_UART + 0x0CU)
#define APB_UART_RXDATA      (APB_UART + 0x10U)

//-------------------<struct>-----------------------------
#define __IO    volatile 

typedef struct {
    __IO uint32_t CTRL;
    __IO uint32_t ODATA;
    __IO uint32_t IDATA;
} GPIO_TYPEDEF;
#define GPIO   ((GPIO_TYPEDEF *) APB_GPIO)

typedef struct {
    __IO uint32_t CTRL;
    __IO uint32_t ODATA;
} FND_TYPEDEF;
#define FND   ((FND_TYPEDEF *) APB_FND)

typedef struct {
    __IO uint32_t CTRL;
    __IO uint32_t BAUD;
    __IO uint32_t STATUS;
    __IO uint32_t TXDATA;
    __IO uint32_t RXDATA;
} UART_TYPEDEF;
#define UART  ((UART_TYPEDEF *) APB_UART)

//-------------------<FNC>-----------------------------
/* Type your code here, or load an example. */
int sys_init(void);
void delay_ms(int delay);
void GPIO_init(GPIO_TYPEDEF *GPIOx, unsigned int control);
void led_write(GPIO_TYPEDEF *GPIOx, unsigned int wdata);
unsigned int sw_read(GPIO_TYPEDEF *GPIOx);

void FND_init(FND_TYPEDEF *FNDx, unsigned int control);
void FND_write(FND_TYPEDEF *FNDx, unsigned int wdata);

void UART_init(UART_TYPEDEF *UARTx, unsigned int control, unsigned int baud);
unsigned int UART_status(UART_TYPEDEF *UARTx);
void UART_send(UART_TYPEDEF *UARTx, unsigned int wdata);
unsigned int UART_get(UART_TYPEDEF *UARTx);
//-------------------<Main>-----------------------------
void main(void){
    int time = 0;
    int ret = SYS_ERR;
    unsigned int gpio0 = 0;
    unsigned int blink_flag = 0;
    unsigned int uart_get = 0;

    //SYS CHECK
    ret = sys_init();
    if (ret == SYS_ERR) return;

    time  = 1000;

    //RUN
    while(1) {
        if (!time) {
            // 1sec
            time = 1000;
            gpio0 = sw_read(GPIO) << 8;
            led_write(GPIO, gpio0);

            //push uart data
            if((UART_status(UART) & 0x8000)){
                uart_get = UART_get(UART);
            }
            
            //send uart
            if(!(UART_status(UART) & 0b1)){
                UART_send(UART,0x61);
                UART->CTRL = 0x0;  //TX_start
            }
        }
        delay_ms(1);
        time --;
        //display FND
        FND_write(FND, time);

    }

    return;
}

//-------------------<FCN>-----------------------------
void run_game(unsigned int com){
    int i, j;
    unsigned int user = 0;
    unsigned int balls = 0, strikes = 0;
    

    // 3. 판정 로직 (모든 곱셈을 시프트 연산으로 대체)
        for (int i = 0; i < 4; i++) {
            // i << 2는 i * 4와 동일 (0, 4, 8, 12비트 위치)
            int s_digit = (com >> (i << 2)) & 0xF;
            
            for (int j = 0; j < 4; j++) {
                int u_digit = (user >> (j << 2)) & 0xF;
                
                if (s_digit == u_digit) {
                    if (i == j) strikes++;
                    else balls++;
                }
            }
        }

}


void UART_init(UART_TYPEDEF *UARTx, unsigned int control, unsigned int baud) {
    UARTx->CTRL = control;
    UARTx->BAUD = baud;
}
unsigned int UART_status(UART_TYPEDEF *UARTx) {
    return UARTx->STATUS;
}
void UART_send(UART_TYPEDEF *UARTx, unsigned int wdata){
    UARTx->TXDATA = wdata;
    UARTx->CTRL = 0x1;  //TX_start
    UARTx->CTRL = 0x0;  //TX_start
    return;
}
unsigned int UART_get(UART_TYPEDEF *UARTx){
    return UARTx->RXDATA;
}

void FND_init(FND_TYPEDEF *FNDx, unsigned int control) {
    FNDx->CTRL = control;
}
void FND_write(FND_TYPEDEF *FNDx, unsigned int wdata) {
    FNDx->ODATA = wdata;
    return;
}

void GPIO_init(GPIO_TYPEDEF *GPIOx, unsigned int control) {
    GPIOx->CTRL = control;
}
void led_write(GPIO_TYPEDEF *GPIOx, unsigned int wdata) {
    GPIOx->ODATA = wdata;
    return;
}
unsigned int sw_read(GPIO_TYPEDEF *GPIOx){
    return GPIOx->IDATA;
}
int sys_init(void) {
    int i = 0;
    // RAM 
    *(unsigned int *) APB_BRAM      = 0x00000001;
    // RAM Read Test
    i = *(unsigned int *) APB_BRAM;
    if (i != 0x00000001){
        // error message output
        // UART_PRINT("SYS_ERR");
        return SYS_ERR;
    }

    // GPO 
    *(unsigned int *) APB_GPO_CTRL       = 0x00000000;   // GPO control register 
    *(unsigned int *) APB_GPO_ODATA     = 0x00000000;   // GPO output register
    // GPI  
    *(unsigned int *) APB_GPI_CTRL       = 0x00000000;   // GPI control register 
    i = *(unsigned int *) APB_GPI_IDATA;                // GPI Input register
    // GPIO 
    *(unsigned int *) APB_GPIO_CTRL      = 0x00000000;   // GPIO control register 
    *(unsigned int *) APB_GPIO_ODATA    = 0x00000000;   // GPIO output register

    // FND 
   *(unsigned int *) APB_FND_CTRL      = 0x00000000;   // FND control register 
   *(unsigned int *) APB_FND_ODATA    = 0x00000000;   // FND output register
//    // UART 
   *(unsigned int *) APB_UART_CTRL      = 0x00000000;   // FND control register 
   *(unsigned int *) APB_UART_BAUD     = 0x00000000;   // FND baudrate register 
   *(unsigned int *) APB_UART_TXDATA    = 0x00000000;   // FND output register
    
    GPIO_init(GPIO,0x0000ff00);     // GPIO [15:8] : LED output, GPIO[7:0] : SW input mode
    FND_init(FND,0x00003fff);       // FND [13:0] : FND ~9999         
    UART_init(UART,0x0,0x0);     // UART
    return SYS_OK;
}

void delay_ms(int delay) {
    int i = 0,j=0, k=0;
    for(i=0;i<delay;i++) {
        for (j=0;j<100000/32;j++) 
            k = k + 1;
    }
    return;
}