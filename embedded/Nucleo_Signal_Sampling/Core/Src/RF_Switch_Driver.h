#ifndef rf_switch_driver_h
#define rf_switch_driver_h


//Using pins on singular port allows for much faster bit change
#define CTRL_PORT
#define CTRL1_PIN
#define CTRL2_PIN
#define CTRL3_PIN

//Set as RCC_AHB4ENR_(port name)EN, allows to enable clock on the port
#define CTRL_CLOCK

//Enumeration of possible RF Switch states
typedef enum {
    RF_Path_Off = 0,
    RF_Path_1,
    RF_Path_2,
    RF_Path_3,
    RF_Path_4
} RF_Path;

//Initializes RF Switch and cuts off any existing path connection
void RF_init();
//Changes RF Switch state to path defined by the user
void RF_change_path(RF_Path);

extern RF_Path RF_current_path = RF_Path_Off;

#endif