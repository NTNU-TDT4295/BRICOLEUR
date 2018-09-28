EESchema Schematic File Version 4
LIBS:Bricoleur-pcb-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 18
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
L Connector_Generic:Conn_02x10_Odd_Even J2
U 1 1 5BBE2CE4
P 9050 2100
F 0 "J2" H 9100 2717 50  0000 C CNN
F 1 "Conn_02x10_Odd_Even" H 9100 2626 50  0000 C CNN
F 2 "Connector_IDC:IDC-Header_2x10_P2.54mm_Vertical" H 9050 2100 50  0001 C CNN
F 3 "~" H 9050 2100 50  0001 C CNN
	1    9050 2100
	1    0    0    -1  
$EndComp
Text GLabel 5150 2550 1    50   Input ~ 0
VMCU
Text GLabel 8650 2950 3    50   Input ~ 0
GND
Text GLabel 7850 2000 0    50   Input ~ 0
DH_TMS_SWDIO
Text GLabel 7850 2100 0    50   Input ~ 0
DH_TCK_SWCLK
Text GLabel 7850 2300 0    50   Input ~ 0
DH_TDO_SWO
Text GLabel 7850 2400 0    50   Input ~ 0
DH_#RESET
Wire Wire Line
	8850 2500 8650 2500
Wire Wire Line
	8650 2500 8650 2600
$Comp
L Device:R R14
U 1 1 5BBE44F9
P 8650 2750
F 0 "R14" H 8720 2796 50  0000 L CNN
F 1 "100K" H 8720 2705 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 8580 2750 50  0001 C CNN
F 3 "~" H 8650 2750 50  0001 C CNN
	1    8650 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	8650 2900 8650 2950
$Comp
L Device:R R15
U 1 1 5BBE4599
P 8850 3000
F 0 "R15" H 8920 3046 50  0000 L CNN
F 1 "100K" H 8920 2955 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 8780 3000 50  0001 C CNN
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
Text GLabel 9950 1650 1    50   Input ~ 0
PYNQ_3V3
$Comp
L Device:R R16
U 1 1 5BBF7D34
P 9950 2000
F 0 "R16" H 10020 2046 50  0000 L CNN
F 1 "10K" H 10020 1955 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 9880 2000 50  0001 C CNN
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
$Comp
L Device:LED D1
U 1 1 5BA42EDE
P 5350 1550
F 0 "D1" H 5341 1766 50  0000 C CNN
F 1 "LED" H 5341 1675 50  0000 C CNN
F 2 "LED_SMD:LED_0201_0603Metric" H 5350 1550 50  0001 C CNN
F 3 "~" H 5350 1550 50  0001 C CNN
	1    5350 1550
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D2
U 1 1 5BA42F59
P 5350 1800
F 0 "D2" H 5341 2016 50  0000 C CNN
F 1 "LED" H 5341 1925 50  0000 C CNN
F 2 "LED_SMD:LED_0201_0603Metric" H 5350 1800 50  0001 C CNN
F 3 "~" H 5350 1800 50  0001 C CNN
	1    5350 1800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D3
U 1 1 5BA42F93
P 5350 2100
F 0 "D3" H 5341 2316 50  0000 C CNN
F 1 "LED" H 5341 2225 50  0000 C CNN
F 2 "LED_SMD:LED_0201_0603Metric" H 5350 2100 50  0001 C CNN
F 3 "~" H 5350 2100 50  0001 C CNN
	1    5350 2100
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 5BA42FE5
P 5900 1550
F 0 "R8" V 5693 1550 50  0000 C CNN
F 1 "3K" V 5784 1550 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 5830 1550 50  0001 C CNN
F 3 "~" H 5900 1550 50  0001 C CNN
	1    5900 1550
	0    1    1    0   
$EndComp
$Comp
L Device:R R9
U 1 1 5BA4308A
P 5900 1800
F 0 "R9" V 5693 1800 50  0000 C CNN
F 1 "3K" V 5784 1800 50  0000 C CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" V 5830 1800 50  0001 C CNN
F 3 "~" H 5900 1800 50  0001 C CNN
	1    5900 1800
	0    1    1    0   
