EESchema Schematic File Version 4
LIBS:Bricoleur-pcb-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
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
L Bricoleur-pcb-cache:PYNQ-Shield U2
U 1 1 5B99B0DB
P 1650 2600
F 0 "U2" H 1650 2365 50  0000 C CNN
F 1 "PYNQ-Shield" H 1650 2274 50  0000 C CNN
F 2 "" H 1600 1450 50  0001 C CNN
F 3 "" H 1600 1450 50  0001 C CNN
	1    1650 2600
	1    0    0    -1  
$EndComp
$Comp
L Bricoleur-pcb-cache:Arducam-OV5642 U5
U 1 1 5B998412
P 4200 5200
F 0 "U5" H 4149 5528 50  0000 L CNN
F 1 "Arducam-OV5642" H 4240 5528 50  0000 L CNN
F 2 "" H 4200 5050 50  0001 C CNN
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
F 2 "" H 4200 7300 50  0001 C CNN
F 3 "" H 4200 7300 50  0001 C CNN
	1    4200 7450
	-1   0    0    1   
$EndComp
Text Label 950  3400 2    50   ~ 0
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
L Bricoleur-pcb-cache:Ultrasonic-LV-EZ1 U1
U 1 1 5B9AE131
P 4100 1250
F 0 "U1" V 4615 1219 50  0000 C CNN
F 1 "Ultrasonic-LV-EZ1" V 4524 1219 50  0000 C CNN
F 2 "" H 4100 1300 50  0001 C CNN
F 3 "" H 4100 1300 50  0001 C CNN
	1    4100 1250
	0    -1   -1   0   
$EndComp
$Comp
L Bricoleur-pcb-cache:Ultrasonic-LV-EZ1 U3
U 1 1 5B9AE194
P 5450 2300
F 0 "U3" V 5950 2250 50  0000 L CNN
F 1 "Ultrasonic-LV-EZ1" V 5850 1950 50  0000 L CNN
F 2 "" H 5450 2350 50  0001 C CNN
F 3 "" H 5450 2350 50  0001 C CNN
	1    5450 2300
	0    1    -1   0   
$EndComp
$Comp
L Bricoleur-pcb-cache:Ultrasonic-LV-EZ1 U4
U 1 1 5B9AE2C4
P 4100 2300
F 0 "U4" V 4600 2250 50  0000 L CNN
F 1 "Ultrasonic-LV-EZ1" V 4500 1950 50  0000 L CNN
F 2 "" H 4100 2350 50  0001 C CNN
F 3 "" H 4100 2350 50  0001 C CNN
	1    4100 2300
	0    -1   -1   0   
$EndComp
Text Label 2350 3800 0    50   ~ 0
CamCLK
Text Label 3950 5700 3    50   ~ 0
CamCLK
Text Label 4450 6950 1    50   ~ 0
CamCLK
$Comp
L Connector:USB_B_Micro J?
U 1 1 5B9CF6E3
P 9900 1150
F 0 "J?" H 9671 1048 50  0000 R CNN
F 1 "USB_B_Micro" H 9671 1139 50  0000 R CNN
F 2 "" H 10050 1100 50  0001 C CNN
F 3 "~" H 10050 1100 50  0001 C CNN
	1    9900 1150
	-1   0    0    1   
$EndComp
Text Label 9900 750  1    50   ~ 0
GND
Text Label 950  3500 2    50   ~ 0
PYNQ_5V0
$Comp
L Device:C C?
U 1 1 5B9F37BE
P 9750 3900
F 0 "C?" V 9498 3900 50  0000 C CNN
F 1 "C" V 9589 3900 50  0000 C CNN
F 2 "" H 9788 3750 50  0001 C CNN
F 3 "~" H 9750 3900 50  0001 C CNN
	1    9750 3900
	0    1    1    0   
$EndComp
Text Label 9900 3900 0    50   ~ 0
GND
Wire Wire Line
	8350 4000 9050 4000
