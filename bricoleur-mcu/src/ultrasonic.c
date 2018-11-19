/*
 * ultrasonic.c
 *
 *  Created on: 7. nov. 2018
 *      Author: olatoft
 *
 *  Explanation and derivation of formulas used:
 *  https://docs.google.com/document/d/1bng-I3OrYp1IoY3vhtT-xtBhCldARYmhWZ4Pq9hrSdY/edit
 */

#include "ultrasonic.h"
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include "bricoleur.h"
#include "sensor.h"

// The x-coordinate offset from origo for each of the sensors in inches
const float sensorOffset2D[] = {0, 5.7};

unsigned int wallDistances[ULTRA_NUM];

float conclusion = 0;
#define newConclusionWeight 0.5
const float oldConclusionWeight = 1 - newConclusionWeight;

void setWallDistances(unsigned int wallDistances[]) {
	// Increasing this value will increase our confidence that we are seeing
	// the wall, but also require a longer setup time
	const unsigned int distancePairCount = 3;
	unsigned int distancePairs[distancePairCount][ULTRA_NUM];
	bool moving = true;
	unsigned int treshold = 0;
	unsigned int attempts = 0;

	// Run until we get <distancePairCount> number of measurements without movement
	while (moving) {
		moving = false;

		for (unsigned int i = 0; i < distancePairCount; i++) {
			getInput(distancePairs[i], ULTRA_NUM);
			attempts++;

			if (attempts > 10) {
				treshold = 1;
			}

			if (i > 0) {
				if (isMoving(distancePairs[i], distancePairs[i - 1], treshold)) {
					memset(distancePairs, 0, sizeof(distancePairs)); // Clear array
					moving = true;
					continue;
				}
			}
		}
	}

	memcpy(wallDistances, distancePairs[0], ULTRA_NUM * sizeof(float));
}


void getInput(unsigned int distances[], unsigned int length) {
	// Note: At this point, it would be possible to merge getInput and getDistance.
	// Arguments for merging: Simpler, shorter code, less function calls.
	// Argument against: The current implementation gives a nice, logical split
	// between getting input (sensor.c) and using input (main.c).

	for (unsigned int i = 0; i < length; i++) {
		// Get input somehow, i.e. go to sleep and wait for interrupt, then
		// read input.
		// distances[i] = 1;
		distances[i] = getDistance(i);
	}
}


bool isMoving(unsigned int distances[], unsigned int previousDistances[], unsigned int treshold) {
	for (unsigned int i = 0; i < ULTRA_NUM; i++) {
		// If the difference in the distance is less than the error margin, we
		// can't guarantee that the distance is actually different and that the
		// object is actually moving
		if (abs((int)distances[i] - (int)previousDistances[i]) > treshold) {
			return true;
		}
	}

	return false;
}


// return 0 if valid, 1 if not valid
int getPosition(Position *position, unsigned int distances[], unsigned int length) {
	// Approach 1
	// For every pair of distances, calculate a position entry. Then compute
	// the average position of the position entries.

	// The number of pairs of distances is equal to the number of different
	// handshakes in a group of people, known as the handshake problem.
	unsigned int positionsMaxLength = (length * (length - 1)) / 2;
	Position positions[positionsMaxLength];
	unsigned int positionsLength = 0;

	for (unsigned int i = 0; i < length - 1; i++) {
		for (unsigned int j = i + 1; j < length; j++) {
			Position positionEntry;

			float r1 = (float)distances[i];
			float r2 = (float)distances[j];

			float x1 = sensorOffset2D[i];
			float x2 = sensorOffset2D[j];

			// If the difference between the distance measured by each sensor
			// is greater than the distance between the sensors
			if (fabsf(r1 - r2) > fabsf(x1 - x2)) {
				// This is not possible if both sensors detected the object
				// Therefore, do not use this sensor pair
				continue;
			}

			positionEntry.x = (x1*x1 - x2*x2 - r1*r1 + r2*r2) / (2 * (x1 - x2));
			positionEntry.y = (0.5) *
							   sqrtf(-(((r1*r1*r1*r1 - 2*r1*r1*(r2*r2 + (x1-x2)*(x1-x2))) + (r2*r2 - (x1-x2)*(x1-x2)) * (r2*r2 - (x1-x2) * (x1-x2)))
							   / ((x1-x2) * (x1-x2))));

			positions[positionsLength++] = positionEntry;
		}
	}

	if (positionsLength == 0) {
		return 1;
	}

	position->x = 0;
	position->y = 0;

	// Find the average position
	for (unsigned int i = 0; i < positionsLength; i++) {
		position->x += positions[i].x;
		position->y += positions[i].y;
	}

	position->x /= positionsLength;
	position->y /= positionsLength;

	return 0;

	// Approach 2
	// Find the 2 sensors that are closest to the object, and use the position
	// given by that distance pair, assuming that the closest sensors give the
	// most precise results.

	// Approach 3
	// Some combination of approach 1 and 2, i.e. weighting the closest sensors
	// more, or using the n closest sensors.

	// Old approach, only supports 2 sensors, where one of them is in origo
	// position->x = (x2*x2 + r1*r1 - r2*r2) / (2 * x2);
	// position->y = sqrtf(r1*r1 - position->x * position->x);
}


