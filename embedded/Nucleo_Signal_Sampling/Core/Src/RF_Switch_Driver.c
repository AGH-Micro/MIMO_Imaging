#include "RF_Switch_Driver.h"
#include "stm32h7xx.h"

void RF_init()
{
        //activating clock on the port
        RCC->AHB4ENR |= CTRL_CLOCK;

        //clearing current pin I/O settings (setting them to 00)
            CTRL_PORT->MODER &= ~(3U << (CTRL1_PIN*2));
            CTRL_PORT->MODER &= ~(3U << (CTRL2_PIN*2));
            CTRL_PORT->MODER &= ~(3U << (CTRL3_PIN*2));

        //setting ctrl pin as output pins
            CTRL_PORT->MODER |= (1U << (CTRL1_PIN*2));
            CTRL_PORT->MODER |= (1U << (CTRL2_PIN*2));
            CTRL_PORT->MODER |= (1U << (CTRL3_PIN*2));

    RF_change_path(RF_Path_Off);
}

void RF_change_path(RF_Path path)
{
    //if statement in case the chosen path is the same as the one currently set
    if (RF_current_path != path)
    {
        RF_current_path = path;
        switch(path)
        {
            case RF_Path_1:
                CTRL_PORT->BSRR = (1U << (CTRL1_PIN+16)) | (1U << (CTRL2_PIN+16)) | (1U << (CTRL3_PIN+16)); //set CTRL pins to 000
            break;

            case RF_Path_2:
                CTRL_PORT->BSRR = (1U << (CTRL1_PIN+16)) | (1U << (CTRL2_PIN+16)) | (1U << (CTRL3_PIN)); //set CTRL pins to 001
            break;

            case RF_Path_3:
                CTRL_PORT->BSRR = (1U << (CTRL1_PIN)) | (1U << (CTRL2_PIN+16)) | (1U << (CTRL3_PIN+16)); //set CTRL pins to 100
            break;
            
            case RF_Path_4:
                CTRL_PORT->BSRR = (1U << (CTRL1_PIN)) | (1U << (CTRL2_PIN+16)) | (1U << (CTRL3_PIN)); //set CTRL pins to 101
            break;

            case RF_Path_Off:
                CTRL_PORT->BSRR = (1U << (CTRL1_PIN)) | (1U << (CTRL2_PIN)) | (1U << (CTRL3_PIN)); //set CTRL pins to 111
            break;
            default:
            // nothing
            break;

        }
    }
}