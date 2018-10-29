#include <stdio.h>
#include "em_device.h"
#include "em_chip.h"
#include "em_timer.h"
#include "em_lcd.h"
#include "em_cmu.h"
#include "em_gpio.h"
#include "em_usart.h"
#include "em_prs.h"
#include "segmentlcd.h"
#include "sensor.h"

#define BUF_LEN 8

#define SENSOR_USART UART0

#define NUM_TRIGGERS 2

const Triggers triggers[] = {
	{.port = gpioPortD, .pin = 6},
	{.port = gpioPortD, .pin = 5}
	// Add more trigger port-pin pairs for more sensors here
};

volatile unsigned long milliseconds = 0;
float timer0_ticks_per_us;

void TIMER1_IRQHandler(void) {
	TIMER_IntClear(TIMER1, TIMER_IF_OF);
	milliseconds++;
}

unsigned long millis(void) {
	return milliseconds;
}

void delay(unsigned int m) {
	// Busy wait until at least m milliseconds has passed
	unsigned long start = millis();
	while (millis() - start < m) {
		// wait
	}
}

unsigned int ping_ez0(GPIO_Port_TypeDef port, unsigned int pin) {
	/* How to operate LV-MaxSonar EZ0:
	 *   set trigger high
	 *   wait until R is received over UART
	 *   set trigger low
	 *   distance in inches is received as three ASCII digits, most significant digit first
	 *   a carriage return is received
	 *   wait 5 ms
	 **/
	GPIO_PinOutSet(port, pin);
	while (USART_Rx(SENSOR_USART) != 'R') {};  // Wait till start of response
	GPIO_PinOutClear(port, pin);
	unsigned int digit3 = USART_Rx(SENSOR_USART) - '0';
	unsigned int digit2 = USART_Rx(SENSOR_USART) - '0';
	unsigned int digit1 = USART_Rx(SENSOR_USART) - '0';
	USART_Rx(SENSOR_USART);  // \r
	unsigned int inch_distance = digit3 * 100 + digit2 * 10 + digit1;
	delay(5);
	return inch_distance;
}

unsigned int getDistance(unsigned int i) {
	return ping_ez0(triggers[i].port, triggers[i].pin);
}

void setupSensor(void) {
	/* Set up timer 1 to be used in delay() */
	CMU_ClockEnable(cmuClock_TIMER1, true);

	// TIMER1 used for time keeping, interrupt on overflow every millisecond
	NVIC_EnableIRQ(TIMER1_IRQn);
	TIMER_Init_TypeDef timer1_init = TIMER_INIT_DEFAULT;
	TIMER_Init(TIMER1, &timer1_init);
	unsigned long timer1_top = CMU_ClockFreqGet(cmuClock_TIMER1) / 1000;
	TIMER_TopSet(TIMER1, timer1_top);
	TIMER_IntEnable(TIMER1, TIMER_IF_OF);


	/* Set up sensor trigger pins and do sensor startup procedure */
	CMU_ClockEnable(cmuClock_GPIO, true);

	// Set trigger pins as output
	for (int i = 0; i < NUM_TRIGGERS; i++) {
		GPIO_PinModeSet(triggers[i].port, triggers[i].pin, gpioModePushPull, 0);
	}

	// Sensors needs 250 ms to start up after power on
	delay(300);

	// Run calibration cycle, i.e. let each sensor do two 49 ms cycles
	for (int i = 0; i < NUM_TRIGGERS; i++) {
		GPIO_PinOutSet(triggers[i].port, triggers[i].pin);
		// Set RX low after second cycle has started so that it doesn't start a third reading
		delay(75);
		GPIO_PinOutClear(triggers[i].port, triggers[i].pin);
		// Wait rest of cycle
		delay(25);
	}


	/* Set up UART for sensor input
	 * Supports input on all GPIO pin, input is routed to UART using PRS
	 * Sensors output inverted serial, so RX has to be inverted
	 **/
	CMU_ClockEnable(cmuClock_HFPER, true);
	CMU_ClockEnable(cmuClock_UART0, true);
	CMU_ClockEnable(cmuClock_GPIO, true);
	CMU_ClockEnable(cmuClock_PRS, true);

	USART_PRS_Channel_t uartPRSchannel = usartPrsRxCh0;
	USART_InitAsync_TypeDef initAsync = USART_INITASYNC_DEFAULT;
	initAsync.baudrate = 9600;
	initAsync.enable = usartEnableRx;
	initAsync.prsRxEnable = true;
	initAsync.prsRxCh = uartPRSchannel;
	USART_InitAsync(SENSOR_USART, &initAsync);

	SENSOR_USART->ROUTE = USART_ROUTE_RXPEN;
	SENSOR_USART->CTRL |= USART_CTRL_RXINV;

	GPIO_PinModeSet(gpioPortD, 2, gpioModeInput, 0);
	GPIO_ExtIntConfig(gpioPortD, 2, 2, false, false, false);

	PRS_SourceSignalSet(uartPRSchannel,
						PRS_CH_CTRL_SOURCESEL_GPIOL,
						PRS_CH_CTRL_SIGSEL_GPIOPIN2,
						prsEdgeOff);
}
