function [ ] = set_servo_angle( s, motorNumber, angle )
% Turns servo motor motorNumber by angle degrees
    % s is a validated serial port object
    %angle specifies position of motor, not degrees to rotate by
    %Calls Arduino in following sequence: smc,motor_number,angle
    
    % validate angle between 0 and 90 degrees
    main_includes;
    try
        if(angle >= 0 && angle <= 90)
            if(DBG <= DBG_INFO)
                fprintf('[set_servo_angle] angle valid.\n');
            end
        else
            fprintf('[set_servo_angle] angle %d invalid.\n', angle);
            return;
        end
    catch
        fprintf('[set_servo_angle] angle not a valid number.\n');
        return;
    end
    
    % validate motorNumber
    try
        if(motorNumber >= 1 && motorNumber <= PWM_PIN_COUNT)
            if(DBG <= DBG_INFO)
                fprintf('[set_servo_angle] motorNumber valid.\n');
            end
        else
            fprintf('[set_servo_angle] motorNumber %d invalid.\n', motorNumber);
            return;
        end
    catch
        fprintf('[set_servo_angle] motorNumber not a valid number.\n');
        return;
    end
    
    %write smc
    serial_write_line(s,'ssa');

    %check response
    fprintf(fgets(s));
    
    %send motorNumber and angle as uint8
    serial_write_data(s,motorNumber,'uint8');
    serial_write_data(s,angle,'uint8');
    
    %check response
    fprintf(fgets(s));
end

