#include "stm32f10x.h"
#include "stm32_config.h"

void Delay(__IO uint32_t nCount)
{
    for(; nCount != 0; nCount--);
}

int main() {

    RCC_Configuration();
    GPIO_Configuration();

	while(1) {
		GPIO_ResetBits(GPIOB, GPIO_Pin_6);
		Delay(1000000);
		GPIO_SetBits(GPIOB, GPIO_Pin_6);
		Delay(1000000);
	}

	return 0;
}