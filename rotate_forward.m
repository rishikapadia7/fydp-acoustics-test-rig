function [ ] = rotate_forward( s, motor, duration )
%s is a serial object
%motor is a motor object
%duration is in milliseconds
    rotate_continuous_servo(s,motor.id,motor.angleforward,motor.anglestop,duration);
end