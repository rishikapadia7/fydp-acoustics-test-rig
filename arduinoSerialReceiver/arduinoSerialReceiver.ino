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
    incomingByte1 = Serial.read(); //read incoming data
    delay(100);
    Serial.println(incomingByte1,HEX); //print data
  }
}
