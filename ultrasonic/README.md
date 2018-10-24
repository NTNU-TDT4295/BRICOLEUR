# Ultrasonic

Reads ultrasonic sensors and processes the readings.
Uses the EFM32GG MCU and LV-MaxSonar-EZ0 rangefinders.

## Setup

Current setup uses an EFM Giant Gecko Starter Kit and two EZ0 rangefinders.

### Wiring (ultrasonic)

See the User Guide for the Starter Kit for the mapping of pin names to positions.
The EZ0 sends range data over UART.

| MCU | EZ0    |
|-----|--------|
| 3V3 |  +5    |
| GND | GND    |
| PD1 | TX\*   |
| PD5 | RX\*\* |
| PD6 | RX\*\* |

\* The outputs from the sensors must be connected together with a "binary or".
This means that the signal from each sensor must go trough a diode before the signals are connected together and to the MCU. The signal must also have a pull-down resistor.

\*\* The RX pin on each sensor must be connected to its own pin on the MCU.

### Wiring (UART)

The Gecko outputs debug data over UART. PD0 is the TX pin, RX is used for the sensors. See the code for baud rate.
