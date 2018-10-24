/*
 * main.h
 *
 *  Created on: 3. okt. 2018
 *      Author: olatoft
 */

#ifndef SRC_MAIN_H_
#define SRC_MAIN_H_

#include <stdbool.h>

typedef struct Position2D {
    float x;
    float y;
} Position2D;

typedef struct Position3D {
    float x;
    float y;
    float z;
} Position3D;

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

int getPosition2D(Position2D *position, float distances[], unsigned int length);
void getPosition3D(Position3D *position, float r1, float r2, float r3);
void getLine(Line *line, Position2D positions[], unsigned int length);
void getInput(float distances[], unsigned int length);
bool willCollide2D(Line *line);
void panic();
bool isMoving(float distances[], float previousDistances[], float treshold);
void setWallDistances(float wallDistances[]);
void buildString(char *string, unsigned int length);
void sendString(char *string);

#endif /* SRC_MAIN_H_ */
