// Explanation and derivation of formulas used:
// https://docs.google.com/document/d/1bng-I3OrYp1IoY3vhtT-xtBhCldARYmhWZ4Pq9hrSdY/edit

#include <stdio.h>
#include <math.h>
#include "em_device.h"
#include "em_chip.h"
#include "em_usart.h"
#include "em_cmu.h"
#include "em_gpio.h"
#include "segmentlcd.h"
#include "main.h"
#include "sensor.h"

const unsigned int numberOfSensors = 2;

// The x-coordinate offset from origo for each of the sensors
const float sensorOffset2D[] = {0, -7.5};

void getPosition2D(Position2D *position, float distances[], unsigned int length) {
	// Approach 1
	// For every pair of distances, calculate a position entry. Then compute
	// the average position of the position entries.

	// The number of pairs of distances is equal to the number of different
	// handshakes in a group of people, known as the handshake problem.
	unsigned int positionsLength = (length * (length - 1)) / 2;
	Position2D positions[positionsLength];
	unsigned int positionsIndex = 0;

	for (unsigned int i = 0; i < length - 1; i++) {
		for (unsigned int j = i + 1; j < length; j++) {
			Position2D positionEntry;

			float r1 = distances[i];
			float r2 = distances[j];

			float x1 = sensorOffset2D[i];
			float x2 = sensorOffset2D[j];

			positionEntry.x = (x1*x1 - x2*x2 - r1*r1 + r2*r2) / (2 * (x1 - x2));
			positionEntry.y = (0.5) *
							   sqrtf(-(((r1*r1*r1*r1 - 2*r1*r1*(r2*r2 + (x1-x2)*(x1-x2))) + (r2*r2 - (x1-x2)*(x1-x2)) * (r2*r2 - (x1-x2) * (x1-x2)))
							   / ((x1-x2) * (x1-x2))));

			positions[positionsIndex++] = positionEntry;
		}
	}

	// Find the average position
	for (unsigned int i = 0; i < positionsLength; i++) {
		position->x += positions[i].x;
		position->y += positions[i].y;
	}

	position->x /= positionsLength;
	position->y /= positionsLength;

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

    // char buf[20];
    // snprintf(buf, 20, "%d", (int)line->b);
    // SegmentLCD_Write(buf);
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
		distances[i] = getDistance(i);

		// Send reading on UART
		char buf[15];
		snprintf(buf, 15, "US %d: %3d cm; ", i, (int)distances[i]);
		sendString(USART1, buf);
	}
	// End line of sensor readings
	sendString(USART1, "\n");

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
	return (x >= sensorOffset2D[0]) && (x <= sensorOffset2D[numberOfSensors - 1]); // Check if object hits between sensor1 and sensor2
}

void panic() {
	// Do some fancy output
	SegmentLCD_Write("Panic");
}

bool isMoving(Position2D positions[], unsigned int length) {
	return ((positions[length - 1].x != positions[length - 2].x) ||
			(positions[length - 1].y == positions[length - 2].y));
}

void sendString(USART_TypeDef *usart, char *string) {
	/* Send a string on the given USART.
	 * USART_Tx calls will stall if TX buffer is full,
	 * which means that this function blocks until sending is completed.
	 */
	for (int i = 0; string[i] != '\0'; i++) {
		USART_Tx(usart, string[i]);
	}
}

void setupUsart(void) {
	CMU_ClockEnable(cmuClock_HFPER, true);
	CMU_ClockEnable(cmuClock_USART1, true);
	CMU_ClockEnable(cmuClock_GPIO, true);

	USART_InitAsync_TypeDef initAsync = USART_INITASYNC_DEFAULT;
	initAsync.baudrate = 9600;
	initAsync.enable = usartEnableTx;
	USART_InitAsync(USART1, &initAsync);

	/* The location used in these two variables should be the same */
	int USART_LOCATION_MASK = USART_ROUTE_LOCATION_LOC1;
	int USART_LOCATION = 1;

	USART1->ROUTE = USART_ROUTE_TXPEN | USART_LOCATION_MASK;

	/* To avoid false start, configure TX pin as initial high */
	GPIO_PinModeSet((GPIO_Port_TypeDef)AF_USART1_TX_PORT(USART_LOCATION),
			AF_USART1_TX_PIN(USART_LOCATION), gpioModePushPull, 1);
}

int main() {
	CHIP_Init();
	SegmentLCD_Init(false);
	setupSensor();
	setupUsart();

	Buffer buffer;
	buffer.tail = 0;
	buffer.length = 0;
	buffer.maxLength = 100;
	buffer.wrapped = false;

	Position2D positions[buffer.maxLength];

	float distances[numberOfSensors];

	Position2D position;
	Line line;

	while (true) {
		getInput(distances, numberOfSensors);

		getPosition2D(&position, distances, numberOfSensors);

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
				panic();
			}
		}
	}

	return 0;
}