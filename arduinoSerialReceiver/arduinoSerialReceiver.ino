#define BAUD_RATE 115200
#define MOTOR_PIN_OFFSET 9 //what pin on Arduino corresponds to motor 0
#define MOTOR_COUNT 1


#include <Servo.h>

Servo motors[MOTOR_COUNT];

void setup() {
    //Setup (servo) motors on their corresponding pins
    for(int i = 0; i < MOTOR_COUNT; i++)
    {
        motors[i].attach(i + MOTOR_PIN_OFFSET);
    }

    // Open serial communications and wait for port to open:
    Serial.begin(BAUD_RATE);
    while (!Serial) {
      ; // wait for serial port to connect.
    }


}

void speakerMotorControl()
{
    //The next 2 bytes read on the serial interface are:
    //<uint8 motor_number> <uint8 angle>
    uint8_t motor_number;
    uint8_t angle;
    
    if (Serial.available()) 
    {
        motor_number = Serial.read();
        angle = Serial.read();

        //Adjust motor position
        motors[motor_number].write(angle);
        delay(100); //wait for motor to get there
    }
}

void speakerOutput()
{
    return;
}

void loop() {
  String cmd;
  
  if (Serial.available()) 
  {
    
    cmd = Serial.readString(); //read incoming data
    if(cmd.equals("smc"))
    {
        speakerMotorControl();
    }
    else if(cmd.equals("so"))
    {
        speakerOutput();
    }
    else
    {
        Serial.println("[loop()] not a valid cmd::");
        Serial.println(cmd);
    }
  }
}