Wire Wire Line
	9050 4000 9050 3300
Wire Wire Line
	9050 3300 8350 3300
$Comp
L Device:C C?
U 1 1 5B9F80AE
P 9750 4350
F 0 "C?" V 9498 4350 50  0000 C CNN
F 1 "C" V 9589 4350 50  0000 C CNN
F 2 "" H 9788 4200 50  0001 C CNN
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
L Device:L L?
U 1 1 5B9FFD16
P 9600 3150
F 0 "L?" H 9653 3196 50  0000 L CNN
F 1 "L" H 9653 3105 50  0000 L CNN
F 2 "" H 9600 3150 50  0001 C CNN
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
L Device:R R?
U 1 1 5BA032BF
P 9300 2900
F 0 "R?" H 9231 2854 50  0000 R CNN
F 1 "R" H 9231 2945 50  0000 R CNN
F 2 "" V 9230 2900 50  0001 C CNN
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
L Device:R R?
U 1 1 5BA06B86
P 9400 2900
F 0 "R?" H 9470 2946 50  0000 L CNN
F 1 "R" H 9470 2855 50  0000 L CNN
F 2 "" V 9330 2900 50  0001 C CNN
F 3 "~" H 9400 2900 50  0001 C CNN
	1    9400 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	9400 3050 9400 3700
Wire Wire Line
	9600 950  9050 950 
Wire Wire Line
	9050 950  9050 2100
Wire Wire Line
	9050 3200 8350 3200
$Comp
L IP4220CZ6:IP4220CZ6 U?
U 1 1 5BA09E46
P 10450 2300
F 0 "U?" H 10450 1630 50  0000 C CNN
F 1 "IP4220CZ6" H 10450 1721 50  0000 C CNN
F 2 "SOT95P275X110-6N" H 10450 2300 50  0001 L BNN
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
Wire Wire Line
	9750 2100 9050 2100
Connection ~ 9050 2100
Wire Wire Line
	9050 2100 9050 3200
Text Label 10000 750  1    50   ~ 0
GND
Text Notes 10100 3300 1    50   ~ 0
Not finished!\n
$Comp
L Bricoleur-pcb-cache:UART_BOOT U?
U 1 1 5BA26E40
P 8900 1550
F 0 "U?" H 9028 1340 50  0000 L CNN
F 1 "UART_BOOT" H 9028 1249 50  0000 L CNN
F 2 "" H 8850 1650 50  0001 C CNN
F 3 "" H 8850 1650 50  0001 C CNN
	1    8900 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	8750 2100 8750 2300
Wire Wire Line
	8750 2300 8350 2300
Wire Wire Line
	8350 3600 8950 3600
Wire Wire Line
	8950 3600 8950 2100
Wire Wire Line
	8850 2200 8350 2200
Wire Wire Line
	8850 2100 8850 2200
Wire Bus Line
	2750 650  8550 650 
Entry Wire Line
	8450 1800 8550 1700
Wire Wire Line
	8450 1500 8350 1500
Wire Wire Line
	8450 1600 8350 1600
Wire Wire Line
	8450 1700 8350 1700
Wire Wire Line
	8450 1800 8350 1800
Entry Wire Line
	2750 3200 2650 3300
Entry Wire Line
	2750 3500 2650 3600
Entry Wire Line
	2750 3400 2650 3500
Entry Wire Line
	2750 3600 2650 3700
Text Label 8350 1600 0    50   ~ 0
US0_CLK
Text Label 8350 1500 0    50   ~ 0
US0_CS
Text Label 8350 1700 0    50   ~ 0
US0_RX
Text Label 8350 1800 0    50   ~ 0
US0_TX
Text Label 2350 3700 0    50   ~ 0
US0_TX
Text Label 2350 3600 0    50   ~ 0
US0_RX
Text Label 2350 3500 0    50   ~ 0
US0_CLK
Text Label 2350 3300 0    50   ~ 0
US0_CS
Wire Wire Line
	2650 3300 2350 3300
