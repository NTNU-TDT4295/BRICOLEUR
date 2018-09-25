################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4/platform/Device/SiliconLabs/EFM32G/Source/system_efm32g.c 

S_UPPER_SRCS += \
/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4/platform/Device/SiliconLabs/EFM32G/Source/GCC/startup_efm32g.S 

OBJS += \
./CMSIS/EFM32G/startup_efm32g.o \
./CMSIS/EFM32G/system_efm32g.o 

C_DEPS += \
./CMSIS/EFM32G/system_efm32g.d 


# Each subdirectory must supply rules for building sources it contributes
CMSIS/EFM32G/startup_efm32g.o: /home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4/platform/Device/SiliconLabs/EFM32G/Source/GCC/startup_efm32g.S
	@echo 'Building file: $<'
	@echo 'Invoking: GNU ARM Assembler'
	arm-none-eabi-gcc -g -gdwarf-2 -mcpu=cortex-m3 -mthumb -c -x assembler-with-cpp -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//platform/CMSIS/Include" -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//hardware/kit/EFM32_Gxxx_STK/config" -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//platform/Device/SiliconLabs/EFM32G/Include" -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//platform/emlib/inc" -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//hardware/kit/common/bsp" -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//hardware/kit/common/drivers" '-DEFM32G890F128=1' -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

CMSIS/EFM32G/system_efm32g.o: /home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4/platform/Device/SiliconLabs/EFM32G/Source/system_efm32g.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU ARM C Compiler'
	arm-none-eabi-gcc -g -gdwarf-2 -mcpu=cortex-m3 -mthumb -std=c99 '-DDEBUG=1' '-DEFM32G890F128=1' -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//platform/emlib/src" -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//platform/CMSIS/Include" -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//hardware/kit/EFM32_Gxxx_STK/config" -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//platform/Device/SiliconLabs/EFM32G/Include" -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//platform/emlib/inc" -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//hardware/kit/common/bsp" -I"/home/olatoft/program/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v2.4//hardware/kit/common/drivers" -O0 -Wall -c -fmessage-length=0 -mno-sched-prolog -fno-builtin -ffunction-sections -fdata-sections -MMD -MP -MF"CMSIS/EFM32G/system_efm32g.d" -MT"CMSIS/EFM32G/system_efm32g.o" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