$EndComp
$Comp
L Device:R R10
U 1 1 5BA430DB
P 5900 2100
F 0 "R10" V 5693 2100 50  0000 C CNN
F 1 "3K" V 5784 2100 50  0000 C CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" V 5830 2100 50  0001 C CNN
F 3 "~" H 5900 2100 50  0001 C CNN
	1    5900 2100
	0    1    1    0   
$EndComp
Wire Wire Line
	4700 1550 5200 1550
Wire Wire Line
	5500 1550 5750 1550
Wire Wire Line
	5750 1800 5500 1800
Wire Wire Line
	4700 1800 4700 1750
Wire Wire Line
	5200 1800 4700 1800
Wire Wire Line
	5750 2100 5500 2100
Wire Wire Line
	4700 2100 4700 2050
Wire Wire Line
	5200 2100 4700 2100
Wire Wire Line
	6050 1550 6200 1550
Wire Wire Line
	6050 1800 6200 1800
Wire Wire Line
	6050 2100 6200 2100
Text GLabel 6200 1550 2    50   Input ~ 0
DBG_LED_1
Text GLabel 6200 1800 2    50   Input ~ 0
DBG_LED_2
Text GLabel 6200 2100 2    50   Input ~ 0
DBG_LED_3
Text GLabel 4700 1550 0    50   Input ~ 0
GND
Text GLabel 4700 1800 0    50   Input ~ 0
GND
Text GLabel 4700 2100 0    50   Input ~ 0
GND
$Comp
L Switch:SW_Push SW3
U 1 1 5BA4CD03
P 6300 3100
F 0 "SW3" H 6300 3385 50  0000 C CNN
F 1 "SW_Push" H 6300 3294 50  0000 C CNN
F 2 "Bricoleur-custom:SWITCH_WURTH_4301182043816" H 6300 3300 50  0001 C CNN
F 3 "" H 6300 3300 50  0001 C CNN
	1    6300 3100
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW4
U 1 1 5BA4CD8A
P 6300 3500
F 0 "SW4" H 6300 3785 50  0000 C CNN
F 1 "SW_Push" H 6300 3694 50  0000 C CNN
F 2 "Bricoleur-custom:SWITCH_WURTH_4301182043816" H 6300 3700 50  0001 C CNN
F 3 "" H 6300 3700 50  0001 C CNN
	1    6300 3500
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW5
U 1 1 5BA4CDDC
P 6300 3850
F 0 "SW5" H 6300 4135 50  0000 C CNN
F 1 "SW_Push" H 6300 4044 50  0000 C CNN
F 2 "Bricoleur-custom:SWITCH_WURTH_4301182043816" H 6300 4050 50  0001 C CNN
F 3 "" H 6300 4050 50  0001 C CNN
	1    6300 3850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 5BA4D4A6
P 4800 2850
F 0 "R5" H 4730 2804 50  0000 R CNN
F 1 "1M" H 4730 2895 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 4730 2850 50  0001 C CNN
F 3 "~" H 4800 2850 50  0001 C CNN
	1    4800 2850
	-1   0    0    1   
$EndComp
$Comp
L Device:R R6
U 1 1 5BA4FEFA
P 5150 2850
F 0 "R6" H 5080 2804 50  0000 R CNN
F 1 "1M" H 5080 2895 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 5080 2850 50  0001 C CNN
F 3 "~" H 5150 2850 50  0001 C CNN
	1    5150 2850
	-1   0    0    1   
$EndComp
$Comp
L Device:R R7
U 1 1 5BA4FF34
P 5500 2850
F 0 "R7" H 5430 2804 50  0000 R CNN
F 1 "1M" H 5430 2895 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 5430 2850 50  0001 C CNN
F 3 "~" H 5500 2850 50  0001 C CNN
	1    5500 2850
	-1   0    0    1   
