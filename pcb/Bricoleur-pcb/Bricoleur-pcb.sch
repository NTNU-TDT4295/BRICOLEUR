EESchema Schematic File Version 4
LIBS:Bricoleur-pcb-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 3
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
L Bricoleur-pcb-cache:Arducam-OV5642 U5
U 1 1 5B998412
P 4200 5200
F 0 "U5" H 4000 5500 50  0000 L CNN
F 1 "Arducam-OV5642" H 4240 5528 50  0000 L CNN
F 2 "Connector_IDC:IDC-Header_2x10_P2.54mm_Vertical" H 4200 5050 50  0001 C CNN
F 3 "" H 4200 5050 50  0001 C CNN
	1    4200 5200
	1    0    0    -1  
$EndComp
$Comp
L Bricoleur-pcb-cache:Arducam-OV5642 U6
U 1 1 5B99848C
P 4200 7450
F 0 "U6" H 4149 7778 50  0000 L CNN
F 1 "Arducam-OV5642" H 4240 7778 50  0000 L CNN
F 2 "Connector_IDC:IDC-Header_2x10_P2.54mm_Vertical" H 4200 7300 50  0001 C CNN
F 3 "" H 4200 7300 50  0001 C CNN
	1    4200 7450
	-1   0    0    1   
$EndComp
Text Label 650  3400 1    50   ~ 0
PYNQ_3V3
Text Label 950  3600 2    50   ~ 0
GND
Text Label 3250 5700 3    50   ~ 0
PYNQ_3V3
Text Label 3350 5700 3    50   ~ 0
GND
Text Label 5150 6950 1    50   ~ 0
PYNQ_3V3
Text Label 5050 6950 1    50   ~ 0
GND
$Comp
L symbols:EFM32GG980 U7
U 1 1 5B9A6C8F
P 6150 1200
F 0 "U7" H 7250 1587 60  0000 C CNN
F 1 "EFM32GG980" H 7250 1481 60  0000 C CNN
F 2 "EFM32GG980:EFM32GG980" H 7250 1440 60  0001 C CNN
F 3 "" H 6150 1200 60  0000 C CNN
	1    6150 1200
	1    0    0    -1  
$EndComp
$Comp
L Bricoleur-pcb-cache:Bricoleur-pcb-cache_Ultrasonic-LV-EZ0 U1
U 1 1 5B9AE131
P 4150 1450
F 0 "U1" V 4665 1419 50  0000 C CNN
F 1 "Ultrasonic-LV-EZ0" V 4574 1419 50  0000 C CNN
F 2 "Connector_IDC:IDC-Header_2x03_P2.54mm_Vertical" H 4150 1500 50  0001 C CNN
F 3 "" H 4150 1500 50  0001 C CNN
	1    4150 1450
	0    -1   -1   0   
$EndComp
$Comp
L Bricoleur-pcb-cache:Bricoleur-pcb-cache_Ultrasonic-LV-EZ0 U3
U 1 1 5B9AE194
P 5450 2300
F 0 "U3" V 5950 2250 50  0000 L CNN
F 1 "Ultrasonic-LV-EZ0" V 5850 1950 50  0000 L CNN
F 2 "Connector_IDC:IDC-Header_2x03_P2.54mm_Vertical" H 5450 2350 50  0001 C CNN
F 3 "" H 5450 2350 50  0001 C CNN
	1    5450 2300
	0    1    -1   0   
$EndComp
$Comp
L Bricoleur-pcb-cache:Bricoleur-pcb-cache_Ultrasonic-LV-EZ0 U4
U 1 1 5B9AE2C4
P 4100 2600
F 0 "U4" V 4600 2550 50  0000 L CNN
F 1 "Ultrasonic-LV-EZ0" V 4500 2250 50  0000 L CNN
F 2 "Connector_IDC:IDC-Header_2x03_P2.54mm_Vertical" H 4100 2650 50  0001 C CNN
F 3 "" H 4100 2650 50  0001 C CNN
	1    4100 2600
	0    -1   -1   0   
$EndComp
Text Label 2350 4800 0    50   ~ 0
CAM_CLK
Text Label 3950 5700 3    50   ~ 0
CAM_CLK
Text Label 4450 6950 1    50   ~ 0
CAM_CLK
$Comp
L Connector:USB_B_Micro J1
U 1 1 5B9CF6E3
P 9900 1150
F 0 "J1" H 9671 1048 50  0000 R CNN
F 1 "USB_B_Micro" H 9671 1139 50  0000 R CNN
F 2 "Connector_USB:USB_B_OST_USB-B1HSxx_Horizontal" H 10050 1100 50  0001 C CNN
F 3 "~" H 10050 1100 50  0001 C CNN
	1    9900 1150
	-1   0    0    1   
$EndComp
Text Label 9900 750  1    50   ~ 0
GND
Text Label 950  3500 2    50   ~ 0
PYNQ_5V0
$Comp
L Device:C C1
U 1 1 5B9F37BE
P 9750 3900
F 0 "C1" V 9498 3900 50  0000 C CNN
F 1 "1U" V 9589 3900 50  0000 C CNN
F 2 "Capacitor_SMD:C_0201_0603Metric" H 9788 3750 50  0001 C CNN
F 3 "~" H 9750 3900 50  0001 C CNN
	1    9750 3900
	0    1    1    0   
