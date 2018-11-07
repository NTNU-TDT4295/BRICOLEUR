#include "em_device.h"
#include "em_chip.h"
#include "main.h"
#include "ultrasonic.h"


int main() {
	CHIP_Init();

	Buffer buffer;
	setupUltrasonic(&buffer);

	Position positions[buffer.maxLength];

	unsigned int previousDistances[numberOfSensors];

	while (true) {
		willCollideUltrasonic(&buffer, positions, previousDistances);
	}

	return 0;
}
