/*
 * main.h
 *
 *  Created on: 3. okt. 2018
 *      Author: olatoft
 */

#ifndef SRC_MAIN_H_
#define SRC_MAIN_H_

#include <stdbool.h>

typedef struct Position {
    float x;
    float y;
} Position;

// 2D line on the form y = ax + b
typedef struct Line {
    float a;
    float b;
} Line;

typedef struct Buffer {
	unsigned int head;
	unsigned int tail;
	unsigned int length;
	unsigned int maxLength;
	bool wrapped;
} Buffer;

int getPosition(Position *position, unsigned int distances[], unsigned int length);
void getLine(Line *line, Position positions[], unsigned int length);
void getInput(unsigned int distances[], unsigned int length);
bool willCollide2D(Line *line);
void panic();
bool isMoving(unsigned int distances[], unsigned int previousDistances[], unsigned int treshold);
bool isObject(unsigned int distances[]);
void setWallDistances(unsigned int wallDistances[]);
void sendString(USART_TypeDef *usart, char *string);
void setupDebugUsart(void);

#endif /* SRC_MAIN_H_ */
