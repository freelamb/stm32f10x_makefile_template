//
// Created by YangYongbao on 2017/3/16.
//

#include "stm32f10x.h"
#include "stm32f10x_conf.h"
#include "uart_log.h"

void Delay(__IO uint32_t nCount)
{
    for(; nCount != 0; nCount--);
}

void RCC_Configuration(void)
{
    ErrorStatus HSEStartUpStatus;

    /* RCC system reset(for debug purpose) */
    RCC_DeInit();
    /* Enable HSE */
    RCC_HSEConfig(RCC_HSE_ON);
    /* Wait till HSE is ready */
    HSEStartUpStatus = RCC_WaitForHSEStartUp();
    if (HSEStartUpStatus == SUCCESS) {
        /* HCLK = SYSCLK */
        RCC_HCLKConfig(RCC_SYSCLK_Div1);
        /* PCLK2 = HCLK */
        RCC_PCLK2Config(RCC_HCLK_Div1);
        /* PCLK1 = HCLK/2 */
        RCC_PCLK1Config(RCC_HCLK_Div2);
        /* Enable PLL */
        RCC_PLLCmd(ENABLE);
        /* Wait till PLL is ready */
        while (RCC_GetFlagStatus(RCC_FLAG_PLLRDY) == RESET);
        /* Select PLL as system clock source */
        RCC_SYSCLKConfig(RCC_SYSCLKSource_PLLCLK);
        /* Wait till PLL is used as system clock source */
        while (RCC_GetSYSCLKSource() != 0x08);
    }
}

void GPIO_Configuration(void)
{
    GPIO_InitTypeDef GPIO_InitStructure;

    /* GPIOB clock enable */
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB, ENABLE);

    GPIO_InitStructure.GPIO_Pin =  GPIO_Pin_6;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_Init(GPIOB, &GPIO_InitStructure);
}

int main() {

    RCC_Configuration();
    GPIO_Configuration();

    // uart log init
    uart_log_init();

    debug("start main");

    while(1) {
        GPIO_ResetBits(GPIOB, GPIO_Pin_6);
        debug("open");
        Delay(1000000);
        GPIO_SetBits(GPIOB, GPIO_Pin_6);
        debug("close");
        Delay(1000000);
    }

    return 0;
}