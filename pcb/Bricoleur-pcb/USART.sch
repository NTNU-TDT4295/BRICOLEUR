EESchema Schematic File Version 4
LIBS:Bricoleur-pcb-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 5
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
L Connector_Generic:Conn_02x03_Odd_Even J3
U 1 1 5BEC0490
P 3700 2350
AR Path="/5BEB800B/5BEC0490" Ref="J3"  Part="1" 
AR Path="/5BEE7FFD/5BEC0490" Ref="J4"  Part="1" 
F 0 "J3" V 3796 2162 50  0000 R CNN
F 1 "Conn_02x03_Odd_Even" V 3705 2162 50  0000 R CNN
F 2 "Connector_IDC:IDC-Header_2x03_P2.54mm_Vertical" H 3700 2350 50  0001 C CNN
F 3 "~" H 3700 2350 50  0001 C CNN
	1    3700 2350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1450 4300 3800 4300
Wire Wire Line
	3700 2550 3700 3450
Wire Wire Line
	1950 3450 3700 3450
Wire Wire Line
	3800 2550 3800 4300
Text GLabel 3350 2050 0    50   Input ~ 0
GND
Wire Wire Line
	3350 2050 3600 2050
Wire Wire Line
	3600 2050 3700 2050
Connection ~ 3600 2050
Wire Wire Line
	3700 2050 3800 2050
Connection ~ 3700 2050
Text HLabel 2900 4300 1    50   Input ~ 0
CLK
Text HLabel 2900 3450 1    50   Input ~ 0
RX
Text HLabel 2900 2550 1    50   Input ~ 0
TX
Wire Wire Line
	2400 2550 3600 2550
$Comp
L Diode:BAT54S D?
U 1 1 5BFCE38E
P 1250 4300
AR Path="/5BB71F0F/5BFCE38E" Ref="D?"  Part="1" 
AR Path="/5BB7B6EA/5BFCE38E" Ref="D?"  Part="1" 
AR Path="/5BCBFDFB/5BFCE38E" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE7CD/5BFCE38E" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE90A/5BFCE38E" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE977/5BFCE38E" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAEF7E/5BFCE38E" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC0255/5BFCE38E" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC0258/5BFCE38E" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC025B/5BFCE38E" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC0255/5BFCE38E" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC0258/5BFCE38E" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC025B/5BFCE38E" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BFCE38E" Ref="D18"  Part="1" 
AR Path="/5BEB800B/5BFCE38E" Ref="D15"  Part="1" 
F 0 "D15" V 1204 4387 50  0000 L CNN
F 1 "BAT54S" V 1295 4387 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 1325 4425 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 1130 4300 50  0001 C CNN
	1    1250 4300
	0    -1   -1   0   
$EndComp
Text GLabel 1250 4600 3    50   Input ~ 0
GND
Text GLabel 1250 4000 1    50   Input ~ 0
VMCU
$Comp
L Diode:BAT54S D?
U 1 1 5BFCE61A
P 1750 3450
AR Path="/5BB71F0F/5BFCE61A" Ref="D?"  Part="1" 
AR Path="/5BB7B6EA/5BFCE61A" Ref="D?"  Part="1" 
AR Path="/5BCBFDFB/5BFCE61A" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE7CD/5BFCE61A" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE90A/5BFCE61A" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE977/5BFCE61A" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAEF7E/5BFCE61A" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC0255/5BFCE61A" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC0258/5BFCE61A" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC025B/5BFCE61A" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC0255/5BFCE61A" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC0258/5BFCE61A" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC025B/5BFCE61A" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BFCE61A" Ref="D17"  Part="1" 
AR Path="/5BEE7FFD/5BFCE61A" Ref="D20"  Part="1" 
F 0 "D17" V 1704 3537 50  0000 L CNN
F 1 "BAT54S" V 1795 3537 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 1825 3575 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 1630 3450 50  0001 C CNN
	1    1750 3450
	0    -1   -1   0   
$EndComp
Text GLabel 1750 3750 3    50   Input ~ 0
GND
Text GLabel 1750 3150 1    50   Input ~ 0
VMCU
$Comp
L Diode:BAT54S D?
U 1 1 5BFCE778
P 2200 2550
AR Path="/5BB71F0F/5BFCE778" Ref="D?"  Part="1" 
AR Path="/5BB7B6EA/5BFCE778" Ref="D?"  Part="1" 
AR Path="/5BCBFDFB/5BFCE778" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE7CD/5BFCE778" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE90A/5BFCE778" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAE977/5BFCE778" Ref="D?"  Part="1" 
AR Path="/5BDAE386/5BDAEF7E/5BFCE778" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC0255/5BFCE778" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC0258/5BFCE778" Ref="D?"  Part="1" 
AR Path="/5BEB800B/5BEC025B/5BFCE778" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC0255/5BFCE778" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC0258/5BFCE778" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BEC025B/5BFCE778" Ref="D?"  Part="1" 
AR Path="/5BEE7FFD/5BFCE778" Ref="D19"  Part="1" 
AR Path="/5BEB800B/5BFCE778" Ref="D16"  Part="1" 
F 0 "D16" V 2154 2637 50  0000 L CNN
F 1 "BAT54S" V 2245 2637 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 2275 2675 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 2080 2550 50  0001 C CNN
	1    2200 2550
	0    -1   -1   0   
$EndComp
Text GLabel 2200 2850 3    50   Input ~ 0
GND
Text GLabel 2200 2250 1    50   Input ~ 0
VMCU
$EndSCHEMATC
