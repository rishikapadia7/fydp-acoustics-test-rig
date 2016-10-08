# fydp-acoustics-test-rig

## Arduino-MATLAB Serial Interface API
This section describes the MATLAB function prototype,
followed by how it is received at the Arduino side
via serial port.
Note: multi-byte data is sent with LSB first then towards MSB. (little endian)


### Speaker Motor Control
speaker_motor_control(uint8 motor_number, uint8 angle)

where angle is measured from that motors 0 degree state
and is limited to 90 degrees.

smc,motor_number,angle


### Speaker Output
speaker_output(uint8 speaker_number, uint16 output_val)

where output_val is ready for digital to analog conversion.


so,speaker_number,output_val


### Mic Robot
mic_robot(uint16 x, uint16 y, uint16 z)

NOTE: x, y, and z are measured in centimeters relative to origin of acoustic platform.

mr,x,y,z

## Matlab Naming Conventions Used

function_names_with_parameters, variableNames, sub_moduleNamesOrFunctionsWithoutParameters

## Arduino .ino naming conventions

camelCaseEverything

