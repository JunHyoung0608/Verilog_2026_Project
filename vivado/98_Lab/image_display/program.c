#include <stdint.h>
// 이미지 관련 정의 (80x60픽셀, 32bit 워드 기준)
#define IMG_WIDTH          80
#define IMG_HEIGHT         60
#define IMG_WORD_SIZE      1200   // (80*60) / 4 (1워드당 4픽셀)
#define IMG_BYTE_SIZE      4800   // 80 * 60
//-------------------<SYS CHECK>-----------------------------
#define SYS_ERR (-1)
#define SYS_OK (0)
//-------------------<ADDR>-----------------------------
// BASE
#define APB_BRAM            (0x10000000)
#define APB_IMG_FILE        (APB_BRAM + 0x1000U)
#define APB_PERIPHERAL_BASE (0x20000000)
#define APB_GPIO            (APB_PERIPHERAL_BASE + 0x2000U)
#define APB_FND             (APB_PERIPHERAL_BASE + 0x3000U)
#define APB_UART            (APB_PERIPHERAL_BASE + 0x4000U)
// OFFSET
#define __IO volatile

typedef struct
{
    __IO uint32_t CTRL;
    __IO uint32_t ODATA;
    __IO uint32_t IDATA;
} GPIO_TYPEDEF;
#define GPIO ((GPIO_TYPEDEF *)APB_GPIO)

typedef struct
{
    __IO uint32_t CTRL;
    __IO uint32_t ODATA;
} FND_TYPEDEF;
#define FND ((FND_TYPEDEF *)APB_FND)

typedef struct
{
    __IO uint32_t CTRL;
    __IO uint32_t BAUD;
    __IO uint32_t STATUS;
    __IO uint32_t TXDATA;
    __IO uint32_t RXDATA;
} UART_TYPEDEF;
#define UART ((UART_TYPEDEF *)APB_UART)

//-------------------<FNC>-----------------------------
/* Type your code here, or load an example. */
int sys_init(void);
void delay_ms(int delay);
//GPIO
void GPIO_init(GPIO_TYPEDEF *GPIOx, unsigned int control);
unsigned int sw_read(GPIO_TYPEDEF *GPIOx);
//FND
void FND_init(FND_TYPEDEF *FNDx, unsigned int control);
void FND_write(FND_TYPEDEF *FNDx, unsigned int wdata);
//UART
void UART_init(UART_TYPEDEF *UARTx, unsigned int control, unsigned int baud);
unsigned int UART_status(UART_TYPEDEF *UARTx);
void UART_putc(UART_TYPEDEF *UARTx, unsigned int wdata);
unsigned int UART_getc(UART_TYPEDEF *UARTx);
void send_image_to_uart(unsigned int base_addr);
//-------------------<Main>-----------------------------
void main(void)
{
             int time       = 0;
             int ret        = SYS_ERR;
    unsigned int sw         = 0, sw_past = 0;
    unsigned int blink_flag = 0;
    unsigned int uart_get   = 0;
    unsigned int img_base_addr = APB_IMG_FILE;

    // SYS CHECK
    ret = sys_init();
    if (ret == SYS_ERR)
        return;

    time = 1000;

    // RUN
    while (1)
    {
        if (!time)
        {
            // 1sec
            time = 1000;
            sw = sw_read(GPIO);
            //sw 동작시
            if      (sw == 3) img_base_addr = APB_IMG_FILE + 0xe10;
            else if (sw == 2) img_base_addr = APB_IMG_FILE + 0x960U;
            else if (sw == 1) img_base_addr = APB_IMG_FILE + 0x4b0U;
            else              img_base_addr = APB_IMG_FILE;



            // send uart
            if (!(UART_status(UART) & 0b1))
            {
                send_image_to_uart(img_base_addr);
            }
        }
        delay_ms(1);
        time--;
        // display FND
        FND_write(FND, time);
    }

    return;
}

//-------------------<FCN>-----------------------------

unsigned int UART_status(UART_TYPEDEF *UARTx)
{
    return UARTx->STATUS;
}
void UART_putc(UART_TYPEDEF *UARTx, unsigned int wdata)
{
    UARTx->TXDATA = wdata;
    UARTx->CTRL = 0x1; // TX_start
    UARTx->CTRL = 0x0; // TX_start
    return;
}
void send_image_to_uart(unsigned int base_addr) {
    unsigned int current_addr = base_addr;
    unsigned int word_data;
    int a = 0;
    while(UART_status(UART) & 0x1);
    UART_putc(UART, 0xaa);
    while(UART_status(UART) & 0x1);
    UART_putc(UART, 0x55);

    // 1200번 반복 (루프 카운트는 덧셈/비교라 괜찮음)
    for (int i = 0; i < 1200; i++) {
        // 직접 주소에서 읽기 (*(unsigned int *))
        word_data = *(volatile unsigned int *)current_addr;

        // 1워드(4픽셀) 쪼개서 보내기
        for (int j = 0; j < 4; j++) {
            while (UART_status(UART) & 0x1); // TX Full 체크
            
            // 시프트와 비트연산은 RV32I 기본!
            unsigned int pixel = (word_data >> (j << 3)) & 0xFF; // j*8 대신 j<<3
            UART_putc(UART, pixel);
        }

        // 주소를 4씩 증가 (다음 워드) - 곱셈 대신 덧셈 사용!
        current_addr = current_addr + 4;
    }
}
unsigned int UART_getc(UART_TYPEDEF *UARTx)
{
    return UARTx->RXDATA;
}

void FND_write(FND_TYPEDEF *FNDx, unsigned int wdata)
{
    FNDx->ODATA = wdata;
    return;
}

unsigned int sw_read(GPIO_TYPEDEF *GPIOx)
{
    return GPIOx->IDATA;
}
void delay_ms(int delay)
{
    int i = 0, j = 0, k = 0;
    for (i = 0; i < delay; i++)
    {
        for (j = 0; j < 100000 / 32; j++)
            k = k + 1;
    }
    return;
}
//init
int sys_init(void)
{
    int i = 0;
    // RAM
    *(unsigned int *)APB_BRAM = 0x00000001;
    // RAM Read Test
    i = *(unsigned int *)APB_BRAM;
    if (i != 0x00000001)
    {
        // error message output
        // UART_PRINT("SYS_ERR");
        return SYS_ERR;
    }

    // GPO
    *(unsigned int *)GPIO->CTRL = 0x00000000;  // GPO control register
    *(unsigned int *)GPIO->ODATA = 0x00000000; // GPO output register

    // FND
    *(unsigned int *)FND->CTRL = 0x00000000;    // FND control register
    *(unsigned int *)FND->ODATA = 0x00000000;   // FND output register
    
    // UART
    *(unsigned int *)UART->CTRL = 0x00000000;   // FND control register
    *(unsigned int *)UART->BAUD = 0x00000000;   // FND baudrate register
    *(unsigned int *)UART->TXDATA = 0x00000000; // FND output register

    GPIO_init(GPIO, 0x0); // sw[1:0]
    FND_init(FND, 0x00003fff);   // FND [13:0] : FND ~9999
    UART_init(UART, 0x0, 0x0);   // UART
    return SYS_OK;
}
void UART_init(UART_TYPEDEF *UARTx, unsigned int control, unsigned int baud)
{
    UARTx->CTRL = control;
    UARTx->BAUD = baud;
}
void FND_init(FND_TYPEDEF *FNDx, unsigned int control)
{
    FNDx->CTRL = control;
}
void GPIO_init(GPIO_TYPEDEF *GPIOx, unsigned int control)
{
    GPIOx->CTRL = control;
}

