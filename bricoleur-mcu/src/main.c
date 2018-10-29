/******************************************************************************
 * @file
 * @brief Empty Project
 * @author Energy Micro AS
 * @version 3.20.2
 ******************************************************************************
 * @section License
 * <b>(C) Copyright 2014 Silicon Labs, http://www.silabs.com</b>
 *******************************************************************************
 *
 * This file is licensed under the Silicon Labs Software License Agreement. See 
 * "http://developer.silabs.com/legal/version/v11/Silicon_Labs_Software_License_Agreement.txt"  
 * for details. Before using this software for any purpose, you must agree to the 
 * terms of that agreement.
 *
 ******************************************************************************/
#include "stdio.h"
#include "math.h"
#include "stdbool.h"
#include "stdlib.h"
#include "string.h"
#include "em_device.h"
#include "em_chip.h"
#include "em_usart.h"
#include "em_cmu.h"
#include "em_gpio.h"
#include "bricoleur.h"

/******************************************************************************
 * Config
 *****************************************************************************/
// TODO: Move some of this to bricoleur.h ?

/* Sensor analysis
 ****************/
#define numberOfSensors 2


/* USART transmission
 *******************/
#define outStringMaxLen 64
#define recvBuffMaxLen 64


/******************************************************************************
 * Functions
 *****************************************************************************/

void do_usart_setup() {
    /* USART is a HFPERCLK peripheral. Enable HFPERCLK domain and USART1.
     * We also need to enable the clock for GPIO to configure pins. */
    CMU_ClockEnable(cmuClock_HFPER, true);
    CMU_ClockEnable(cmuClock_GPIO, true);

    /*
     * Setup for USART1 / USART-AUX
     */
  
    CMU_ClockEnable(cmuClock_USART1, true);
    // Synchronous
    USART_InitSync_TypeDef initSync1 = USART_INITSYNC_DEFAULT;
    /* Operate as SPI master */
    initSync1.master = true;
    /* Clock idle low, sample on falling edge. */
    initSync1.clockMode = usartClockMode1;
    USART_InitSync(USART1, &initSync1);

    /* Pin numbers:
     * Name             MCU    EXP
     * USART1_TX	PC0
     * USART1_RX	PC1
     * USART1_CLK	PB7
     * USART1_CS	PB8    (UNUSED)
     */

    /* Enable I/O and set location */
    USART1->ROUTE = USART_ROUTE_RXPEN | USART_ROUTE_TXPEN | USART_ROUTE_LOCATION_LOC1;
    /* Also enable CS and CLK pins if the USART is configured for synchronous mode.
     * Set GPIO mode. */
    USART1->ROUTE |= USART_ROUTE_CSPEN | USART_ROUTE_CLKPEN;
    GPIO_PinModeSet((GPIO_Port_TypeDef)AF_USART1_TX_PORT(USART_AUX_PORTNUM),
       AF_USART1_TX_PIN(USART_AUX_PORTNUM), gpioModePushPull, 0);
    GPIO_PinModeSet((GPIO_Port_TypeDef)AF_USART1_RX_PORT(USART_AUX_PORTNUM), 
      AF_USART1_RX_PIN(USART_AUX_PORTNUM), gpioModeInput, 0);
    GPIO_PinModeSet((GPIO_Port_TypeDef)AF_USART1_CS_PORT(USART_AUX_PORTNUM), 
      AF_USART1_CS_PIN(USART_AUX_PORTNUM), gpioModePushPull, 0);
    GPIO_PinModeSet((GPIO_Port_TypeDef)AF_USART1_CLK_PORT(USART_AUX_PORTNUM),
      AF_USART1_CLK_PIN(USART_AUX_PORTNUM), gpioModePushPull, 0);

    /*
     * Setup for USART0 / USART-PYNQ
     */
  
    CMU_ClockEnable(cmuClock_USART0, true);
    // Synchronous
    USART_InitSync_TypeDef initSync0 = USART_INITSYNC_DEFAULT;
    /* Operate as SPI master */
    initSync0.master = false;
    /* Clock idle low, sample on falling edge. */
    initSync0.clockMode = usartClockMode1;

    USART_InitSync(USART0, &initSync0);

    /* Pin numbers:
     * Name             MCU    EXP
     * USART1_TX	PC11
     * USART1_RX	PC10
     * USART1_CLK	PC9
     * USART1_CS	PC8    (UNUSED)
     */

    /* Enable I/O and set location */
    USART1->ROUTE = USART_ROUTE_RXPEN | USART_ROUTE_TXPEN | USART_FPGA_LOC;
    /* Also enable CS and CLK pins if the USART is configured for synchronous mode.
     * Set GPIO mode. */
    USART1->ROUTE |= USART_ROUTE_CSPEN | USART_ROUTE_CLKPEN;
    GPIO_PinModeSet((GPIO_Port_TypeDef)AF_USART1_TX_PORT(USART_FPGA_PORTNUM),
      AF_USART1_TX_PIN(USART_FPGA_PORTNUM), gpioModePushPull, 0);
    GPIO_PinModeSet((GPIO_Port_TypeDef)AF_USART1_RX_PORT(USART_FPGA_PORTNUM),
      AF_USART1_RX_PIN(USART_FPGA_PORTNUM), gpioModeInput, 0);
    GPIO_PinModeSet((GPIO_Port_TypeDef)AF_USART1_CS_PORT(USART_FPGA_PORTNUM),
      AF_USART1_CS_PIN(USART_FPGA_PORTNUM), gpioModeInputPull, 0);
    GPIO_PinModeSet((GPIO_Port_TypeDef)AF_USART1_CLK_PORT(USART_FPGA_PORTNUM), 
      AF_USART1_CLK_PIN(USART_FPGA_PORTNUM), gpioModeInput, 0);
}

