/*******************************************************************************
 * Project and custom hardware specific definitions
 ******************************************************************************/
// PCB: L2 er 220nH i stedet for 1000

// On-board LEDs
#define DBG_LED_PORT gpioPortE
#define DBG_LED_1 2
#define DBG_LED_2 3
#define DBG_LED_3 4

// Push buttons
#define DBG_PB_PORT gpioPortB
#define DBG_PB_1 9
#define DBG_PB_2 10
#define DBG_PB_3 11

// Ultrasonic sensors
#define ULTRA_PORT gpioPortA
#define ULTRA_PULSE 0
#define ULTRA_RX0 3
#define ULTRA_RX1 4 
#define ULTRA_RX2 5
#define ULTRA_NUM 2  // Number of sensors in use

// USART-AUX - feeds status to external entity
// NOTE: There are two different ports, sorry
#define USART_AUX_PORT_1 gpioPortC  // For TX and RX
#define USART_AUX_PORT_2 gpioPortB  // For CLK
#define USART_AUX_TX 0
#define USART_AUX_RX 1
#define USART_AUX_CLK 7
#define USART_AUX_CS 8  // Unused
#define USART_AUX_LOC USART_ROUTE_LOCATION_LOC0
#define USART_AUX_PORTNUM 0

// USART-FPGA - data transfer to and from PYNQ
#define USART_FPGA_PORT gpioPortC
#define USART_FPGA_TX 11
#define USART_FPGA_RX 10
#define USART_FPGA_CLK 9
#define USART_FPGA_CS 8
#define USART_FPGA_LOC USART_ROUTE_LOCATION_LOC2 
#define USART_FPGA_PORTNUM 0

// USB - Not really used, but here for the sake of completion
#define USB_PORT gpioPortF
#define USB_R_Dn 11
#define USB_R_Dp 10


typedef struct usart_buffer_t {
    unsigned int head;
    unsigned int tail;
    unsigned int length;
    unsigned int maxLength;
    bool wrapped;
    char data[64];  // Treat as byte array
} USART_Buffer;