$EndComp
Text Label 9900 3900 0    50   ~ 0
GND
Wire Wire Line
	9050 4000 9050 3300
Wire Wire Line
	9050 3300 8350 3300
$Comp
L Device:C C2
U 1 1 5B9F80AE
P 9750 4350
F 0 "C2" V 9498 4350 50  0000 C CNN
F 1 "4U7" V 9589 4350 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 9788 4200 50  0001 C CNN
F 3 "~" H 9750 4350 50  0001 C CNN
	1    9750 4350
	0    1    1    0   
$EndComp
Wire Wire Line
	9050 4000 9050 4350
Wire Wire Line
	9050 4350 9600 4350
Connection ~ 9050 4000
Text Label 9900 4350 0    50   ~ 0
GND
$Comp
L Device:L L1
U 1 1 5B9FFD16
P 9600 3150
F 0 "L1" H 9653 3196 50  0000 L CNN
F 1 "220R 2A CBF221HC" H 9653 3105 50  0000 L CNN
F 2 "Bricoleur-custom:CBF221HC" H 9600 3150 50  0001 C CNN
F 3 "~" H 9600 3150 50  0001 C CNN
	1    9600 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	9050 3300 9600 3300
Connection ~ 9050 3300
Wire Wire Line
	9600 3000 9600 2550
Wire Wire Line
	8350 3800 9300 3800
Wire Wire Line
	9300 3800 9300 3050
Wire Wire Line
	9300 1050 9600 1050
$Comp
L Device:R R2
U 1 1 5BA032BF
P 9300 2900
F 0 "R2" H 9231 2854 50  0000 R CNN
F 1 "15R" H 9231 2945 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 9230 2900 50  0001 C CNN
F 3 "~" H 9300 2900 50  0001 C CNN
	1    9300 2900
	1    0    0    1   
$EndComp
Wire Wire Line
	9300 1050 9300 2300
Wire Wire Line
	9600 1150 9400 1150
Wire Wire Line
	9400 1150 9400 2200
Wire Wire Line
	9400 3700 8350 3700
$Comp
L Device:R R3
U 1 1 5BA06B86
P 9400 2900
F 0 "R3" H 9470 2946 50  0000 L CNN
F 1 "15R" H 9470 2855 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 9330 2900 50  0001 C CNN
F 3 "~" H 9400 2900 50  0001 C CNN
	1    9400 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	9400 3050 9400 3700
$Comp
L IP4220CZ6:IP4220CZ6 U9
U 1 1 5BA09E46
P 10450 2300
F 0 "U9" H 10450 1630 50  0000 C CNN
F 1 "IP4220CZ6" H 10450 1721 50  0000 C CNN
F 2 "Bricoleur-custom:IP4220CZ6" H 10450 2300 50  0001 L BNN
F 3 "Unavailable" H 10450 2300 50  0001 L BNN
F 4 "Integrated circuit: ESD protection; SOT457" H 10450 2300 50  0001 L BNN "Field4"
F 5 "IP4220CZ6" H 10450 2300 50  0001 L BNN "Field5"
F 6 "None" H 10450 2300 50  0001 L BNN "Field6"
F 7 "TSOP-6 NXP Semiconductors" H 10450 2300 50  0001 L BNN "Field7"
F 8 "NXP Semiconductors" H 10450 2300 50  0001 L BNN "Field8"
	1    10450 2300
	-1   0    0    1   
$EndComp
Wire Wire Line
	9750 2300 9300 2300
Connection ~ 9300 2300
Wire Wire Line
	9300 2300 9300 2750
Text Label 11150 2100 1    50   ~ 0
GND
Wire Wire Line
	11150 2300 11150 2550
Wire Wire Line
	11150 2550 9600 2550
Connection ~ 9600 2550
Wire Wire Line
	9600 2550 9600 1350
Wire Wire Line
	9750 2200 9400 2200
Connection ~ 9400 2200
Wire Wire Line
	9400 2200 9400 2750
Text Label 10000 750  1    50   ~ 0
GND
$Comp
L Bricoleur-pcb-cache:UART_BOOT U8
U 1 1 5BA26E40
P 8800 1100
F 0 "U8" H 8750 1200 50  0000 L CNN
F 1 "UART_BOOT" H 8500 1300 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 8750 1200 50  0001 C CNN
F 3 "" H 8750 1200 50  0001 C CNN
	1    8800 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	8650 1800 8350 1800
Wire Wire Line
	8350 3600 8850 3600
Wire Wire Line
	8850 3600 8850 2650
Wire Wire Line
	8750 1650 8750 1700
Entry Wire Line
	8850 4400 8950 4300
Entry Wire Line
	3050 5100 2950 5200
Entry Wire Line
	3050 4800 2950 4900
Text Label 8350 4300 0    50   ~ 0
US0_CLK
Text Label 8350 4400 0    50   ~ 0
US0_CS
Text Label 8350 4200 0    50   ~ 0
US0_RX
Text Label 8350 4100 0    50   ~ 0
US0_TX
Text Label 2350 5700 0    50   ~ 0
US0_TX
Text Label 2350 5200 0    50   ~ 0
US0_RX
Text Label 2350 4900 0    50   ~ 0
US0_CLK
Text Label 2350 4000 0    50   ~ 0
US0_CS
Entry Wire Line
	8850 4100 8950 4000
