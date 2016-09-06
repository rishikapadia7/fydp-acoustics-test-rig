#define BAUD_RATE 115200

void setup() {
    // Open serial communications and wait for port to open:
    Serial.begin(BAUD_RATE);
    while (!Serial) {
      ; // wait for serial port to connect.
    }
}

void loop() {
  byte incomingByte1;
  
  if (Serial.available()) {
    //delay(500);
    incomingByte1 = Serial.read(); //read incoming data
    Serial.println(incomingByte1,HEX); //print data
  }
}
