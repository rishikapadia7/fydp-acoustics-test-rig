function [ ] = speaker_motor_control( s, motorNumber, angle )
% Turns speaker(s) mounted to motor motorNumber by angle degrees
    % s is a validated serial port object
    %angle specifies position of motor, not degrees to rotate by
    %Calls Arduino in following sequence: smc,motor_number,angle
    
    % validate angle between 0 and 90 degrees
    main_includes;
    try
        if(angle >= 0 && angle <= 90)
            if(DBG <= DBG_INFO)
                fprintf('[speaker_motor_control] angle valid.\n');
            end
        else
            fprintf('[speaker_motor_control] angle %d invalid.\n', angle);
            return;
        end
    catch
        fprintf('[speaker_motor_control] angle not a valid number.\n');
        return;
    end
    
    % validate motorNumber
    try
        if(motorNumber >= 0 && motorNumber < SPEAKER_MOTOR_COUNT)
            if(DBG <= DBG_INFO)
                fprintf('[speaker_motor_control] motorNumber valid.\n');
            end
        else
            fprintf('[speaker_motor_control] motorNumber %d invalid.\n', motorNumber);
            return;
        end
    catch
        fprintf('[speaker_motor_control] motorNumber not a valid number.\n');
        return;
    end
    
    %write smc
    serial_write_line(s,'smc');

    %check response
    fprintf(fgets(s));
    
    %send motorNumber and angle as uint8
    serial_write_data(s,motorNumber,'uint8');
    serial_write_data(s,angle,'uint8');
    
    %check response
    fprintf(fgets(s));
end