Entry Wire Line
	8850 4200 8950 4100
Entry Wire Line
	8850 4300 8950 4200
Entry Wire Line
	4850 6550 4950 6650
Entry Wire Line
	4750 6550 4850 6650
Entry Wire Line
	4650 6550 4750 6650
Entry Wire Line
	4550 6550 4650 6650
Entry Wire Line
	4450 6550 4550 6650
Entry Wire Line
	4250 6550 4350 6650
Entry Wire Line
	4150 6550 4250 6650
Entry Wire Line
	4050 6550 4150 6650
Entry Wire Line
	3950 6550 4050 6650
Entry Wire Line
	3850 6550 3950 6650
Entry Wire Line
	3750 6550 3850 6650
Entry Wire Line
	3650 6550 3750 6650
Entry Wire Line
	3550 6550 3650 6650
Wire Wire Line
	4950 6650 4950 6950
Wire Wire Line
	4850 6650 4850 6950
Wire Wire Line
	4750 6650 4750 6950
Wire Wire Line
	4650 6650 4650 6950
Wire Wire Line
	4550 6650 4550 6950
Wire Wire Line
	4350 6650 4350 6950
Wire Wire Line
	4250 6650 4250 6950
Wire Wire Line
	4150 6650 4150 6950
Wire Wire Line
	4050 6650 4050 6950
Wire Wire Line
	3950 6650 3950 6950
Wire Wire Line
	3850 6650 3850 6950
Wire Wire Line
	3750 6650 3750 6950
Wire Wire Line
	3650 6650 3650 6950
Entry Wire Line
	2800 6400 2900 6500
Entry Wire Line
	2800 6300 2900 6400
Entry Wire Line
	2800 6200 2900 6300
Entry Wire Line
	2800 6100 2900 6200
Entry Wire Line
	2800 6000 2900 6100
Entry Wire Line
	2800 5900 2900 6000
Entry Wire Line
	2800 5800 2900 5900
Entry Wire Line
	2800 5600 2900 5700
Entry Wire Line
	2800 5500 2900 5600
Wire Wire Line
	2700 7350 2250 7350
Wire Wire Line
	2700 7450 2250 7450
Wire Wire Line
	2700 7550 2250 7550
Wire Wire Line
	2700 7650 2250 7650
Wire Wire Line
	2700 7750 2250 7750
Wire Wire Line
	2700 7850 2250 7850
Wire Wire Line
	2700 7950 2250 7950
Wire Wire Line
	2700 8050 2250 8050
Wire Wire Line
	2700 8150 2250 8150
Text Label 3650 6950 1    50   ~ 0
CAM0_DOUT2
Text Label 3750 6950 1    50   ~ 0
CAM0_DOUT3
Text Label 3850 6950 1    50   ~ 0
CAM0_DOUT4
Text Label 3950 6950 1    50   ~ 0
CAM0_DOUT5
Text Label 4050 6950 1    50   ~ 0
CAM0_DOUT6
Text Label 4150 6950 1    50   ~ 0
CAM0_DOUT7
Text Label 4350 6950 1    50   ~ 0
CAM0_DOUT9
Text Label 4250 6950 1    50   ~ 0
CAM0_DOUT8
Text Label 4550 6950 1    50   ~ 0
CAM0_PCLK
Text Label 4650 6950 1    50   ~ 0
CAM0_HREF
Text Label 4750 6950 1    50   ~ 0
CAM0_VSYNC
Text Label 4850 6950 1    50   ~ 0
CAM0_SDATA
Text Label 4950 6950 1    50   ~ 0
CAM0_SCL
Text Label 2350 5600 0    50   ~ 0
CAM0_DOUT2
Text Label 2350 6400 0    50   ~ 0
CAM0_DOUT3
Text Label 2350 5500 0    50   ~ 0
CAM0_DOUT4
Text Label 2350 6300 0    50   ~ 0
CAM0_DOUT5
Text Label 2350 5400 0    50   ~ 0
CAM0_DOUT6
Text Label 2350 6200 0    50   ~ 0
CAM0_DOUT7
Text Label 2350 5300 0    50   ~ 0
CAM0_DOUT8
Text Label 2350 6100 0    50   ~ 0
CAM0_DOUT9
Text Label 2350 6000 0    50   ~ 0
CAM0_PCLK
Text Label 2350 5100 0    50   ~ 0
CAM0_HREF
Wire Wire Line
	2700 8250 2250 8250
Entry Wire Line
	2800 5400 2900 5500
Entry Wire Line
	2800 5300 2900 5400
Wire Wire Line
	2700 7250 2250 7250
Wire Wire Line
	2700 7150 2250 7150
Wire Wire Line
	2700 7050 2250 7050
Text Label 2350 5900 0    50   ~ 0
CAM0_VSYNC
Text Label 2350 5000 0    50   ~ 0
CAM0_SDATA
Text Label 2350 5800 0    50   ~ 0
CAM0_SCL
Entry Wire Line
	3450 6150 3550 6250
