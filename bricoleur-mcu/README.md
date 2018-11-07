# Ultrasonic

Reads ultrasonic sensors and processes the readings.
Uses the EFM32GG MCU and LV-MaxSonar-EZ0 rangefinders.

## Setup

Current setup uses an EFM32GG980 and two EZ0 rangefinders.

### Wiring (ultrasonic)

The EZ0 sends range data in inverted UART format.

| MCU | EZ0    |
|-----|--------|
| 3V3 |  +5    |
| GND | GND    |
| PA0 | TX\*   |
| PA3 | RX\*\* |
| PA4 | RX\*\* |

\* The outputs from the sensors must be connected together with a "binary or".
This means that the signal from each sensor must go trough a diode before the signals are connected together and to the MCU. The signal must also have a pull-down resistor.

\*\* The RX pin on each sensor must be connected to its own pin on the MCU.

