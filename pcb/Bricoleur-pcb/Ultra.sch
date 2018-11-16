EESchema Schematic File Version 4
LIBS:Bricoleur-pcb-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 6 5
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
L Bricoleur-pcb-rescue:Bricoleur-pcb-cache_Ultrasonic-LV-EZ0-Bricoleur-pcb-cache U?
U 1 1 5BDAE42F
P 3750 3000
AR Path="/5BDAE42F" Ref="U?"  Part="1" 
AR Path="/5BDAE386/5BDAE42F" Ref="U1"  Part="1" 
F 0 "U1" V 4250 2950 50  0000 L CNN
F 1 "Ultrasonic-LV-EZ0" V 4150 2650 50  0000 L CNN
F 2 "Connector_IDC:IDC-Header_2x03_P2.54mm_Vertical" H 3750 3050 50  0001 C CNN
F 3 "" H 3750 3050 50  0001 C CNN
	1    3750 3000
	0    -1   1    0   
$EndComp
$Comp
L Bricoleur-pcb-rescue:Bricoleur-pcb-cache_Ultrasonic-LV-EZ0-Bricoleur-pcb-cache U?
U 1 1 5BDAE442
P 6250 3000
AR Path="/5BDAE442" Ref="U?"  Part="1" 
AR Path="/5BDAE386/5BDAE442" Ref="U3"  Part="1" 
F 0 "U3" V 6750 2950 50  0000 L CNN
F 1 "Ultrasonic-LV-EZ0" V 6650 2650 50  0000 L CNN
F 2 "Connector_IDC:IDC-Header_2x03_P2.54mm_Vertical" H 6250 3050 50  0001 C CNN
F 3 "" H 6250 3050 50  0001 C CNN
	1    6250 3000
	0    -1   1    0   
$EndComp
$Comp
L Bricoleur-pcb-rescue:Bricoleur-pcb-cache_Ultrasonic-LV-EZ0-Bricoleur-pcb-cache U?
U 1 1 5BDAE47A
P 8750 3000
AR Path="/5BDAE47A" Ref="U?"  Part="1" 
AR Path="/5BDAE386/5BDAE47A" Ref="U4"  Part="1" 
F 0 "U4" V 9250 2950 50  0000 L CNN
F 1 "Ultrasonic-LV-EZ0" V 9150 2650 50  0000 L CNN
F 2 "Connector_IDC:IDC-Header_2x03_P2.54mm_Vertical" H 8750 3050 50  0001 C CNN
F 3 "" H 8750 3050 50  0001 C CNN
	1    8750 3000
	0    -1   1    0   
$EndComp
Text GLabel 4000 2750 2    50   Input ~ 0
PULSE
Text GLabel 6500 2750 2    50   Input ~ 0
PULSE
Text GLabel 9000 2750 2    50   Input ~ 0
PULSE
Text HLabel 4650 2850 1    50   Input ~ 0
RX0
Wire Wire Line
	4650 3200 4550 3200
Wire Wire Line
	4550 3200 4550 2950
Wire Wire Line
	4550 2850 4650 2850
Wire Wire Line
	4000 2950 4550 2950
Connection ~ 4550 2950
Wire Wire Line
	4550 2950 4550 2850
Text HLabel 7150 2850 1    50   Input ~ 0
RX1
Wire Wire Line
	7150 3200 7050 3200
Wire Wire Line
	7050 3200 7050 2950
Wire Wire Line
	7050 2850 7150 2850
Wire Wire Line
	6500 2950 7050 2950
Connection ~ 7050 2950
Wire Wire Line
	7050 2950 7050 2850
Text HLabel 9650 2850 1    50   Input ~ 0
RX2
Wire Wire Line
	9650 3200 9550 3200
Wire Wire Line
	9550 3200 9550 2950
Wire Wire Line
	9550 2850 9650 2850
Wire Wire Line
	9000 2950 9550 2950
Connection ~ 9550 2950
Wire Wire Line
	9550 2950 9550 2850
Text GLabel 1650 3150 0    50   Input ~ 0
PULSE
Wire Wire Line
	2000 3150 1650 3150
