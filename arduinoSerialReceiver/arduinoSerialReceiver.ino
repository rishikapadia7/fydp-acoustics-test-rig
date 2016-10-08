#define BAUD_RATE 115200
#define SERIAL_ACK_VAL 6

#define MOTOR_PIN_OFFSET 9 //what pin on Arduino corresponds to motor 0
#define MOTOR_COUNT 1

#include <Servo.h>

Servo motors[MOTOR_COUNT];

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
    if(cmd.equals("smc"))
    {
        speakerMotorControl();
    }
    else if(cmd.equals("so"))
    {
        speakerOutput();
    }
    else if(cmd.equals("mr"))
    {
        micRobot();
    }
    else
    {
        Serial.println("[loop()] not a valid cmd = " + cmd);
    }
}

void speakerMotorControl()
{
    //The next 2 bytes read on the serial interface are:
    //<uint8 motorNumber> <uint8 angle>
    uint8_t motorNumber;
    uint8_t angle;
    
    Serial.println("Called speakerMotorControl().");

    waitForSerialReceive();
    motorNumber = Serial.read();

    waitForSerialReceive();
    angle = Serial.read();

    //Adjust motor position
    motors[motorNumber].write(angle);
    delay(100); //wait for motor to get there

    Serial.println("motorNumber " + String(motorNumber, DEC) + " angle " + String(angle, DEC));
}

void speakerOutput()
{
    Serial.println("Called speakerOutput().");
    return;
}

void micRobot()
{
    Serial.println("Called micRobot().");
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

    if (Serial.available()) {
        incomingByte1 = Serial.read(); //read incoming data
        Serial.println(incomingByte1,HEX); //print data
    }

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

void setupMotors()
{
    //Setup (servo) motors on their corresponding pins
    for(int i = 0; i < MOTOR_COUNT; i++)
    {
        motors[i].attach(i + MOTOR_PIN_OFFSET);
    }
}