################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/subdir.mk
-include emlib/subdir.mk
-include CMSIS/EFM32G/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 

# All Target
all: ultrasonic.axf

# Tool invocations
ultrasonic.axf: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: GNU ARM C Linker'
	arm-none-eabi-gcc -g -gdwarf-2 -mcpu=cortex-m3 -mthumb -T "ultrasonic.ld" -Xlinker --gc-sections -Xlinker -Map="ultrasonic.map" --specs=nano.specs -o ultrasonic.axf "./CMSIS/EFM32G/startup_efm32g.o" "./CMSIS/EFM32G/system_efm32g.o" "./emlib/em_system.o" "./src/main.o" -lm -Wl,--start-group -lgcc -lc -lnosys -Wl,--end-group
	@echo 'Finished building target: $@'
	@echo ' '

	@echo 'Building hex file: ultrasonic.hex'
	arm-none-eabi-objcopy -O ihex "ultrasonic.axf" "ultrasonic.hex"
	@echo ' '

	@echo 'Building bin file: ultrasonic.bin'
	arm-none-eabi-objcopy -O binary "ultrasonic.axf" "ultrasonic.bin"
	@echo ' '

	@echo 'Building s37 file: ultrasonic.s37'
	arm-none-eabi-objcopy -O srec "ultrasonic.axf" "ultrasonic.s37"
	@echo ' '

	@echo 'Running size tool'
	arm-none-eabi-size "ultrasonic.axf"
	@echo ' '

# Other Targets
clean:
	-$(RM) $(EXECUTABLES)$(OBJS)$(C_DEPS) ultrasonic.axf
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
