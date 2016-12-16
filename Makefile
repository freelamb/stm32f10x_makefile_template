#
#       !!!! Do NOT edit this makefile with an editor which replace tabs by spaces !!!!   
#
##############################################################################################
#
#	this is originally from https://github.com/franzflasch/stm32f1_makefile_project_template
#
#
# On command line:
#
# make all = Create project
#
# make clean = Clean project files.
#
# make flash = build project files and flash the microcontroller via st-flash (https://github.com/texane/stlink.git)
#
# To rebuild project do "make clean" and "make all".
#
# This makefile offers the possibility to build STM32 projects without any IDE.
# possibilty to define own project directory structures.
#
# Use at your own risk!!!!!
#
##############################################################################################
# Start of default section
#
CCPREFIX   = arm-none-eabi-
CC         = $(CCPREFIX)gcc
CP         = $(CCPREFIX)objcopy
AS         = $(CCPREFIX)gcc -x assembler-with-cpp
GDBTUI     = $(CCPREFIX)gdbtui
HEX        = $(CP) -O ihex
BIN        = $(CP) -O binary -S
MCU        = cortex-m3
 
# List all C defines here
DDEFS =

# Define optimisation level here
OPT = -Os

# Define project name and Ram/Flash mode here
PROJECT	= bin/stm32_makefile_template

# Source directories
LINKERSCRIPT	= ./linkerscript/stm32_flash.ld
USER_INC_DIR	= ./user/inc

# USER SPECIFIC
SRC  = ./user/src/main.c
SRC  += ./user/src/stm32_config.c
ASM_SRC = 

INCDIRS = $(USER_INC_DIR)

# include submakefiles here
include makefile_std_lib.mk # STM32 Standard Peripheral Library


INCDIR  = $(patsubst %,-I%, $(INCDIRS))

## run from Flash
DEFS	= $(DDEFS) -DRUN_FROM_FLASH=1

OBJS  	= $(ASM_SRC:.s=.o) $(SRC:.c=.o)

MCFLAGS = -mcpu=$(MCU)

ASFLAGS = $(MCFLAGS) -g -gdwarf-2 -mthumb  -Wa,-amhls=$(<:.s=.lst) 
CPFLAGS = $(MCFLAGS) $(OPT) -g -gdwarf-2 -mthumb -fomit-frame-pointer -Wall -fverbose-asm -Wa,-ahlms=$(<:.c=.lst) $(DEFS)

# "-Xlinker --gc-sections" - removes unused code from the output binary - saves memory
LDFLAGS = $(MCFLAGS) -g -gdwarf-2 -mthumb -nostartfiles -Xlinker --gc-sections -T$(LINKERSCRIPT) -Wl,-Map=$(PROJECT).map,--cref,--no-warn-mismatch $(LIBDIR) $(LIB)


#
# makefile rules
# 
all: $(OBJS) $(PROJECT).elf  $(PROJECT).hex $(PROJECT).bin
	$(CCPREFIX)size $(PROJECT).elf
 
%o: %c
	$(CC) -c $(CPFLAGS) -I . $(INCDIR) $< -o $@

%o: %s
	$(AS) -c $(ASFLAGS) $< -o $@

%elf: $(OBJS)
	$(CC) $(OBJS) $(LDFLAGS) $(LIBS) -o $@

%hex: %elf
	$(HEX) $< $@
	
%bin: %elf
	$(BIN)  $< $@
	
flash: $(PROJECT).bin
	st-flash write $(PROJECT).bin 0x8000000

erase:
	st-flash erase

debug: $(PROJECT).elf
	xterm -e st-util &
	$(GDBTUI) --eval-command="target remote localhost:4242"  $(PROJECT).elf -ex 'load'
		
clean:
	-rm -rf $(OBJS)
	-rm -rf $(PROJECT).elf
	-rm -rf $(PROJECT).map
	-rm -rf $(PROJECT).hex
	-rm -rf $(PROJECT).bin
	-rm -rf $(SRC:.c=.lst)
	-rm -rf $(ASRC:.s=.lst)
# *** EOF ***
