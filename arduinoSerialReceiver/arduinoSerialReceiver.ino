#define BAUD_RATE 115200
#define SERIAL_ACK_VAL 6

void setup() {
    // Open serial communications and wait for port to open:
    Serial.begin(BAUD_RATE);
    while (!Serial) {
      ; // wait for serial port to connect.
    }

    serialValidation();
}

void loop() {
    delay(1000);
    Serial.println("got to main loop().\n");
}

void serialValidation()
{
    //Complete initial handshake with Matlab to indicate send and receive works successfully
    //inital handshake is receiving uint16 of 0x01F4.  Little endian therefore F4 arrives first.
    while(!Serial.available())
    {
        ; //wait for initial byte of F4 to arrive
    }
    
    byte incomingByte1;
    incomingByte1 = Serial.read(); //read incoming data
    Serial.println(incomingByte1,HEX); //print data

    //Wait for byte 2
    while(!Serial.available())
    {
        ; //wait for second byte of 01 to arrive
    }

    if (Serial.available()) {
        incomingByte1 = Serial.read(); //read incoming data
        Serial.println(incomingByte1,HEX); //print data
    }

    //Wait for ack message
    while(!Serial.available())
    {
        ; //wait for ack message to arrive as uint8
    }

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