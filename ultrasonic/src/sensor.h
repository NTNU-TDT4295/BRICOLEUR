/*
 * sensor.h
 *
 *  Created on: 3. okt. 2018
 *      Author: olatoft
 */

#ifndef SRC_SENSOR_H_
#define SRC_SENSOR_H_

typedef struct Triggers {
	GPIO_Port_TypeDef port;
	unsigned int pin;
} Triggers;

void TIMER1_IRQHandler(void);
unsigned long millis(void);
void delay(unsigned int m);
unsigned int ping_ez0(GPIO_Port_TypeDef port, unsigned int pin);
unsigned int getDistance(unsigned int i);
void setupSensor(void);

#endif /* SRC_SENSOR_H_ */
