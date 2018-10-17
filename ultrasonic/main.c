// Explanation and derivation of formulas used:
// https://docs.google.com/document/d/1bng-I3OrYp1IoY3vhtT-xtBhCldARYmhWZ4Pq9hrSdY/edit

#include <stdio.h>
#include <math.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include "main.h"

unsigned int totalStringLength = 0;
#define totalStringMaxLength 200
char totalString[totalStringMaxLength];

#define numberOfSensors 2

// The x-coordinate offset from origo for each of the sensors
const float sensorOffset2D[] = {0, 14.5};

#define numberOfData 551
unsigned int distancePairIndex = 0;
float distancePair[numberOfData][numberOfSensors];

// return 0 if valid, 1 if not valid
int getPosition2D(Position2D *position, float distances[], unsigned int length) {
	// Approach 1
	// For every pair of distances, calculate a position entry. Then compute
	// the average position of the position entries.

	// The number of pairs of distances is equal to the number of different
	// handshakes in a group of people, known as the handshake problem.
	unsigned int positionsMaxLength = (length * (length - 1)) / 2;
	Position2D positions[positionsMaxLength];
	unsigned int positionsLength = 0;

	for (unsigned int i = 0; i < length - 1; i++) {
		for (unsigned int j = i + 1; j < length; j++) {
			Position2D positionEntry;

			float r1 = distances[i];
			float r2 = distances[j];

			float x1 = sensorOffset2D[i];
			float x2 = sensorOffset2D[j];

			char buf2[50];
			// snprintf(buf2, 50, "r1: %.4f ; r2: %.4f ", r1, r2);
			snprintf(buf2, 50, "r1: %.2f ; r2: %.2f ; ", r1, r2);
			buildString(buf2, 50);

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

			char buf1[50];
			snprintf(buf1, 50, "x: %.2f ; y: %.2f ; ", positionEntry.x, positionEntry.y);
			buildString(buf1, 50);
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

//	char buf[50];
//	snprintf(buf, 50, "x: %.2f y: %.2f l: %u ; ", position->x, position->y, positionsLength);
//	buildString(buf, 50);

//	char buf[30];
//	snprintf(buf, 30, "x: %f y: %f\n; ", position->x, position->y);
//	sendString(USART1, buf);

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

/*
void getPosition3D(Position3D *position, float r1, float r2, float r3) {
    position->x = (x2*x2 + r1*r1 - r2*r2) / (2 * x2);
    position->y = (y3*y3 + r1*r1 - r3*r3) / (2 * y3);
    position->z = sqrtf(r1*r1 - position->x * position->x - position->y * position->y);
}
*/

void getLine(Line *line, Position2D positions[], unsigned int length) {
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

    char buf[60];
    snprintf(buf, 50, "x_avg = %.2f y_avg = %.2f y = %.2fx + %.2f ; ", x_avg, y_avg, line->a, line->b);
    buildString(buf, 50);

    //char buf[30];
    //snprintf(buf, 30, "y = %fx + %f\n; ", line->a, line->b);
    //sendString(USART1, buf);

    // End line of sensor readings
    // sendString(USART1, "\n");
}

void getInput(float distances[], unsigned int length) {
	// Note: At this point, it would be possible to merge getInput and getDistance.
	// Arguments for merging: Simpler, shorter code, less function calls.
	// Argument against: The current implementation gives a nice, logical split
	// between getting input (sensor.c) and using input (main.c).

	for (unsigned int i = 0; i < length; i++) {
		// Get input somehow, i.e. go to sleep and wait for interrupt, then
		// read input.
		// distances[i] = 1;
		// distances[i] = getDistance(i);
		distances[i] = distancePair[distancePairIndex][i];

		// Send reading on UART

		/*
		char buf[15];
		snprintf(buf, 15, "US %d: %3d cm; ", i, (int)distances[i]);
		sendString(USART1, buf);
		*/

	}

	distancePairIndex++;

	// End line of sensor readings
	// sendString(USART1, "\n");

	// Write integer distances from sensor 0 and 1 to LCD
	// char dist_str[8];
	// snprintf(dist_str, 8, "%3d %3d", (int)distances[0], (int)distances[1]);
	// SegmentLCD_Write(dist_str);
}

bool willCollide2D(Line *line) {
	// TODO: Handle division by zero
	// TODO: Handle objects that are not moving
	float x = -(line->b / line->a);
	// This only checks if the object will hit the front of the system.
	// TODO: Check if the object hits the side of the object
	bool willCollide = (x >= sensorOffset2D[0] - 10) && (x <= sensorOffset2D[numberOfSensors - 1] + 10);

	char buf[20];
	snprintf(buf, 20, "Will collide: %d", willCollide);
	buildString(buf, 20);

	return willCollide; // Check if object hits between sensor1 and sensor2
}

void panic() {
	// Do some fancy output
	// SegmentLCD_Write("Panic");
}

bool isMoving(Position2D positions[], unsigned int length) {
	return ((positions[length - 1].x != positions[length - 2].x) ||
			(positions[length - 1].y == positions[length - 2].y));
}

void buildString(char *string, unsigned int length) {
	int i;

	for (i = 0; string[i] != '\0'; i++) {
		totalString[totalStringLength + i] = string[i];
	}

	totalStringLength += i;
}

void sendString(char *string) {
	/* Send a string on the given USART.
	 * USART_Tx calls will stall if TX buffer is full,
	 * which means that this function blocks until sending is completed.
	 */

	printf("%s", string);
}

void setupData() {
	FILE *file;
	file = fopen("data.txt", "r");
	char line[255];

	if (file == NULL) {
		printf("Error when opening file");
		exit(1);
	}


	for (unsigned int i = 0; i < numberOfData; i++) {
		for (unsigned int j = 0; j < numberOfSensors; j++) {
			int inputLength = fscanf(file, "%s", line);
			
			if (inputLength > totalStringMaxLength) {
				printf("Error: Input too long");
				exit(1);
			}

			distancePair[i][j] = atof(line);
		}
	}

	// for (unsigned int i = 0; i < numberOfData; i++) {
	// 	printf("%f %f\n", distancePair[i][0], distancePair[i][1]);
	// }
}

int main() {
	setupData();

	Buffer buffer;
	buffer.tail = 0;
	buffer.length = 0;
	buffer.maxLength = 2;
	buffer.wrapped = false;

	Position2D positions[buffer.maxLength];

	float distances[numberOfSensors];

	Position2D position;
	Line line;

	// while (true) {
	for (unsigned int i = 0; i < numberOfData; i++) {
		getInput(distances, numberOfSensors);

		int status = getPosition2D(&position, distances, numberOfSensors);

		if (status != 0) {
			buildString("\n", 1);
			totalString[totalStringLength] = '\0';
			sendString(totalString);
			totalStringLength = 0;
			continue;
		}

		positions[buffer.tail] = position;
		buffer.tail = (buffer.tail + 1) % buffer.maxLength;

		if (buffer.tail == 0) {
			buffer.wrapped = true;
		}

		if (buffer.wrapped) {
			buffer.length = buffer.maxLength;
		} else {
			buffer.length = buffer.tail;
		}

		// It doesn't make sense to make a line from one point (and we would
		// get a division by zero)

		if ((buffer.length > 1) && (isMoving(positions, buffer.length))) {
			getLine(&line, positions, buffer.length);

			if (willCollide2D(&line)) {
				// panic();
			} else {
				// SegmentLCD_Write("Relax");
			}
		}

		buildString("\n", 1);
		totalString[totalStringLength] = '\0';
		sendString(totalString);
		totalStringLength = 0;
	}

	return 0;
}
