#define BAUD_RATE 115200
#define SERIAL_ACK_VAL 6
#define PWM_PIN_COUNT 4

#include <Servo.h>

Servo motors[PWM_PIN_COUNT];

//NOTE: When a serial connection is stopped and started again
//The arduino resets and re-runs the setup() function.

void setup() {
    // Open serial communications and wait for port to open:
    Serial.begin(BAUD_RATE);
    while (!Serial) {
      ; // wait for serial port to connect.
    }

    serialValidation();

    setupMotors();
}

void loop() {
    String cmd;

    waitForSerialReceive();
    
    cmd = Serial.readStringUntil('\n'); //read incoming data
    cmd.trim();

    //determine which command it is
    //note: after calling the subroutine, the arguments are parsed
    if(cmd.equals("ssa"))
    {
        setServoAngle();
    }
    else if(cmd.equals("so"))
    {
        speakerOutput();
    }
    else if(cmd.equals("rcs"))
    {
        rotateContinuousServo();
    }
    else
    {
        Serial.println("[loop()] not a valid cmd = " + cmd);
    }
}

void setServoAngle()
{
    //The next 2 bytes read on the serial interface are:
    //<uint8 motorNumber> <uint8 angle>
    uint8_t motorNumber;
    uint8_t angle;
    
    Serial.println("Called setServoAngle().");

    waitForSerialReceive();
    motorNumber = Serial.read();

    waitForSerialReceive();
    angle = Serial.read();

    //Adjust motor position
    motors[motorNumber].write(angle);
    delay(100); //wait for motor to get there

    Serial.println("motorNumber " + String(motorNumber, DEC) + " angle " + String(angle, DEC));
}

//Rotates the continuous servo motor for the specified duration
void rotateContinuousServo()
{
    //<motorNumber> <angleStart> <angleStop> <duration>
    //NOTE: the angleStart specifies the direction and speed
    //angleStop should be the angle at which the motor is stationary
    //duration is in milliseconds
    Serial.println("Called rotateContinuousServo().");
    uint8_t motorNumber, angleStart, angleStop;
    uint16_t durationByte1, durationByte2, duration; //in milliseconds
    
    //TODO: test properly on duration and time it on both platforms

    waitForSerialReceive();
    motorNumber = Serial.read();

    waitForSerialReceive();
    angleStart = Serial.read();

    waitForSerialReceive();
    angleStop = Serial.read();

    //Get both bytes of duration which was sent as uint16
    waitForSerialReceive();
    durationByte1 = Serial.read();

    waitForSerialReceive();
    durationByte2 = Serial.read();

    //Reconstruct duration (little endian), therefore LSB received first
    duration = durationByte1;
    duration |= (durationByte2 << 8);

    Serial.println("rotateContinuousServo called with motorNumber = " + String(motorNumber, DEC)
        + " angleStart = " + String(angleStart, DEC)
        + " angleStop = " + String(angleStop, DEC)
        + " duration = " + String(duration, DEC)
    );

    //Cause the motor to begin rotation
    motors[motorNumber].write(angleStart);

    //Continue the rotation for duration milliseconds
    delay(duration);

    //Stop the rotation
    motors[motorNumber].write(angleStop);

    Serial.println("[success] rotateContinuousServo.");

}

void speakerOutput()
{
    Serial.println("Called speakerOutput().");
    return;
}



void serialValidation()
{
    //Complete initial handshake with Matlab to indicate send and receive works successfully
    //inital handshake is receiving uint16 of 0x01F4.  Little endian therefore F4 arrives first.
    
    //wait for initial byte of F4 to arrive
    waitForSerialReceive();
    
    byte incomingByte1;
    incomingByte1 = Serial.read(); //read incoming data
    Serial.println(incomingByte1,HEX); //print data

    //wait for second byte of 01 to arrive
    waitForSerialReceive();

    incomingByte1 = Serial.read(); //read incoming data
    Serial.println(incomingByte1,HEX); //print data

    //wait for ack message to arrive as uint8
    waitForSerialReceive();

    incomingByte1 = Serial.read(); //read incoming data
    if(incomingByte1 == SERIAL_ACK_VAL)
    {
        Serial.println("[success] serial validation.");
    }
    else
    {
        Serial.println("[failure] serial validation.");
        Serial.println("Wanted " + String(SERIAL_ACK_VAL, DEC) + ", got: " + String(incomingByte1, DEC));
    }
}

void waitForSerialReceive()
{
    while(!Serial.available())
    {
        ;
    }
}

//This will setup both servos and continuous servos
//The setup for both of these are identical and are motors of the same "Servo" type
//NOTE: first motors are continuous servo motors since they are the least likely to change
void setupMotors()
{
    uint8_t motorNumber, pinNumber;

    //i is not used in the loop
    for(int i = 0; i < PWM_PIN_COUNT; i++)
    {
        //Retrieve the motor number and which pin it is using
        //wait for motor number
        waitForSerialReceive();
        motorNumber = Serial.read();
        
        waitForSerialReceive();
        pinNumber = Serial.read();

        motors[motorNumber].attach(pinNumber);
    }

    Serial.println("[success] setupMotors.");
}