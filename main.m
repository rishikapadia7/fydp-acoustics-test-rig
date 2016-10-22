try
    if(isvalid(s))
        fclose(s);
        delete(s);
    end
catch
end
clear;
main_includes;
%% Establish Serial Connection with Arduino (create and validate)
%NOTE: When a serial connection is stopped and started again
%The arduino resets and re-runs the setup() function.
%thus be careful about loss of state in Arduino
%http://forum.arduino.cc/index.php?topic=42691.0
%Tested on Arduino Duemilanove and Arduino Uno R3

main_setupSerial;
% returns: s variable is a validated serial connection object

main_setupMotors;

%% Test continuous servos
rotate_forward(s,MOTOR_X,2000);
rotate_reverse(s,MOTOR_X,1000);


%% Close serial connection
fclose(s);
delete(s);
clear;