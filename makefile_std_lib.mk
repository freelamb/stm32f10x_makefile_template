# STD Defines
DDEFS += -DSTM32F10X_MD_VL -DUSE_STDPERIPH_DRIVER -DHSE_VALUE=8000000

# Source directories
STM32F1_STD_LIB		= ./STM32F10x_StdPeriph_Driver
STM32F1_CORE_DIR	= ./CMSIS/CM3/CoreSupport
STM32F1_DEV_DIR		= ./CMSIS/CM3/DeviceSupport/ST/STM32F10x
STM32F1_SRC_DIR		= ./$(STM32F1_STD_LIB)/src
STM32F1_INC_DIR		= ./$(STM32F1_STD_LIB)/inc

ASM_SRC += ./$(STM32F1_DEV_DIR)/startup/gcc_ride7/startup_stm32f10x_md.s

# CMSIS
SRC += ./$(STM32F1_DEV_DIR)/system_stm32f10x.c
SRC += ./$(STM32F1_CORE_DIR)/core_cm3.c

# STM-Library sources
SRC += $(STM32F1_SRC_DIR)/stm32f10x_gpio.c
SRC += $(STM32F1_SRC_DIR)/stm32f10x_rcc.c
SRC += $(STM32F1_SRC_DIR)/stm32f10x_exti.c
SRC += $(STM32F1_SRC_DIR)/stm32f10x_usart.c
SRC += $(STM32F1_SRC_DIR)/misc.c

# Include directories
INCDIRS += $(STM32F1_CORE_DIR)
INCDIRS += $(STM32F1_DEV_DIR)
INCDIRS += $(STM32F1_INC_DIR)
INCDIRS += $(STM32F1_STD_LIB)
