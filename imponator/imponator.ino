#include <Servo.h>

#define SERVO_PIN 9
#define SERIAL_RATE 115200

Servo needle;

byte pos = 0;

void setup() {
  needle.attach(SERVO_PIN);
  needle.write(0);
  Serial.begin(SERIAL_RATE);
}

void loop() {
  if (Serial.available() > 0) {
    // This assumes that servo 0 position is maximum "output"
    pos = map(Serial.read(), 0, 255, 180, 0);
    needle.write(pos);
  }
}