Wire Wire Line
	2650 3700 2350 3700
Entry Wire Line
	8450 1500 8550 1400
Entry Wire Line
	8450 1600 8550 1500
Entry Wire Line
	8450 1700 8550 1600
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
	2800 5700 2900 5800
Entry Wire Line
	2800 5600 2900 5700
Entry Wire Line
	2800 5500 2900 5600
Wire Wire Line
	2800 5500 2350 5500
Wire Wire Line
	2800 5600 2350 5600
Wire Wire Line
	2800 5700 2350 5700
Wire Wire Line
	2800 5800 2350 5800
Wire Wire Line
	2800 5900 2350 5900
Wire Wire Line
	2800 6000 2350 6000
Wire Wire Line
	2800 6100 2350 6100
Wire Wire Line
	2800 6200 2350 6200
Wire Wire Line
	2800 6300 2350 6300
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
CAM0_XCLK
Text Label 4650 6950 1    50   ~ 0
CAM0_HREF
Text Label 4750 6950 1    50   ~ 0
CAM0_VSYNC
Text Label 4850 6950 1    50   ~ 0
CAM0_SDATA
Text Label 4950 6950 1    50   ~ 0
CAM0_SCL
Text Label 2350 6400 0    50   ~ 0
CAM0_DOUT2
Text Label 2350 6300 0    50   ~ 0
CAM0_DOUT3
Text Label 2350 6200 0    50   ~ 0
CAM0_DOUT4
Text Label 2350 6100 0    50   ~ 0
CAM0_DOUT5
Text Label 2350 6000 0    50   ~ 0
CAM0_DOUT6
Text Label 2350 5900 0    50   ~ 0
CAM0_DOUT7
Text Label 2350 5800 0    50   ~ 0
CAM0_DOUT8
Text Label 2350 5700 0    50   ~ 0
CAM0_DOUT9
Text Label 2350 5600 0    50   ~ 0
CAM0_XCLK
Text Label 2350 5500 0    50   ~ 0
CAM0_HREF
Wire Wire Line
	2800 6400 2350 6400
Entry Wire Line
	2800 5400 2900 5500
Entry Wire Line
	2800 5300 2900 5400
Entry Wire Line
	2800 5200 2900 5300
Wire Wire Line
	2800 5400 2350 5400
Wire Wire Line
	2800 5300 2350 5300
Wire Wire Line
	2800 5200 2350 5200
Text Label 2350 5400 0    50   ~ 0
CAM0_VSYNC
Text Label 2350 5300 0    50   ~ 0
CAM0_SDATA
Text Label 2350 5200 0    50   ~ 0
CAM0_SCL
Entry Wire Line
	2800 5100 2900 5200
Entry Wire Line
	2800 5000 2900 5100
Entry Wire Line
	2800 4900 2900 5000
Entry Wire Line
	2800 4800 2900 4900
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
	2800 4000 2900 4100
Entry Wire Line
	2800 3900 2900 4000
Wire Bus Line
	2900 5200 3000 5200
Wire Wire Line
	2800 5100 2350 5100
Wire Wire Line
	2800 5000 2350 5000
Wire Wire Line
	2800 4900 2350 4900
Wire Wire Line
	2800 4800 2350 4800
Wire Wire Line
	2800 4700 2350 4700
Wire Wire Line
	2800 4600 2350 4600
Wire Wire Line
	2800 4500 2350 4500
Wire Wire Line
	2800 4400 2350 4400
Wire Wire Line
	2800 4300 2350 4300
Wire Wire Line
	2800 4200 2350 4200
Wire Wire Line
	2800 4100 2350 4100
Wire Wire Line
	2350 4000 2800 4000