Entry Wire Line
	3550 6150 3650 6250
Entry Wire Line
	3650 6150 3750 6250
Entry Wire Line
	3750 6150 3850 6250
Entry Wire Line
	3850 6150 3950 6250
Entry Wire Line
	4050 6150 4150 6250
Entry Wire Line
	4150 6150 4250 6250
Entry Wire Line
	4250 6150 4350 6250
Entry Wire Line
	4350 6150 4450 6250
Entry Wire Line
	4450 6150 4550 6250
Entry Wire Line
	4550 6150 4650 6250
Entry Wire Line
	4650 6150 4750 6250
Entry Wire Line
	4750 6150 4850 6250
Wire Wire Line
	3450 6150 3450 5700
Wire Wire Line
	3550 6150 3550 5700
Wire Wire Line
	3650 6150 3650 5700
Wire Wire Line
	3750 6150 3750 5700
Wire Wire Line
	3850 6150 3850 5700
Wire Wire Line
	4050 6150 4050 5700
Wire Wire Line
	4150 5700 4150 6150
Wire Wire Line
	4250 6150 4250 5700
Wire Wire Line
	4350 5700 4350 6150
Wire Wire Line
	4450 6150 4450 5700
Wire Wire Line
	4550 5700 4550 6150
Wire Wire Line
	4650 6150 4650 5700
Wire Wire Line
	4750 5700 4750 6150
Text Label 3450 5700 3    50   ~ 0
CAM1_SCL
Text Label 3550 5700 3    50   ~ 0
CAM1_SDATA
Text Label 3650 5700 3    50   ~ 0
CAM1_VSYNC
Text Label 3750 5700 3    50   ~ 0
CAM1_HREF
Text Label 3850 5700 3    50   ~ 0
CAM1_PCLK
Text Label 4050 5700 3    50   ~ 0
CAM1_DOUT9
Text Label 4150 5700 3    50   ~ 0
CAM1_DOUT8
Text Label 4250 5700 3    50   ~ 0
CAM1_DOUT7
Text Label 4350 5700 3    50   ~ 0
CAM1_DOUT6
Text Label 4450 5700 3    50   ~ 0
CAM1_DOUT5
Text Label 4550 5700 3    50   ~ 0
CAM1_DOUT4
Text Label 4650 5700 3    50   ~ 0
CAM1_DOUT3
Text Label 4750 5700 3    50   ~ 0
CAM1_DOUT2
Text Label 2350 3900 0    50   ~ 0
CAM1_DOUT2
Text Label 2350 4700 0    50   ~ 0
CAM1_DOUT3
Text Label 2350 3800 0    50   ~ 0
CAM1_DOUT4
Text Label 2350 4600 0    50   ~ 0
CAM1_DOUT5
Text Label 2350 3700 0    50   ~ 0
CAM1_DOUT6
Text Label 2350 4500 0    50   ~ 0
CAM1_DOUT7
Text Label 2350 3600 0    50   ~ 0
CAM1_DOUT8
Text Label 2350 4400 0    50   ~ 0
CAM1_DOUT9
Text Label 2350 4300 0    50   ~ 0
CAM1_PCLK
Text Label 2350 3500 0    50   ~ 0
CAM1_HREF
Text Label 2350 4200 0    50   ~ 0
CAM1_VSYNC
Text Label 2350 3300 0    50   ~ 0
CAM1_SDATA
Text Label 2350 4100 0    50   ~ 0
CAM1_SCL
Text Label 4400 1200 0    50   ~ 0
GND
Text Label 4350 2350 0    50   ~ 0
GND
Text Label 5200 2050 2    50   ~ 0
GND
Text Label 4400 1300 0    50   ~ 0
PYNQ_3V3
Text Label 4350 2450 0    50   ~ 0
PYNQ_3V3
Text Label 5200 2150 2    50   ~ 0
PYNQ_3V3
Wire Wire Line
	4400 1700 4800 1700
Wire Wire Line
	4800 1700 4800 1200
Wire Wire Line
	4800 1200 5900 1200
Wire Wire Line
	4350 2850 4900 2850
Wire Wire Line
	4900 2850 4900 1300
Wire Wire Line
	4900 1300 5900 1300
Wire Wire Line
	5200 2550 5000 2550
Wire Wire Line
	5000 2550 5000 1400
Wire Wire Line
	5000 1400 6000 1400
Text Label 8350 2900 0    50   ~ 0
GND
Text Label 10850 5500 0    50   ~ 0
PYNQ_3V3
Wire Wire Line
	8350 3900 9350 3900
Wire Wire Line
	9350 3900 9350 4950
Connection ~ 9350 3900
Wire Wire Line
	9350 3900 9600 3900
Text Notes 9600 4800 0    50   ~ 10
POWER SUPPLY\n -  Bør dobbeltsjekkes \n
Text Label 8350 5500 0    50   ~ 0
VDDU7
Text Label 8350 3000 0    50   ~ 0
VDDU7
Text Label 6150 1900 2    50   ~ 0
VDDU7
Text Label 6150 2800 2    50   ~ 0
VDDU7
Text Label 6150 4200 2    50   ~ 0
VDDU7
Text Label 6150 5500 2    50   ~ 0
VDDU7
Connection ~ 9600 5500
Wire Wire Line
	9600 5500 9500 5500
