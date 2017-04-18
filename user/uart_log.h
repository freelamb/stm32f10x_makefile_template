//
// Created by YangYongbao on 2017/3/18.
//

#ifndef STM32F10X_MAKEFILE_TEMPLATE_UART_LOG_H
#define STM32F10X_MAKEFILE_TEMPLATE_UART_LOG_H

void uart_log_init(void);

void debug(const char *format, ...);

#endif //STM32F10X_MAKEFILE_TEMPLATE_UART_LOG_H