$EndComp
$Comp
L Device:C C14
U 1 1 5BA50647
P 4800 4300
F 0 "C14" H 4915 4346 50  0000 L CNN
F 1 "1N" H 4915 4255 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 4838 4150 50  0001 C CNN
F 3 "~" H 4800 4300 50  0001 C CNN
	1    4800 4300
	1    0    0    -1  
$EndComp
$Comp
L Device:C C15
U 1 1 5BA506FF
P 5150 4300
F 0 "C15" H 5265 4346 50  0000 L CNN
F 1 "1N" H 5265 4255 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 5188 4150 50  0001 C CNN
F 3 "~" H 5150 4300 50  0001 C CNN
	1    5150 4300
	1    0    0    -1  
$EndComp
$Comp
L Device:C C16
U 1 1 5BA5073F
P 5500 4300
F 0 "C16" H 5615 4346 50  0000 L CNN
F 1 "1N" H 5615 4255 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 5538 4150 50  0001 C CNN
F 3 "~" H 5500 4300 50  0001 C CNN
	1    5500 4300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 5BA50DD2
P 7100 3100
F 0 "R11" V 6893 3100 50  0000 C CNN
F 1 "100R" V 6984 3100 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 7030 3100 50  0001 C CNN
F 3 "~" H 7100 3100 50  0001 C CNN
	1    7100 3100
	0    1    1    0   
$EndComp
$Comp
L Device:R R12
U 1 1 5BA51496
P 7100 3500
F 0 "R12" V 6893 3500 50  0000 C CNN
F 1 "100R" V 6984 3500 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 7030 3500 50  0001 C CNN
F 3 "~" H 7100 3500 50  0001 C CNN
	1    7100 3500
	0    1    1    0   
$EndComp
$Comp
L Device:R R13
U 1 1 5BA514E0
P 7100 3850
F 0 "R13" V 6893 3850 50  0000 C CNN
F 1 "100R" V 6984 3850 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 7030 3850 50  0001 C CNN
F 3 "~" H 7100 3850 50  0001 C CNN
	1    7100 3850
	0    1    1    0   
$EndComp
Text GLabel 7550 3500 2    50   Input ~ 0
GND
Wire Wire Line
	7550 3100 7250 3100
Wire Wire Line
	6950 3100 6500 3100
Wire Wire Line
	7550 3500 7250 3500
Wire Wire Line
	6950 3500 6500 3500
Wire Wire Line
	7550 3850 7250 3850
Wire Wire Line
	6950 3850 6500 3850
Text GLabel 3850 3100 0    50   Input ~ 0
DBG_PB_1
Text GLabel 3850 3500 0    50   Input ~ 0
DBG_PB_2
Text GLabel 3850 3850 0    50   Input ~ 0
DBG_PB_3
Wire Wire Line
	5150 2550 5150 2700
Wire Wire Line
	5150 3000 5150 3500
Connection ~ 5150 3500
Wire Wire Line
	5150 3500 5150 4150
Wire Wire Line
	5500 3000 5500 3850
Connection ~ 5500 3850
Wire Wire Line
	5500 3850 5500 4150
Wire Wire Line
	7550 3100 7550 3500
Connection ~ 7550 3500
Wire Wire Line
	7550 3500 7550 3850
Text GLabel 5150 4550 3    50   Input ~ 0
GND
Wire Wire Line
	5150 4550 5150 4450
Wire Wire Line
	7100 2200 8850 2200
$Comp
L Device:R R17
U 1 1 5BA97D26
P 7100 2350
F 0 "R17" H 7170 2396 50  0000 L CNN
F 1 "100K" H 7170 2305 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 7030 2350 50  0001 C CNN
F 3 "~" H 7100 2350 50  0001 C CNN
	1    7100 2350
	1    0    0    -1  
$EndComp
Text GLabel 7100 2500 3    50   Input ~ 0
GND
Text GLabel 7900 1600 1    50   Input ~ 0
VMCU
NoConn ~ 9350 1700
Wire Wire Line
	9350 2500 9950 2500