Text Label 10000 5800 2    50   ~ 0
VDDU7
Text Label 10150 5500 3    50   ~ 0
VMCU
Wire Wire Line
	9600 5500 9750 5500
$Comp
L Device:C C8
U 1 1 5BA5C7A0
P 9550 6100
F 0 "C8" H 9665 6146 50  0000 L CNN
F 1 "100N" H 9665 6055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 9588 5950 50  0001 C CNN
F 3 "~" H 9550 6100 50  0001 C CNN
	1    9550 6100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C9
U 1 1 5BA5C83A
P 9850 6100
F 0 "C9" H 9965 6146 50  0000 L CNN
F 1 "100N" H 9965 6055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 9888 5950 50  0001 C CNN
F 3 "~" H 9850 6100 50  0001 C CNN
	1    9850 6100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C10
U 1 1 5BA5C8E6
P 10100 6100
F 0 "C10" H 10215 6146 50  0000 L CNN
F 1 "100N" H 10215 6055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 10138 5950 50  0001 C CNN
F 3 "~" H 10100 6100 50  0001 C CNN
	1    10100 6100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C11
U 1 1 5BA5C97B
P 10350 6100
F 0 "C11" H 10465 6146 50  0000 L CNN
F 1 "100N" H 10465 6055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 10388 5950 50  0001 C CNN
F 3 "~" H 10350 6100 50  0001 C CNN
	1    10350 6100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C12
U 1 1 5BA5C9E1
P 10650 6100
F 0 "C12" H 10765 6146 50  0000 L CNN
F 1 "100N" H 10765 6055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 10688 5950 50  0001 C CNN
F 3 "~" H 10650 6100 50  0001 C CNN
	1    10650 6100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C13
U 1 1 5BA5CA48
P 10950 6100
F 0 "C13" H 11065 6146 50  0000 L CNN
F 1 "10U" H 11065 6055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 10988 5950 50  0001 C CNN
F 3 "~" H 10950 6100 50  0001 C CNN
	1    10950 6100
	1    0    0    -1  
$EndComp
Wire Wire Line
	9850 5950 9600 5950
Wire Wire Line
	10650 5950 10950 5950
Wire Wire Line
	9600 5500 9600 5800
Connection ~ 9600 5950
Wire Wire Line
	10950 6250 10650 6250
Wire Wire Line
	9850 6250 9700 6250
Wire Wire Line
	9700 6250 9700 6400
Connection ~ 9700 6250
Text Label 9700 6400 0    50   ~ 0
VSSU7
Text Label 8350 5400 0    50   ~ 0
VSSU7
Text Label 6150 2700 2    50   ~ 0
VSSU7
Text Label 6150 4300 2    50   ~ 0
VSS07
$Comp
L Device:L L2
U 1 1 5BA73BCD
P 9350 5500
F 0 "L2" V 9172 5500 50  0000 C CNN
F 1 "CBF102WB" V 9263 5500 50  0000 C CNN
F 2 "Bricoleur-custom:CBF102WB" H 9350 5500 50  0001 C CNN
F 3 "~" H 9350 5500 50  0001 C CNN
	1    9350 5500
	0    1    1    0   
$EndComp
$Comp
L Device:R R4
U 1 1 5BA81D5A
P 8950 5500
F 0 "R4" V 8743 5500 50  0000 C CNN
F 1 "1R" V 8834 5500 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 8880 5500 50  0001 C CNN
F 3 "~" H 8950 5500 50  0001 C CNN
	1    8950 5500
	0    1    1    0   
$EndComp
Wire Wire Line
	9200 5500 9100 5500
Connection ~ 10650 5950
Connection ~ 10650 6250
Wire Wire Line
	10350 5950 10650 5950
Wire Wire Line
	10350 6250 10650 6250
Connection ~ 10350 5950
Connection ~ 10350 6250
Wire Wire Line
	10100 5950 10350 5950
Wire Wire Line
	10100 6250 10350 6250
Connection ~ 10100 5950
Connection ~ 10100 6250
Connection ~ 9850 5950
Wire Wire Line
	9850 5950 10100 5950
Connection ~ 9850 6250
Wire Wire Line
	9850 6250 10100 6250
Wire Wire Line
	9550 5950 9600 5950
Wire Wire Line
	9550 6250 9700 6250
Wire Wire Line
	10000 5800 9600 5800
Wire Wire Line
	9600 5800 9600 5950
$Comp
L Device:C C5
U 1 1 5BABB9CF
P 8650 6100
F 0 "C5" H 8765 6146 50  0000 L CNN
F 1 "10U" H 8765 6055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 8688 5950 50  0001 C CNN
F 3 "~" H 8650 6100 50  0001 C CNN
	1    8650 6100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C6
U 1 1 5BABBA61
P 8950 6100
F 0 "C6" H 9065 6146 50  0000 L CNN
F 1 "10N" H 9065 6055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 8988 5950 50  0001 C CNN
F 3 "~" H 8950 6100 50  0001 C CNN
	1    8950 6100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C7
