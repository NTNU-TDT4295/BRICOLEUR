/*******************************************************************************
 * @file
 * @brief Bricoleur MCU 
 * @author Energy Micro AS
 * @version 3.20.2
 *******************************************************************************
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
#include "string.h"
#include "em_device.h"
#include "em_chip.h"
#include "em_usart.h"
#include "em_cmu.h"
#include "em_gpio.h"
#include "bricoleur.h"
#include "main.h"
#include "ultrasonic.h"

// TODO: Check out DMA setup?
// TODO: I don't really know what I want to do with the receive buffers
// TODO: Sensor analysis code
// TODO: Make the whole process less stop and wait
// TODO: test

/*******************************************************************************
 * Structure
 ******************************************************************************/
/*
 Do MCU main operations here.
 PCB and project specific values go to bicoleur.h.
 Sensor specific operations go to sensors.c and .h 
*/

/*******************************************************************************
 * Config
 ******************************************************************************/
// Place values for quick tweaking here. 

/* Sensor analysis
 ****************/
#define numberOfSensors 2

/* USART transmission
 *******************/
#define outStringMaxLen 64
#define recvBuffMaxLen 64  // Must be the same as in bricoleur.h
#define recvTimeout 100

/* Debug LED interpretation
 * What do those blinking lights mean?
 ************************************/
 
/* 
 * 1) On when transmitting on USART
 * 2) On when receiving on USART

 */

/* Debug pushbutton actions
 *************************/



/*******************************************************************************
 * Definitions
 ******************************************************************************/

unsigned int wallDistances[numberOfSensors];

void set_dbg_LED(int LEDNum, bool on) {
    if (on) {   
        GPIO_PinModeSet(DBG_LED_PORT, LEDNum, gpioModePushPull, 1);
    } else {
        GPIO_PinOutClear(DBG_LED_PORT, LEDNum);
    }
}

void do_usart_setup() {
    /* USART is a HFPERCLK peripheral. Enable HFPERCLK domain and USART1.
     * We also need to enable the clock for GPIO to configure pins. */
    CMU_ClockEnable(cmuClock_HFPER, true);
    CMU_ClockEnable(cmuClock_GPIO, true);

    /*
     * Setup for USART1 / USART-AUX as UART
     */
  
    CMU_ClockEnable(cmuClock_USART1, true);
    // Asynchronous
    USART_InitAsync_TypeDef initAsync1 = USART_INITASYNC_DEFAULT;
    initAsync1.baudrate = 115200;
    USART_InitAsync(USART1, &initAsync1);

    /* Pin numbers:
     * Name             MCU    EXP
     * USART1_TX	PC0
     * USART1_RX	PC1
     * USART1_CLK	PB7
     * USART1_CS	PB8    (UNUSED)
     */

    /* Enable I/O and set location */
    USART1->ROUTE = USART_ROUTE_RXPEN | USART_ROUTE_TXPEN | USART_AUX_LOC;
    /* Set GPIO mode. */
    GPIO_PinModeSet((GPIO_Port_TypeDef)AF_USART1_TX_PORT(USART_AUX_PORTNUM),
       AF_USART1_TX_PIN(USART_AUX_PORTNUM), gpioModePushPull, 1);
    GPIO_PinModeSet((GPIO_Port_TypeDef)AF_USART1_RX_PORT(USART_AUX_PORTNUM), 
      AF_USART1_RX_PIN(USART_AUX_PORTNUM), gpioModeInput, 0);
}

void do_pynq_setup() {
    /*
     * Setup for PYNQ communication
     */
  
    /* Pin numbers:
     * Name             MCU    EXP
     * USART1_TX	PC11
     * USART1_RX	PC10
     * USART1_CLK	PC9
     * USART1_CS	PC8    (UNUSED)
     */

    /* Enable I/O and set location */
    GPIO_PinModeSet(USART_FPGA_PORT, USART_FPGA_TX, gpioModeInputPull, 0);
    GPIO_PinModeSet(USART_FPGA_PORT, USART_FPGA_RX, gpioModeInputPull, 0);
    GPIO_PinModeSet(USART_FPGA_PORT, USART_FPGA_CLK, gpioModeInputPull, 0);
}

void USART_send(USART_TypeDef *usart, char *string) {
    /* Send a string on the given USART.
     * USART_Tx calls will stall if TX buffer is full,
     * which means that this function blocks until sending is completed.
     */
    set_dbg_LED(1, true); 
    for (int i = 0; string[i] != '\0'; i++) {
        USART_Tx(usart, string[i]);
    }
    set_dbg_LED(1, false);
}

