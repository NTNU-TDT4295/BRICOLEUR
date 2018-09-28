EESchema Schematic File Version 4
LIBS:Bricoleur-pcb-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 5 18
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 5550 2950 0    50   Input ~ 0
INP
$Comp
L Diode:BAT54S D8
U 1 1 5BB71F8A
P 5850 2950
AR Path="/5BB71F0F/5BB71F8A" Ref="D8"  Part="1" 
AR Path="/5BB7B6EA/5BB71F8A" Ref="D9"  Part="1" 
AR Path="/5BCBFDFB/5BB71F8A" Ref="D10"  Part="1" 
AR Path="/5BDAE386/5BDAE7CD/5BB71F8A" Ref="D11"  Part="1" 
AR Path="/5BDAE386/5BDAE90A/5BB71F8A" Ref="D12"  Part="1" 
AR Path="/5BDAE386/5BDAE977/5BB71F8A" Ref="D13"  Part="1" 
AR Path="/5BDAE386/5BDAEF7E/5BB71F8A" Ref="D14"  Part="1" 
AR Path="/5BEB800B/5BEC0255/5BB71F8A" Ref="D15"  Part="1" 
AR Path="/5BEB800B/5BEC0258/5BB71F8A" Ref="D16"  Part="1" 
AR Path="/5BEB800B/5BEC025B/5BB71F8A" Ref="D17"  Part="1" 
AR Path="/5BEE7FFD/5BEC0255/5BB71F8A" Ref="D18"  Part="1" 
AR Path="/5BEE7FFD/5BEC0258/5BB71F8A" Ref="D19"  Part="1" 
AR Path="/5BEE7FFD/5BEC025B/5BB71F8A" Ref="D20"  Part="1" 
F 0 "D8" V 5804 3037 50  0000 L CNN
F 1 "BAT54S" V 5895 3037 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 5925 3075 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 5730 2950 50  0001 C CNN
	1    5850 2950
	0    1    1    0   
$EndComp
Wire Wire Line
	5650 2950 5550 2950
Text GLabel 5850 3250 3    50   Input ~ 0
GND
Text GLabel 5850 2650 1    50   Input ~ 0
VMCU
$EndSCHEMATC
