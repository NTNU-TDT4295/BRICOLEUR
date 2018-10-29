/**************************************************************************//**
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
#include "em_device.h"
#include "em_chip.h"
#include "em_usart.h"
#include "em_cmu.h"
#include "em_gpio.h"


void do_usart_setup() {

  /* USART is a HFPERCLK peripheral. Enable HFPERCLK domain and USART1.
   * We also need to enable the clock for GPIO to configure pins. */
  CMU_ClockEnable(cmuClock_HFPER, true);
  CMU_ClockEnable(cmuClock_USART1, true);
  CMU_ClockEnable(cmuClock_GPIO, true);

  /* Initialize with default settings and then update fields according to application requirements. */

  // Synchronous
  USART_InitSync_TypeDef initSync = USART_INITSYNC_DEFAULT;
  /* Operate as SPI master */
  initSync.master = false;
  /* Clock idle low, sample on falling edge. */
  initSync.clockMode = usartClockMode1;

  USART_InitSync(USART1, &initSync);

  /* Pin numbers:
   * Name		MCU		EXP
   * USART1_TX	PD0		4
   * USART1_RX	PD1		6
   * USART1_CLK	PD2		8
   * USART1_CS	PD3		10
   */

  #define USER_LOCATION USART_ROUTE_LOCATION_LOC1

  /* Enable I/O and set location */
  USART1->ROUTE = USART_ROUTE_RXPEN | USART_ROUTE_TXPEN | USER_LOCATION;
  /* Also enable CS and CLK pins if the USART is configured for synchronous mode.
   * Set GPIO mode. */
  USART1->ROUTE |= USART_ROUTE_CSPEN | USART_ROUTE_CLKPEN;
  unsigned int usartPortNum = 1;
  GPIO_PinModeSet((GPIO_Port_TypeDef)AF_USART1_TX_PORT(usartPortNum), AF_USART1_TX_PIN(usartPortNum), gpioModePushPull, 0);
  GPIO_PinModeSet((GPIO_Port_TypeDef)AF_USART1_RX_PORT(usartPortNum), AF_USART1_RX_PIN(usartPortNum), gpioModeInput, 0);
  GPIO_PinModeSet((GPIO_Port_TypeDef)AF_USART1_CS_PORT(usartPortNum), AF_USART1_CS_PIN(usartPortNum), gpioModeInputPull, 0);
  GPIO_PinModeSet((GPIO_Port_TypeDef)AF_USART1_CLK_PORT(usartPortNum), AF_USART1_CLK_PIN(usartPortNum), gpioModeInput, 0);

}


/**************************************************************************//**
 * @brief  Main function
 *****************************************************************************/
int main(void)
{
  /* Chip errata */
  CHIP_Init();
  do_usart_setup();

  uint8_t recv_byte = 0;
  while (1) {
	// Enable LEDS to indicate progress
	GPIO_PinModeSet(gpioPortC, 0, gpioModePushPull, 1);
	recv_byte = USART_Rx(USART1);
	GPIO_PinModeSet(gpioPortC, 1, gpioModePushPull, 1);
	if(recv_byte == 5) {
		GPIO_PinModeSet(gpioPortC, 2, gpioModePushPull, 1);
	}
	USART_Tx(USART1, recv_byte + 1);
	GPIO_PinModeSet(gpioPortC, 3, gpioModePushPull, 1);
	// Dirty wait
	for(int i = 0; i < 1000000; i++) {
		;
	}
	GPIO_PinOutClear(gpioPortC, 0);
	GPIO_PinOutClear(gpioPortC, 1);
	GPIO_PinOutClear(gpioPortC, 2);
	GPIO_PinOutClear(gpioPortC, 3
			);
	for(int i = 0; i < 1000000; i++) {
		;
	}
  }
}