// Detect if we what we see is a moving object (either fast or slow)
bool isObject(unsigned int distances[]) {
	// If what we see is not the wall, we assume it is a moving object
	return isMoving(distances, wallDistances, 1);
}


bool isMovingPositions(Position positions[], unsigned int length) {
	for (unsigned int i = 0; i < length - 1; i++) {
		if ((positions[i].x != positions[i+1].x) || (positions[i].y != positions[i+1].y)) {
			return true;
		}
	}

	return false;
}


void getLine(Line *line, Position positions[], unsigned int length) {
    // Algorithm: Ordinary linear least squares method

    float x_avg = 0;
    float y_avg = 0;

    for (unsigned int i = 0; i < length; i++) {
        x_avg += positions[i].x;
        y_avg += positions[i].y;
    }

    x_avg /= length;
    y_avg /= length;

    float x_diff[length];
    float y_diff[length];

    for (unsigned int i = 0; i < length; i++) {
        x_diff[i] = positions[i].x - x_avg;
        y_diff[i] = positions[i].y - y_avg;
    }

    float S_xy = 0;
    float S_x2 = 0;

    for (unsigned int i = 0; i < length; i++) {
        S_xy += x_diff[i] * y_diff[i];
        S_x2 += x_diff[i] * x_diff[i];
    }

    // Normally we would divide both S_xy and S_x2 by n-1, but when we do
    // a = S_xy / S_x2, it cancels out

    line->a = S_xy / S_x2;
    line->b = y_avg - (line->a * x_avg);
}


// return a value for the chance of collision between 0 and 1
float chanceOfCollision(Line *line) {
	// TODO: Handle division by zero
	// TODO: Handle objects that are not moving

	// This only checks if the object will hit the front of the system.
	// TODO: Check if the object hits the side of the object
	float x = -(line->b / line->a);

	// Center lies in the middle of the edges of the system.
	// TODO: Actknowledge that the system is wider than just the sensors. There's a box on the outside.
	float center = fabsf(sensorOffset2D[0] - sensorOffset2D[ULTRA_NUM - 1]) / 2;
	float centerToXDistance = fabsf(center - x);
	float centerToEdgeDistance = fabsf(center - sensorOffset2D[0]);
	const float edgeValue = 0.8;  // Value we assign if the object will hit the edge of the system.

	float conclusion = 1 - (centerToXDistance / centerToEdgeDistance) * (1 - edgeValue);

	// If the conclusion is well within the system, we set the chance to max
	if (conclusion > 0.9) {
		conclusion = 1;

	// If an object is detected at all, we consider there to be at least a
	// small chance of collision
	} else if (conclusion < 0.1) {
		conclusion = 0.1;
	}

	return conclusion;
}


void setConclusion(float newConclusion) {
	// Weight older conclusions exponentially less
	conclusion = conclusion * oldConclusionWeight + newConclusion * newConclusionWeight;
}


void flushBuffer(Buffer *buffer) {
	buffer->tail = 0;
	buffer->length = 0;
	buffer->wrapped = false;
}


void setupUltrasonic(Buffer *buffer) {
	setupSensor();

	// Calibrate to know where wall is
	setWallDistances(wallDistances);

	buffer->tail = 0;
	buffer->length = 0;
	buffer->maxLength = 3;
	buffer->wrapped = false;
}


float getUltrasonicLocalConclusion(Buffer *buffer, Position positions[], unsigned int previousDistances[]) {
	Position position;
	Line line;

	unsigned int distances[ULTRA_NUM];

	getInput(distances, ULTRA_NUM);

	int status = getPosition(&position, distances, ULTRA_NUM);

	if (status != 0) {
		flushBuffer(buffer);
		conclusion = 0;
		return 0;
	}

	positions[buffer->tail] = position;
	buffer->tail = (buffer->tail + 1) % buffer->maxLength;

	if (buffer->tail == 0) {
		buffer->wrapped = true;
	}

	if (buffer->wrapped) {
		buffer->length = buffer->maxLength;
	} else {
		buffer->length = buffer->tail;
	}

	// It doesn't make sense to make a line from one point (and we would
	// get a division by zero)

	if (isObject(distances) && buffer->length > 1 && isMovingPositions(positions, buffer->length)) {
		// It doesn't make sense to make a line from one point (and we would
		// get a division by zero)
		getLine(&line, positions, buffer->length);
		setConclusion(chanceOfCollision(&line));

	} else {
		// Flush buffer, only keep the last element
		flushBuffer(buffer);
		conclusion = 0;
	}

	// Pseudocode: previousDistances = distances
	memcpy(previousDistances, distances, ULTRA_NUM * sizeof(float));

	return conclusion;
}

