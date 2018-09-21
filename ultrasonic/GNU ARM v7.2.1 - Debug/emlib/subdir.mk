################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4/platform/emlib/src/em_system.c 

OBJS += \
./emlib/em_system.o 

C_DEPS += \
./emlib/em_system.d 


# Each subdirectory must supply rules for building sources it contributes
emlib/em_system.o: /home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4/platform/emlib/src/em_system.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU ARM C Compiler'
	arm-none-eabi-gcc -g -gdwarf-2 -mcpu=cortex-m3 -mthumb -std=c99 '-DEFM32G890F128=1' '-DDEBUG=1' -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//platform/CMSIS/Include" -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//hardware/kit/common/bsp" -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//platform/emlib/inc" -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//hardware/kit/common/drivers" -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//platform/Device/SiliconLabs/EFM32G/Include" -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//hardware/kit/EFM32_Gxxx_STK/config" -O0 -Wall -c -fmessage-length=0 -mno-sched-prolog -fno-builtin -ffunction-sections -fdata-sections -MMD -MP -MF"emlib/em_system.d" -MT"emlib/em_system.o" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