int USART_recv(USART_TypeDef *usart, USART_Buffer *buffer, int abort) {
    /* Receive a frame of data on the given USART. 
     * Blocks until a full frame has arrived.
     * Returns number of received bytes.
     */

    int abortCount = abort;  // Safety in case endstring character never arrives
   
    set_dbg_LED(2, true);

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
        // Safeguard to prevent deadlock? What if \0 never arrives?
        if (--abortCount <= 0) {
            break; 
        }
    }
    
    // Reset abortCount
    abortCount = abort;
  
    // Write complete frame to buffer
    do {
        readVal = USART_Rx(usart);
        (buffer->data)[buffer->tail++] = readVal;
        buffer->length++;
        if (buffer->tail == buffer->head) {
            // Transmitted frame was too large
            buffer->wrapped = true;
        }

        // Safeguard to prevent deadlock? What if \0 never arrives?
        if (--abortCount >= 0) {
            break; 
        }

    }  while(readVal != '\0');

    // Return with negative number if buffer overflowed
    if (buffer->wrapped) {
        return -1;
    }     
    
    set_dbg_LED(2, false);
    return buffer->length;
}

void createCommand(USART_Buffer *input, char *outString) {
    // Determine appropriate message to AUX device (can be 1:1 copy of input)
    
    // Placeholder while protocol is unknown
    *outString = strdup(input->data);
}

// Scale linearly
uint8_t localToGlobalConclusion(float input, float inputMin, float inputMax, float outputMin, float outputMax) {
	float slope = 1.0 * (outputMax - outputMin) / (inputMax - inputMin);
	return (uint8_t)(outputMin + slope * (input - inputMin));
}

// @cameraWeight: Number between 0 and 1 indicating how much the cameraConclusion should be weighted.
uint8_t getCombinedConclusion(uint8_t cameraConclusion, uint8_t ultrasonicConclusion) {
	if (cameraConclusion > ultrasonicConclusion) {
		return cameraConclusion;
	} else {
		return ultrasonicConclusion;
	}
}

/**************************************************************************//**
 * @brief  Main function
 *****************************************************************************/
int main(void) {
    /* Chip errata, setup and calibration */
    CHIP_Init();
    do_usart_setup();
    do_pynq_setup();


	Buffer buffer;
	setupUltrasonic(&buffer);

	Position positions[buffer.maxLength];

	unsigned int previousDistances[numberOfSensors];


    // PCB: L2 er 220nH i stedet for 1000

    /* Define some buffers for receiving and sending data */

    USART_Buffer ULTRA_Buf = {
        .head = 0,
        .tail = 0, 
        .length = 0, 
        .maxLength = recvBuffMaxLen, 
        .wrapped = false, 
    };

    set_dbg_LED(2, true);

    /* Infinite loop */
    while (1) {
        /* Protocol for PYNQ and external device communication */

        // Read sensor data sequentially from active sensors

        // Perform sensor analysis
        // Local conclusion is the conclusion in a scale defined by the ultrasonic system (0 to 1)
        // Global conclusion is the local conclusion mapped to a scale which will be used by the imponator
        float ultrasonicLocalConclusion = getUltrasonicLocalConclusion(&buffer, positions, previousDistances);
        uint8_t ultrasonicGlobalConclusion = localToGlobalConclusion(ultrasonicLocalConclusion, 0, 1, 0, 255);

//        char stringBuffer[50];
//		snprintf(stringBuffer, 49, "conclusion: %u\n", ultrasonicGlobalConclusion);
//
//		for (int i = 0; stringBuffer[i] != '\0'; i++) {
//			USART_Tx(USART1, stringBuffer[i]);
//		}

        // End sensor reading line
//        USART_Tx(USART1, '\n');

        uint8_t bit0 = GPIO_PinInGet(USART_FPGA_PORT, USART_FPGA_TX);
        uint8_t bit1 = GPIO_PinInGet(USART_FPGA_PORT, USART_FPGA_RX);
        uint8_t bit2 = GPIO_PinInGet(USART_FPGA_PORT, USART_FPGA_CLK);

        // Local conclusion from camera system: Value between 0 and 7
        // Indicates chance of collision, where 7 is largest chance of collision
        // Based on whether an object is moving towards us or not
        uint8_t pynq_data = bit2 * 4 + bit1 * 2 + bit0;
        uint8_t cameraGlobalConclusion = localToGlobalConclusion(pynq_data, 0, 7, 0, 255);

        uint8_t combinedConclusion = getCombinedConclusion(cameraGlobalConclusion, ultrasonicGlobalConclusion);

        USART_Tx(USART1, combinedConclusion);
//        USART_Tx(USART1, '\n');

        /*

        // Interpret PYNQ output data, translate to external command
        createCommand(&FPGA_Rx_Buf, AUX_Tx_String);

        // Output new instruction to external device
        USART_send(USART1, AUX_Tx_String); // Forward FPGA instructions to device
        */
    }
}
