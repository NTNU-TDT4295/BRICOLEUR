/*
 * sensor.h
 *
 *  Created on: 3. okt. 2018
 *      Author: olatoft
 */

#ifndef SRC_SENSOR_H_
#define SRC_SENSOR_H_

void TIMER1_IRQHandler(void);
unsigned long millis(void);
void delay(unsigned int m);
float ping_hc_sr04(GPIO_Port_TypeDef port, unsigned int pin);
float getDistance(void);
void setupSensor(void);

#endif /* SRC_SENSOR_H_ */