Wire Wire Line
	2800 3900 2350 3900
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
Wire Bus Line
	3000 5200 3000 6250
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
Text Label 2350 5100 0    50   ~ 0
CAM1_DOUT2
Text Label 2350 5000 0    50   ~ 0
CAM1_DOUT3
Text Label 2350 4900 0    50   ~ 0
CAM1_DOUT4
Text Label 2350 4800 0    50   ~ 0
CAM1_DOUT5
Text Label 2350 4700 0    50   ~ 0
CAM1_DOUT6
Text Label 2350 4600 0    50   ~ 0
CAM1_DOUT7
Text Label 2350 4500 0    50   ~ 0
CAM1_DOUT8
Text Label 2350 4400 0    50   ~ 0
CAM1_DOUT9
Text Label 2350 4300 0    50   ~ 0
CAM1_PCLK
Text Label 2350 4200 0    50   ~ 0
CAM1_HREF
Text Label 2350 4100 0    50   ~ 0
CAM1_VSYNC
Text Label 2350 4000 0    50   ~ 0
CAM1_SDATA
Text Label 2350 3900 0    50   ~ 0
CAM1_SCL
Text Label 4350 1000 0    50   ~ 0
GND
Text Label 4350 2050 0    50   ~ 0
GND
Text Label 5200 2050 2    50   ~ 0
GND
Text Label 4350 1100 0    50   ~ 0
PYNQ_3V3
Text Label 4350 2150 0    50   ~ 0
PYNQ_3V3
Text Label 5200 2150 2    50   ~ 0
PYNQ_3V3
Wire Wire Line
	4350 1500 4800 1500
Wire Wire Line
	4800 1500 4800 1200
Wire Wire Line
	4800 1200 6150 1200
Wire Wire Line
	4350 2550 4900 2550
Wire Wire Line
	4900 2550 4900 1300
Wire Wire Line
	4900 1300 6150 1300
Wire Wire Line
	5200 2550 5000 2550
Wire Wire Line
	5000 2550 5000 1400
Wire Wire Line
	5000 1400 6150 1400
Text Label 8350 2900 0    50   ~ 0
GND
Wire Wire Line
	2650 3500 2350 3500
Wire Wire Line
	2650 3600 2350 3600
$Comp
L Switch:SW_DPDT_x2 SW?
U 1 1 5BC8006E
P 9500 5500
F 0 "SW?" H 9500 5785 50  0000 C CNN
F 1 "SW_DPDT_x2" H 9500 5694 50  0000 C CNN
F 2 "" H 9500 5500 50  0001 C CNN
F 3 "" H 9500 5500 50  0001 C CNN
	1    9500 5500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5BC882E9
P 8800 5500
F 0 "R?" V 8593 5500 50  0000 C CNN
F 1 "R" V 8684 5500 50  0000 C CNN
F 2 "" V 8730 5500 50  0001 C CNN
F 3 "~" H 8800 5500 50  0001 C CNN
	1    8800 5500
	0    1    1    0   
$EndComp
Wire Wire Line
	8950 5500 9300 5500
Wire Wire Line
	9700 5400 9700 4950
Wire Wire Line
	9700 4950 9350 4950
Text Label 9700 5600 0    50   ~ 0
PYNQ_3V3
Wire Wire Line
	8350 3900 9350 3900
Wire Wire Line
	8650 5500 8350 5500
Wire Wire Line
	9350 3900 9350 4950
Wire Bus Line
	2750 650  2750 3700
Wire Bus Line
	8550 650  8550 1700
Wire Bus Line
	2900 6550 4850 6550
Wire Bus Line
	2900 5300 2900 6550
Wire Bus Line
	2900 4000 2900 5200
Wire Bus Line
	3000 6250 4850 6250
Connection ~ 9350 3900
Wire Wire Line
	9350 3900 9600 3900
Text Notes 8850 4900 0    50   ~ 10
STEMMER DETTE? USIKKER\n
$EndSCHEMATC
