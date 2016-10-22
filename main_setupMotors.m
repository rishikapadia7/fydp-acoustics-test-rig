%this script configures all motors
    %(which is used as index into the motors array on the Arduino)
    %to be associated with a given Arduino PWM pin

%iterate through each motor in Motors of type Motor
for motor = MOTORS
    %send motor number
    serial_write_data(s, motor.id, 'uint8');
    %note: arduino will perform -1 for indexing

    %send pin number
    serial_write_data(s, motor.pwmpin, 'uint8');
end
%now we should be able to reference every motor by it's motor number name

arduinoRetMsg = sprintf('[failure] setupMotors, fgets did not work.');
arduinoRetMsg = fgets(s); %gets either [success] or [failure]
fprintf(arduinoRetMsg);