Text GLabel 4000 3150 2    50   Input ~ 0
VMCU
Text GLabel 6500 3150 2    50   Input ~ 0
VMCU
Text GLabel 9000 3150 2    50   Input ~ 0
VMCU
Text GLabel 4000 3250 2    50   Input ~ 0
GND
Text GLabel 6500 3250 2    50   Input ~ 0
GND
Text GLabel 9000 3250 2    50   Input ~ 0
GND
$Comp
L Diode:BAT54S D?
U 1 1 5BFC89E0
P 2200 3150
AR Path="/5BB71F0F/5BFC89E0" Ref="D?"  Part="1" 
AR Path="/5BB7B6EA/5BFC89E0" Ref="D?"  Part="1" 
AR Path="/5BCBFDFB/5BFC89E0" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE7CD/5BFC89E0" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE90A/5BFC89E0" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE977/5BFC89E0" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAEF7E/5BFC89E0" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC0255/5BFC89E0" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC0258/5BFC89E0" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC025B/5BFC89E0" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC0255/5BFC89E0" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC0258/5BFC89E0" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC025B/5BFC89E0" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BFC89E0" Ref="D14"  Part="1" 
F 0 "D14" V 2154 3237 50  0000 L CNN
F 1 "BAT54S" V 2245 3237 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 2275 3275 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 2080 3150 50  0001 C CNN
	1    2200 3150
	0    1    1    0   
$EndComp
Text GLabel 2200 2850 1    50   Input ~ 0
GND
Text GLabel 2200 3450 3    50   Input ~ 0
VMCU
$Comp
L Diode:BAT54S D?
U 1 1 5BFCA009
P 4850 3200
AR Path="/5BB71F0F/5BFCA009" Ref="D?"  Part="1" 
AR Path="/5BB7B6EA/5BFCA009" Ref="D?"  Part="1" 
AR Path="/5BCBFDFB/5BFCA009" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE7CD/5BFCA009" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE90A/5BFCA009" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE977/5BFCA009" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAEF7E/5BFCA009" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC0255/5BFCA009" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC0258/5BFCA009" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC025B/5BFCA009" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC0255/5BFCA009" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC0258/5BFCA009" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC025B/5BFCA009" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BFCA009" Ref="D11"  Part="1" 
F 0 "D11" V 4804 3287 50  0000 L CNN
F 1 "BAT54S" V 4895 3287 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 4925 3325 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 4730 3200 50  0001 C CNN
	1    4850 3200
	0    1    1    0   
$EndComp
Text GLabel 4850 2900 1    50   Input ~ 0
GND
Text GLabel 4850 3500 3    50   Input ~ 0
VMCU
$Comp
L Diode:BAT54S D?
U 1 1 5BFCA7AC
P 7350 3200
AR Path="/5BB71F0F/5BFCA7AC" Ref="D?"  Part="1" 
AR Path="/5BB7B6EA/5BFCA7AC" Ref="D?"  Part="1" 
AR Path="/5BCBFDFB/5BFCA7AC" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE7CD/5BFCA7AC" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE90A/5BFCA7AC" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE977/5BFCA7AC" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAEF7E/5BFCA7AC" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC0255/5BFCA7AC" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC0258/5BFCA7AC" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC025B/5BFCA7AC" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC0255/5BFCA7AC" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC0258/5BFCA7AC" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC025B/5BFCA7AC" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BFCA7AC" Ref="D12"  Part="1" 
F 0 "D12" V 7304 3287 50  0000 L CNN
F 1 "BAT54S" V 7395 3287 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 7425 3325 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 7230 3200 50  0001 C CNN
	1    7350 3200
	0    1    1    0   
$EndComp
Text GLabel 7350 2900 1    50   Input ~ 0
GND
Text GLabel 7350 3500 3    50   Input ~ 0
VMCU
$Comp
L Diode:BAT54S D?
U 1 1 5BFCB2DC
P 9850 3200
AR Path="/5BB71F0F/5BFCB2DC" Ref="D?"  Part="1" 
AR Path="/5BB7B6EA/5BFCB2DC" Ref="D?"  Part="1" 
AR Path="/5BCBFDFB/5BFCB2DC" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE7CD/5BFCB2DC" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE90A/5BFCB2DC" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE977/5BFCB2DC" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAEF7E/5BFCB2DC" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC0255/5BFCB2DC" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC0258/5BFCB2DC" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC025B/5BFCB2DC" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC0255/5BFCB2DC" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC0258/5BFCB2DC" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC025B/5BFCB2DC" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BFCB2DC" Ref="D13"  Part="1" 
F 0 "D13" V 9804 3287 50  0000 L CNN
F 1 "BAT54S" V 9895 3287 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 9925 3325 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 9730 3200 50  0001 C CNN
	1    9850 3200
	0    1    1    0   
$EndComp
Text GLabel 9850 2900 1    50   Input ~ 0
GND
Text GLabel 9850 3500 3    50   Input ~ 0
VMCU
$EndSCHEMATC
