/*
 * main.h
 *
 *  Created on: 3. okt. 2018
 *      Author: olatoft
 */

#ifndef SRC_MAIN_H_
#define SRC_MAIN_H_

uint8_t localToGlobalConclusion(float input, float inputMin, float inputMax, float outputMin, float outputMax);
uint8_t getCombinedConclusion(uint8_t cameraConclusion, uint8_t ultrasonicConclusion);

#endif /* SRC_MAIN_H_ */
