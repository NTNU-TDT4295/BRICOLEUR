#include <stdio.h>
#include "em_device.h"
#include "em_chip.h"
#include "em_timer.h"
#include "em_lcd.h"
#include "em_cmu.h"
#include "em_gpio.h"
#include "segmentlcd.h"
#include "sensor.h"

#define BUF_LEN 8

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

float ping_hc_sr04(GPIO_Port_TypeDef port, unsigned int pin) {
	/* How to operate HC-SR04:
	 *   set trigger high
	 *   wait 1 ms
	 *   set trigger low
	 *   wait 50 ms
	 *   read pulse length on echo, uS / 58 = centimeters
	 *   wait 10 ms
	 **/
	GPIO_PinOutSet(port, pin);
	delay(1);
	GPIO_PinOutClear(port, pin);
	delay(50);
	float pulse_length_us = TIMER_CaptureGet(TIMER0, 0) * timer0_ticks_per_us;
	float cm_distance = pulse_length_us / 58;
	delay(10);
	return cm_distance;
}

float getDistance(unsigned int i) {
	float cm_distance = ping_hc_sr04(triggers[i].port, triggers[i].pin);

	char dist_str[BUF_LEN];
	snprintf(dist_str, BUF_LEN, "%f", cm_distance);
	SegmentLCD_Write(dist_str);

	return cm_distance;
}

void setupSensor(void) {
	CMU_ClockEnable(cmuClock_TIMER0, true);
	CMU_ClockEnable(cmuClock_TIMER1, true);
	CMU_ClockEnable(cmuClock_GPIO, true);

	// TIMER0 is set up so that it will capture the length of high pulses on the TIMER0_CC0 pin

	// Set up PD1 as input, is pin connected to TIMER0_CC0
	GPIO_PinModeSet(gpioPortD, 1, gpioModeInput, 0);

	// Set up capture channel 0 on TIMER0 so that it captures when the pin input falls
	TIMER_InitCC_TypeDef timerCC_init = TIMER_INITCC_DEFAULT;
	timerCC_init.edge = timerEdgeFalling;
	timerCC_init.prsInput = false;
	timerCC_init.mode = timerCCModeCapture;
	TIMER_InitCC(TIMER0, 0, &timerCC_init);

	// Enable CC0 input, TIMER1_CC0 is pin PD1 in location 3
	TIMER0->ROUTE |= TIMER_ROUTE_CC0PEN | TIMER_ROUTE_LOCATION_LOC3;

	// Set up TIMER0 so that it reloads (sets counter value to 0) and starts the timer when CC0 rises
	TIMER_Init_TypeDef timer0_init = TIMER_INIT_DEFAULT;
	timer0_init.riseAction = timerInputActionReloadStart;
	timer0_init.enable = false;
	TIMER_Init(TIMER0, &timer0_init);

	// TIMER1 used for time keeping, interrupt on overflow every millisecond
	NVIC_EnableIRQ(TIMER1_IRQn);
	TIMER_Init_TypeDef timer1_init = TIMER_INIT_DEFAULT;
	TIMER_Init(TIMER1, &timer1_init);
	unsigned long timer1_top = CMU_ClockFreqGet(cmuClock_TIMER1) / 1000;
	TIMER_TopSet(TIMER1, timer1_top);
	TIMER_IntEnable(TIMER1, TIMER_IF_OF);

	// Set trigger pins as output
	for (int i = 0; i < NUM_TRIGGERS; i++) {
		GPIO_PinModeSet(triggers[i].port, triggers[i].pin, gpioModePushPull, 0);
	}

	timer0_ticks_per_us = 1000 * 1000
			/ (float) CMU_ClockFreqGet(cmuClock_TIMER0);

	// A small delay so that the sensors can start up
	delay(1000);
}
