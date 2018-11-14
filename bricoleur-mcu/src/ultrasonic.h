/*
 * ultrasonic.h
 *
 *  Created on: 7. nov. 2018
 *      Author: olatoft
 */

#ifndef SRC_ULTRASONIC_H_
#define SRC_ULTRASONIC_H_

#include <stdbool.h>

#define numberOfSensors 2

// 2D line on the form y = ax + b
typedef struct Line {
    float a;
    float b;
} Line;

typedef struct Position {
    float x;
    float y;
} Position;

typedef struct Buffer {
	unsigned int head;
	unsigned int tail;
	unsigned int length;
	unsigned int maxLength;
	bool wrapped;
} Buffer;

void setupUltrasonic(Buffer *buffer);
int getPosition(Position *position, unsigned int distances[], unsigned int length);
void getLine(Line *line, Position positions[], unsigned int length);
void getInput(unsigned int distances[], unsigned int length);
float chanceOfCollision(Line *line);
void panic();
bool isMoving(unsigned int distances[], unsigned int previousDistances[], unsigned int treshold);
bool isObject(unsigned int distances[]);
void setWallDistances(unsigned int wallDistances[]);
float getUltrasonicLocalConclusion(Buffer *buffer, Position positions[], unsigned int previousDistances[]);
void addConclusion(float conclusion);
float getConclusion(void);
void flushBuffer(Buffer *buffer);

#endif /* SRC_ULTRASONIC_H_ */
