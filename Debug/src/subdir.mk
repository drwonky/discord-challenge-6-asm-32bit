################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_UPPER_SRCS += \
../src/discord-challenge-6-asm.S 

OBJS += \
./src/discord-challenge-6-asm.o 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.S
	@echo 'Building file: $<'
	@echo 'Invoking: GCC Assembler'
	as --32 -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