void sendString(USART_TypeDef *usart, char *string) {
    /* Send a string on the given USART.
     * USART_Tx calls will stall if TX buffer is full,
     * which means that this function blocks until sending is completed.
     */
    for (int i = 0; string[i] != '\0'; i++) {
        USART_Tx(usart, string[i]);
    }
}

int receiveData(USART_TypeDef *usart, Buffer *buffer) {
    /* Receive a frame of data on the given USART. 
     * Blocks until a full frame has arrived.
     * Returns number of received bytes.
     */

    // Reset buffer, overwrite old data
    buffer->head = 0;
    buffer->tail = buffer->head;
    buffer->length = 0;
    buffer->wrapped = false;

    // Skip incomplete frames
    char readVal;
    readVal = USART_Rx(usart);
    while(readVal != '\0') {
        readVal = USART_Rx(usart);
    }
    
    // Write complete frame to buffer
    do {
        readVal = USART_Rx(usart);
        (buffer->data)[buffer->tail++] = readVal;
        if (buffer->tail == buffer->head) {
            // Transmitted frame was too large
            buffer->wrapped = true;
        }
    }  while(readVal != '\0');

    // Return with negative number if buffer overflowed
    if (buffer->wrapped) {
        return -1;
    }     
}

void createCommand(Buffer *input, char *outString) {
    // Read data from buffer

    // Determine appropriate message to AUX device (can be 1:1 copy of input)
}

/**************************************************************************//**
 * @brief  Main function
 *****************************************************************************/
int main(void) {
    /* Chip errata */
    CHIP_Init();
    do_usart_setup();
    // TODO: Check out DMA setup?

    /* Define some buffers for receiving and sending data */

    Buffer ULTRA_Buf = {
        .head = 0,
        .tail = 0, 
        .length = 0, 
        .maxLength = 64, 
        .wrapped = false, 
    };  

    // Buffer for reception of data from PYNQ
    Buffer FPGA_Rx_Buf = {
        .head = 0,
        .tail = 0, 
        .length = 0, 
        .maxLength = recvBuffMaxLen, 
        .wrapped = false, 
    };  

    // Data to send to FPGA
    char FPGA_Tx_String[outStringMaxLen];
    

    // Data to send to AUX device
    char AUX_Tx_String[outStringMaxLen];

    /* Infinite loop */
    while (1) {
        /* Protocol for PYNQ and external device communication */

        // Read sensor data sequentially from active sensors

        // Perform sensor analysis

        // Transmit sensor data to PYNQ
        sendString(USART0, FPGA_Tx_String);
        // Receive data from PYNQ, write to AUX_Buf
        receiveData(USART0, &FPGA_Rx_Buf);

        // Interpret PYNQ output data, translate to external command
        createCommand(&FPGA_Rx_Buf, AUX_Tx_String);

        // Output new instruction to external device
        sendString(USART1, AUX_Tx_String); // Forward FPGA instructions to device
    }
}


