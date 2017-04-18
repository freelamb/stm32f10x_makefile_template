# STM32 Makefile Template

[![Build Status](https://travis-ci.org/runmec/stm32f10x_makefile_template.svg?branch=master)](https://travis-ci.org/runmec/stm32f10x_makefile_template)

## Requirement

Working GNU ARM GCC (https://launchpad.net/gcc-arm-embedded)

Texane stlink to flash the STM32F10x (https://github.com/texane/stlink)


## Usage

### build project

```$ make```

### clean project

```$ make clean```

### download to mcu by stlink 
```$ make flash```

### erase flash
```$ make erase```

### download main.bin to mcu
``` $ ./build.sh```

## Example

mcu: STM32F103C8T6

GPIOB6--Led