U 1 1 5BABBAF8
P 9200 6100
F 0 "C7" H 9315 6146 50  0000 L CNN
F 1 "10N" H 9315 6055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 9238 5950 50  0001 C CNN
F 3 "~" H 9200 6100 50  0001 C CNN
	1    9200 6100
	1    0    0    -1  
$EndComp
Connection ~ 9600 5800
Wire Wire Line
	8800 5500 8800 5750
Wire Wire Line
	8800 5950 8650 5950
Wire Wire Line
	9200 5950 8950 5950
Connection ~ 8800 5950
Connection ~ 8950 5950
Wire Wire Line
	8950 5950 8800 5950
Wire Wire Line
	9200 6250 8950 6250
Connection ~ 8950 6250
Wire Wire Line
	8950 6250 8650 6250
Wire Wire Line
	8950 6250 8950 6400
$Comp
L Device:C C4
U 1 1 5BAE8CAF
P 8600 5300
F 0 "C4" V 8348 5300 50  0000 C CNN
F 1 "1uF" V 8439 5300 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 8638 5150 50  0001 C CNN
F 3 "~" H 8600 5300 50  0001 C CNN
	1    8600 5300
	0    1    1    0   
$EndComp
Text Label 8750 5150 0    50   ~ 0
GND
Connection ~ 8800 5750
Wire Wire Line
	8800 5750 8800 5950
Wire Wire Line
	8800 5750 9100 5750
Text Label 8900 5750 0    50   ~ 0
AVDDU7
Text Label 6150 5600 2    50   ~ 0
AVDDU7
Text Label 6150 5200 2    50   ~ 0
AVDDU7
Text Label 9700 6350 3    50   ~ 0
GND
Text Label 8950 6300 3    50   ~ 0
GND
Wire Wire Line
	8750 5150 8750 5300
Wire Wire Line
	8450 5300 8350 5300
$Comp
L Switch:SW_Push SW2
U 1 1 5BBC40EF
P 5250 4700
F 0 "SW2" H 5250 4985 50  0000 C CNN
F 1 "SW_Push" H 5250 4894 50  0000 C CNN
F 2 "Bricoleur-custom:SWITCH_WURTH_4301182043816" H 5250 4900 50  0001 C CNN
F 3 "" H 5250 4900 50  0001 C CNN
	1    5250 4700
	1    0    0    -1  
$EndComp
Text Label 4650 4700 2    50   ~ 0
GND
$Comp
L Device:R R1
U 1 1 5BBCA070
P 4850 4700
F 0 "R1" V 4643 4700 50  0000 C CNN
F 1 "100R" V 4734 4700 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 4780 4700 50  0001 C CNN
F 3 "~" H 4850 4700 50  0001 C CNN
	1    4850 4700
	0    1    1    0   
$EndComp
$Comp
L Device:C C3
U 1 1 5BBD57A9
P 5500 4550
F 0 "C3" H 5615 4596 50  0000 L CNN
F 1 "100N" H 5615 4505 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 5538 4400 50  0001 C CNN
F 3 "~" H 5500 4550 50  0001 C CNN
	1    5500 4550
	1    0    0    -1  
$EndComp
Connection ~ 5500 4700
Wire Wire Line
	5500 4700 5450 4700
Wire Wire Line
	5050 4700 5000 4700
Wire Wire Line
	4700 4700 4650 4700
$Sheet
S 4050 3150 1300 1200
U 5BBE2085
F0 "debug" 50
F1 "file5BBE2084.sch" 50
$EndSheet
Text GLabel 10000 5500 3    50   Input ~ 0
VMCU
Text GLabel 5800 2100 3    50   Input ~ 0
DEBUG_EXT_CABLE_ATTACH
Wire Wire Line
	6150 2100 5800 2100
Wire Wire Line
	950  3400 650  3400
Text GLabel 750  3400 1    50   Input ~ 0
PYNQ_3V3
Text GLabel 8350 5000 2    50   Input ~ 0
DBG_LED_1
Text GLabel 8350 4900 2    50   Input ~ 0
DBG_LED_2
Text GLabel 8350 4800 2    50   Input ~ 0
DBG_LED_3
Text GLabel 6150 4800 0    50   Input ~ 0
DBG_PB_1
Text GLabel 6150 4900 0    50   Input ~ 0
DBG_PB_2
Text GLabel 6150 5000 0    50   Input ~ 0
DBG_PB_3
Wire Wire Line
	4400 1500 6150 1500
Wire Wire Line
	6150 1600 4850 1600
Wire Wire Line
	4850 1600 4850 2650
Wire Wire Line
	4850 2650 4350 2650
Wire Wire Line
	5200 2350 5050 2350
Wire Wire Line
	5050 2350 5050 1700
Wire Wire Line
	5050 1700 6150 1700
