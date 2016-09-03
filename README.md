# fydp-acoustics-test-rig

## Arduino-MATLAB Serial Interface API
This section describes the MATLAB function prototype,
followed by how it is received at the Arduino side
via serial port.
Note: multi-byte data is sent with LSB first then towards MSB.


### Speaker Motor Control
speakerMotorControl(uint8 motor_number, uint8 angle)

where angle is measured from that motors 0 degree state
and is limited to 90 degrees.

smc,<motor_number>,<angle>


### Speaker Output
speakerOutput(uint8 speaker_number, uint16 output_val)

where output_val is ready for digital to analog conversion.


so,<speaker_number>,<output_val>


### Mic Robot
micRobot(uint16 x, uint16 y, uint16 z)

NOTE: x, y, and z are measured in centimeters relative to origin of acoustic platform.

mr,<x>,<y>,<z>