Wire Wire Line
	3850 3100 4800 3100
Wire Wire Line
	4800 3100 4800 4150
Wire Wire Line
	4800 3000 4800 3100
Connection ~ 4800 3100
Wire Wire Line
	4800 3100 6100 3100
Wire Wire Line
	6100 3500 5150 3500
Wire Wire Line
	6100 3850 5500 3850
Connection ~ 5150 2700
Wire Wire Line
	5500 2700 5150 2700
Wire Wire Line
	5150 2700 4800 2700
Connection ~ 5150 4450
Wire Wire Line
	5500 4450 5150 4450
Wire Wire Line
	5150 4450 4800 4450
Wire Wire Line
	5150 3500 3850 3500
Wire Wire Line
	5500 3850 3850 3850
NoConn ~ 8850 1800
NoConn ~ 8850 1900
$Comp
L Diode:BAT54S D5
U 1 1 5BB434F5
P 8600 4750
F 0 "D5" V 8646 4837 50  0000 L CNN
F 1 "BAT54S" V 8555 4837 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 8675 4875 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 8480 4750 50  0001 C CNN
	1    8600 4750
	0    1    -1   0   
$EndComp
Wire Wire Line
	7850 2400 8850 2400
Wire Wire Line
	7850 2300 8850 2300
Wire Wire Line
	7850 2100 8850 2100
Wire Wire Line
	7850 2000 8850 2000
Text GLabel 8400 4750 0    50   Input ~ 0
DH_TMS_SWDIO
Text GLabel 9700 4750 0    50   Input ~ 0
DH_TCK_SWCLK
$Comp
L Diode:BAT54S D6
U 1 1 5BB4DE32
P 9900 4750
F 0 "D6" V 9946 4837 50  0000 L CNN
F 1 "BAT54S" V 9855 4837 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 9975 4875 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 9780 4750 50  0001 C CNN
	1    9900 4750
	0    1    -1   0   
$EndComp
Text GLabel 10850 4750 0    50   Input ~ 0
DH_TDO_SWO
$Comp
L Diode:BAT54S D7
U 1 1 5BB4DEDC
P 11050 4750
F 0 "D7" V 11096 4837 50  0000 L CNN
F 1 "BAT54S" V 11005 4837 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 11125 4875 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 10930 4750 50  0001 C CNN
	1    11050 4750
	0    1    -1   0   
$EndComp
Wire Wire Line
	11050 5050 11050 5200
Wire Wire Line
	11050 5200 9900 5200
Wire Wire Line
	8600 5200 8600 5050
Wire Wire Line
	9900 5050 9900 5200
Connection ~ 9900 5200
Wire Wire Line
	9900 5200 8600 5200
Wire Wire Line
	11050 4450 11050 4350
Wire Wire Line
	11050 4350 9900 4350
Wire Wire Line
	8600 4350 8600 4450
Wire Wire Line
	9900 4450 9900 4350
Connection ~ 9900 4350
Wire Wire Line
	9900 4350 8600 4350
Text GLabel 9900 5200 3    50   Input ~ 0
GND
Text GLabel 9900 4350 1    50   Input ~ 0
VMCU
Text GLabel 7150 4700 0    50   Input ~ 0
DH_#RESET
$Comp
L Diode:BAT54S D4
U 1 1 5BB621C0
P 7350 4700
F 0 "D4" V 7396 4787 50  0000 L CNN
F 1 "BAT54S" V 7305 4787 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 7425 4825 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 7230 4700 50  0001 C CNN
	1    7350 4700
	0    1    -1   0   
$EndComp
Wire Wire Line
	8600 4350 7350 4350
Wire Wire Line
	7350 4350 7350 4400
Connection ~ 8600 4350
Wire Wire Line
	8600 5200 7350 5200
Wire Wire Line
	7350 5200 7350 5000
Connection ~ 8600 5200
Wire Wire Line
	7900 1700 7900 1600
Wire Wire Line
	7900 1700 8850 1700
$EndSCHEMATC