Text GLabel 950  3700 0    50   Input ~ 0
GND
Text Label 5500 4400 0    50   ~ 0
GND
Text GLabel 8350 3500 2    50   Input ~ 0
DH_TMS_SWDIO
Text GLabel 8950 2550 1    50   Input ~ 0
DH_TCK_SWCLK
Text GLabel 8350 3400 2    50   Input ~ 0
DH_TDO_SWO
NoConn ~ 9750 2000
$Sheet
S 700  700  1950 1950
U 5BACB073
F0 "Imponator" 50
F1 "file5BACB072.sch" 50
$EndSheet
$Comp
L Bricoleur-pcb-cache:SW_DP3T U11
U 1 1 5BAC4FA8
P 10450 5200
F 0 "U11" H 10525 5325 50  0000 C CNN
F 1 "SW_DP3T" H 10525 5234 50  0000 C CNN
F 2 "Bricoleur-custom:SW_CK_JS203011" H 10450 5200 50  0001 C CNN
F 3 "" H 10450 5200 50  0001 C CNN
	1    10450 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	9350 4950 10900 4950
Wire Wire Line
	10900 4950 10900 5300
Wire Wire Line
	10900 5300 10700 5300
Wire Wire Line
	10700 5500 10850 5500
Text Label 10850 5700 0    50   ~ 0
DBG_Supply
Wire Wire Line
	10850 5700 10700 5700
Wire Wire Line
	8650 1650 8650 1800
Wire Wire Line
	8750 1700 8350 1700
Wire Wire Line
	8950 2550 8950 2650
Wire Wire Line
	8950 2650 8850 2650
Connection ~ 8850 2650
Wire Wire Line
	8850 2650 8850 1650
Wire Bus Line
	8950 2700 9100 2700
Wire Bus Line
	9100 2700 9100 650 
Wire Wire Line
	8350 4100 8850 4100
Wire Wire Line
	8350 4200 8850 4200
Wire Wire Line
	8350 4300 8850 4300
Wire Wire Line
	8350 4400 8850 4400
Text Label 4850 5700 3    50   ~ 0
GND
Text Label 3550 6950 1    50   ~ 0
GND
Text GLabel 5850 4700 1    50   Input ~ 0
DH_#RESET
Wire Wire Line
	5500 4700 6150 4700
$Comp
L Connector:TestPoint TP1
U 1 1 5BC50B15
P 9750 5500
F 0 "TP1" H 9808 5620 50  0000 L CNN
F 1 "Test_VMCU" H 9808 5529 50  0000 L CNN
F 2 "" H 9950 5500 50  0001 C CNN
F 3 "~" H 9950 5500 50  0001 C CNN
	1    9750 5500
	1    0    0    -1  
$EndComp
Connection ~ 9750 5500
Wire Wire Line
	9750 5500 10350 5500
NoConn ~ 9600 950 
Entry Wire Line
	3000 2600 3100 2700
Entry Wire Line
	3000 2900 3100 3000
Entry Wire Line
	3000 2800 3100 2900
Entry Wire Line
	3000 3000 3100 3100
Text Label 3400 3100 2    50   ~ 0
US0_TX
Text Label 3400 3000 2    50   ~ 0
US0_RX
Text Label 3400 2900 2    50   ~ 0
US0_CLK
Text Label 3400 2700 2    50   ~ 0
US0_CS
Wire Wire Line
	3100 2700 3400 2700
$Comp
L Connector:Conn_01x04_Male J3
U 1 1 5BC708B0
P 3750 3000
F 0 "J3" H 3723 2880 50  0000 R CNN
F 1 "Conn_01x04_Male" H 3723 2971 50  0000 R CNN
F 2 "" H 3750 3000 50  0001 C CNN
F 3 "~" H 3750 3000 50  0001 C CNN
	1    3750 3000
	-1   0    0    1   
$EndComp
Wire Wire Line
	3100 3100 3550 3100
Wire Wire Line
	3100 3000 3550 3000
Wire Wire Line
	3100 2900 3550 2900
Wire Wire Line
	3400 2700 3400 2800
Wire Wire Line
	3400 2800 3550 2800
NoConn ~ 950  5400
NoConn ~ 950  5300
NoConn ~ 950  5200
NoConn ~ 950  5100
NoConn ~ 950  5000
NoConn ~ 950  4900
NoConn ~ 950  4800
NoConn ~ 950  4700
NoConn ~ 950  4600
NoConn ~ 950  4500
NoConn ~ 950  4400
NoConn ~ 950  4300
NoConn ~ 950  4200
NoConn ~ 950  4100
NoConn ~ 950  4000
NoConn ~ 950  3900
NoConn ~ 950  3800
NoConn ~ 950  3300
NoConn ~ 950  3200
NoConn ~ 8350 1900
NoConn ~ 8350 2000
NoConn ~ 8350 2100
NoConn ~ 8350 2200
NoConn ~ 8350 2300
NoConn ~ 8350 2400
NoConn ~ 8350 2500
NoConn ~ 8350 2600
NoConn ~ 8350 2700
NoConn ~ 8350 1200
NoConn ~ 8350 1300
NoConn ~ 8350 1400
NoConn ~ 8350 1500
NoConn ~ 8350 1600
NoConn ~ 6150 1800
NoConn ~ 6150 2000
NoConn ~ 6150 2200
NoConn ~ 6150 2300
NoConn ~ 6150 2400
NoConn ~ 6150 2500
NoConn ~ 6150 2600
NoConn ~ 6150 2900
NoConn ~ 6150 3000
NoConn ~ 6150 3100
NoConn ~ 6150 3200
NoConn ~ 6150 3300
NoConn ~ 6150 3400
NoConn ~ 6150 3500
NoConn ~ 6150 3600
NoConn ~ 6150 3700
NoConn ~ 6150 3800
NoConn ~ 6150 3900
NoConn ~ 6150 4000
NoConn ~ 6150 4100
NoConn ~ 6150 4400
NoConn ~ 6150 4500
NoConn ~ 6150 4600
NoConn ~ 6150 5100
NoConn ~ 6150 5300
NoConn ~ 6150 5400
NoConn ~ 6150 5700
NoConn ~ 6150 5800
NoConn ~ 6150 5900
NoConn ~ 6150 6000
NoConn ~ 6150 6100
NoConn ~ 8350 6100
NoConn ~ 8350 6000
NoConn ~ 8350 5900
NoConn ~ 8350 5800
NoConn ~ 8350 5700
NoConn ~ 8350 5600
NoConn ~ 8350 5200
NoConn ~ 8350 5100
NoConn ~ 8350 4700
NoConn ~ 8350 4600
NoConn ~ 8350 4500
NoConn ~ 9750 2100
Wire Wire Line
	5900 1300 5900 1200
