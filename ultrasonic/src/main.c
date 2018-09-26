// Explanation and derivation of formulas used:
// https://docs.google.com/document/d/1bng-I3OrYp1IoY3vhtT-xtBhCldARYmhWZ4Pq9hrSdY/edit

#include "em_device.h"
#include "em_chip.h"
#include "em_lcd.c"
#include "em_cmu.c"
#include "segmentlcd.c"
#include <stdio.h>
#include <math.h>

#define x2 4  // Distance along the x axis from origo to sensor 2
#define y3 4  // Distance along the y axis from origo to sensor 3

struct position2D {
    float x;
    float y;
};

struct position3D {
    float x;
    float y;
    float z;
};

// 2D line on the form y = ax + b
struct line {
    float a;
    float b;
};

typedef struct position2D Position2D;
typedef struct position3D Position3D;
typedef struct line Line;

void getPosition2D(Position2D *position, float r1, float r2);
void getPosition3D(Position3D *position, float r1, float r2, float r3);
void getLine(Line *line, Position2D positions[], int length);
void getInput(float distances[], int length);
bool willCollide2D(Line *line);
void panic();
bool isMoving(Position2D positions[], int positionsLength);

void getPosition2D(Position2D *position, float r1, float r2) {
    position->x = (x2*x2 + r1*r1 - r2*r2) / (2 * x2);
    position->y = sqrtf(r1*r1 - position->x * position->x);
}

void getPosition3D(Position3D *position, float r1, float r2, float r3) {
    position->x = (x2*x2 + r1*r1 - r2*r2) / (2 * x2);
    position->y = (y3*y3 + r1*r1 - r3*r3) / (2 * y3);
    position->z = sqrtf(r1*r1 - position->x * position->x - position->y * position->y);
}

void getLine(Line *line, Position2D positions[], int length) {
    // Algorithm: Ordinary linear least squares method

    float x_avg = 0;
    float y_avg = 0;

    for (int i = 0; i < length; i++) {
        x_avg += positions[i].x;
        y_avg += positions[i].y;
    }

    x_avg /= length;
    y_avg /= length;

    float x_diff[length];
    float y_diff[length];

    for (int i = 0; i < length; i++) {
        x_diff[i] = positions[i].x - x_avg;
        y_diff[i] = positions[i].y - y_avg;
    }

    float S_xy = 0;
    float S_x2 = 0;

    for (int i = 0; i < length; i++) {
        S_xy += x_diff[i] * y_diff[i];
        S_x2 += x_diff[i] * x_diff[i];
    }

    // Normally we would divide both S_xy and S_x2 by n-1, but when we do
    // a = S_xy / S_x2, it cancels out

    line->a = S_xy / S_x2;
    line->b = y_avg - (line->a * x_avg);
}

void getInput(float distances[], int length) {
	for (int i = 0; i < length; i++) {
		// Get input somehow, i.e. go to sleep and wait for interrupt, then
		// read input. Right now we use a dummy value.
		distances[i] = 1;
	}
}

bool willCollide2D(Line *line) {
	// TODO: Handle division by zero
	// TODO: Handle objects that are not moving
	float x = -(line->b / line->a);
	// This only checks if the object will hit the front of the system.
	// TODO: Check if the object hits the side of the object
	return (x >= 0) && (x <= x2); // Check if object hits between sensor1 and sensor2
}

void panic() {
	// Do some fancy output
	// SegmentLCD_Init(false);
	// char buf[20];
	// snprintf(buf, 20, "Panic");
	SegmentLCD_Write("Panic");
}

bool isMoving(Position2D positions[], int positionsLength) {
	return ((positions[positionsLength - 1].x == positions[positionsLength - 2].x) &&
		    (positions[positionsLength - 1].y == positions[positionsLength - 2].y));
}

int main() {
	SegmentLCD_Init(false);
	char buf[20];

	Position2D positions[1000];
	int positionsLength = 0;

	int distancesLength = 2;  // 1 distance for each sensor
	float distances[distancesLength];

	Position2D position;
	Line line;

	while (true) {
		getInput(distances, distancesLength);

		getPosition2D(&position, distances[0], distances[1]);
		positions[positionsLength] = position;
		positionsLength++;

		// This avoids working outside the positions array. However, it means
		// we sometimes get a really short buffer, and sometimes a very long
		// one. Some sort of circular buffer could be better.
		if (positionsLength > 1000) {
			positionsLength = 0;
		}

		// It doesn't make sense to make a line from one point (and we would
		// get a division by zero)

		if ((positionsLength > 1) && (isMoving(positions, positionsLength))) {
			getLine(&line, positions, positionsLength);

			if (willCollide2D(&line)) {
				panic();
			}

			// snprintf(buf, 20, "%d", (int)line.a);
			// SegmentLCD_Write(buf);
		}

	}

    // Dummy data for y = 2x + 3
	/*
	Position2D positions[3];
    positions[0].x = 1;
    positions[0].y = 5;
    positions[1].x = 2;
    positions[1].y = 7;
    positions[2].x = 3;
    positions[2].y = 9;
    */

    return 0;
}
