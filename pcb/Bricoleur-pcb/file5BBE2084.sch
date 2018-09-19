EESchema Schematic File Version 4
LIBS:Bricoleur-pcb-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 2
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector_Generic:Conn_02x10_Odd_Even J?
U 1 1 5BBE2CE4
P 9050 2100
F 0 "J?" H 9100 2717 50  0000 C CNN
F 1 "Conn_02x10_Odd_Even" H 9100 2626 50  0000 C CNN
F 2 "" H 9050 2100 50  0001 C CNN
F 3 "~" H 9050 2100 50  0001 C CNN
	1    9050 2100
	1    0    0    -1  
$EndComp
Text GLabel 10900 1500 0    50   Input ~ 0
VMCU
Text GLabel 8650 2950 3    50   Input ~ 0
GND
Text GLabel 8850 1700 0    50   Input ~ 0
DH_VTARGET
Text GLabel 8850 1800 0    50   Input ~ 0
DH_#TRST
Text GLabel 8850 1900 0    50   Input ~ 0
DH_TDI
Text GLabel 8850 2000 0    50   Input ~ 0
DH_TMS_SWDIO
Text GLabel 8850 2100 0    50   Input ~ 0
DH_TCK_SWCLK
Text GLabel 8850 2200 0    50   Input ~ 0
DH_RTCK
Text GLabel 8850 2300 0    50   Input ~ 0
DH_TDO_SWO
Text GLabel 8850 2400 0    50   Input ~ 0
DH_#RESET
Wire Wire Line
	8850 2500 8650 2500
Wire Wire Line
	8650 2500 8650 2600
$Comp
L Device:R R?
U 1 1 5BBE44F9
P 8650 2750
F 0 "R?" H 8720 2796 50  0000 L CNN
F 1 "100K" H 8720 2705 50  0000 L CNN
F 2 "" V 8580 2750 50  0001 C CNN
F 3 "~" H 8650 2750 50  0001 C CNN
	1    8650 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	8650 2900 8650 2950
$Comp
L Device:R R?
U 1 1 5BBE4599
P 8850 3000
F 0 "R?" H 8920 3046 50  0000 L CNN
F 1 "100K" H 8920 2955 50  0000 L CNN
F 2 "" V 8780 3000 50  0001 C CNN
F 3 "~" H 8850 3000 50  0001 C CNN
	1    8850 3000
	1    0    0    -1  
$EndComp
Text GLabel 8850 3250 3    50   Input ~ 0
GND
Wire Wire Line
	8850 2850 8850 2600
Wire Wire Line
	8850 3150 8850 3250
Wire Wire Line
	9350 1800 9500 1800
Wire Wire Line
	9500 1800 9500 1900
Wire Wire Line
	9350 1900 9500 1900
Connection ~ 9500 1900
Wire Wire Line
	9500 1900 9500 2000
Wire Wire Line
	9350 2000 9500 2000
Connection ~ 9500 2000
Wire Wire Line
	9500 2000 9500 2100
Wire Wire Line
	9350 2100 9500 2100
Connection ~ 9500 2100
Wire Wire Line
	9500 2100 9500 2200
Wire Wire Line
	9350 2200 9500 2200
Connection ~ 9500 2200
Wire Wire Line
	9500 2200 9500 2300
Wire Wire Line
	9350 2300 9500 2300
Connection ~ 9500 2300
Wire Wire Line
	9500 2300 9500 2400
Wire Wire Line
	9350 2400 9500 2400
Connection ~ 9500 2400
Wire Wire Line
	9500 2400 9500 2600
Wire Wire Line
	9350 2600 9500 2600
Connection ~ 9500 2600
Wire Wire Line
	9500 2600 9500 2900
Text GLabel 9500 2900 3    50   Input ~ 0
GND
Wire Wire Line
	9350 2500 9950 2500
Text GLabel 9950 1650 1    50   Input ~ 0
PYNQ_3V3
$Comp
L Device:R R?
U 1 1 5BBF7D34
P 9950 2000
F 0 "R?" H 10020 2046 50  0000 L CNN
F 1 "R" H 10020 1955 50  0000 L CNN
F 2 "" V 9880 2000 50  0001 C CNN
F 3 "~" H 9950 2000 50  0001 C CNN
	1    9950 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	9950 1650 9950 1850
Wire Wire Line
	9950 2150 9950 2500
Text GLabel 9950 2500 3    50   Input ~ 0
DEBUG_EXT_CABLE_ATTACH
Text Notes 10400 2150 1    50   ~ 0
UNFINISHED\n
$EndSCHEMATC