Connection ~ 5900 1200
Wire Wire Line
	5900 1200 6000 1200
Wire Wire Line
	6000 1400 6000 1200
Connection ~ 6000 1200
Wire Wire Line
	6000 1200 6150 1200
NoConn ~ 6150 1300
NoConn ~ 6150 1400
$Comp
L Bricoleur-pcb-cache:PYNQ-Shield-Bricoleur-pcb-cache U2
U 1 1 5BADF788
P 1650 2600
F 0 "U2" H 1650 2365 50  0000 C CNN
F 1 "PYNQ-Shield-Bricoleur-pcb-cache" H 1650 2274 50  0000 C CNN
F 2 "Bricoleur-custom:PYNQ_Shield" H 1600 1450 50  0001 C CNN
F 3 "" H 1600 1450 50  0001 C CNN
	1    1650 2600
	1    0    0    -1  
$EndComp
NoConn ~ 2350 3100
NoConn ~ 2350 3200
NoConn ~ 2350 3400
Wire Wire Line
	2800 4500 2350 4500
Wire Wire Line
	2800 4400 2350 4400
Wire Wire Line
	2800 3900 2350 3900
Wire Wire Line
	2800 3800 2350 3800
Wire Wire Line
	2800 3700 2350 3700
Wire Wire Line
	2800 4600 2350 4600
Wire Wire Line
	2800 4700 2350 4700
Wire Wire Line
	2350 4000 2800 4000
Wire Wire Line
	2350 4300 2800 4300
Wire Wire Line
	2800 4200 2350 4200
Wire Wire Line
	2800 4100 2350 4100
Wire Wire Line
	2350 5000 2800 5000
Wire Wire Line
	2800 5100 2350 5100
Wire Wire Line
	2800 5300 2350 5300
Wire Wire Line
	2800 5400 2350 5400
Wire Wire Line
	2800 5500 2350 5500
Wire Wire Line
	2800 5600 2350 5600
Wire Wire Line
	2800 6400 2350 6400
Wire Wire Line
	2800 6300 2350 6300
Wire Wire Line
	2800 6200 2350 6200
Wire Wire Line
	2800 6100 2350 6100
Wire Wire Line
	2800 6000 2350 6000
Wire Wire Line
	2800 5900 2350 5900
Wire Wire Line
	2800 5800 2350 5800
Wire Bus Line
	3000 4850 3000 6250
Entry Wire Line
	2800 4700 2900 4800
Entry Wire Line
	2800 4600 2900 4700
Entry Wire Line
	2800 4500 2900 4600
Entry Wire Line
	2800 4400 2900 4500
Entry Wire Line
	2800 4300 2900 4400
Entry Wire Line
	2800 4200 2900 4300
Entry Wire Line
	2800 4100 2900 4200
Entry Wire Line
	2800 3900 2900 4000
Entry Wire Line
	2800 3800 2900 3900
Entry Wire Line
	2800 3700 2900 3800
Entry Wire Line
	2800 3600 2900 3700
Entry Wire Line
	2800 3500 2900 3600
Wire Wire Line
	2800 3500 2350 3500
Wire Wire Line
	2800 3600 2350 3600
Wire Bus Line
	3000 4850 2900 4850
Wire Bus Line
	3000 4750 3050 4750
Entry Wire Line
	3050 5600 2950 5700
Wire Wire Line
	2950 4900 2350 4900
Wire Wire Line
	2950 5200 2350 5200
Wire Bus Line
	3000 650  9100 650 
Wire Wire Line
	8350 4000 9050 4000
Wire Wire Line
	2350 5700 2950 5700
Wire Bus Line
	3050 4750 3050 5650
Wire Bus Line
	8950 2700 8950 4300
Wire Bus Line
	3000 650  3000 4750
Wire Bus Line
	2900 6550 4850 6550
Wire Bus Line
	2900 5300 2900 6550
Wire Bus Line
	3000 6250 4850 6250
Wire Bus Line
	2900 3600 2900 4850
$EndSCHEMATC
