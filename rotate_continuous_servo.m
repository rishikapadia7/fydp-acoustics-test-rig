function [ ] = rotate_continuous_servo( s, motorNumber, angleStart, angleStop, duration )
%Calls Arduino in following sequence: 
%<rcs> <motorNumber/ID> <angleStart> <angleStop> <duration>

main_includes;
%% validate function arguments
    % validate motorNumber
    try
        if(motorNumber >= 0 && motorNumber <= PWM_PIN_COUNT)
            if(DBG <= DBG_INFO)
                fprintf('[rotate_continuous_servo] motorNumber valid.\n');
            end
        else
            fprintf('[rotate_continuous_servo] motorNumber %d invalid.\n', motorNumber);
            return;
        end
    catch
        fprintf('[rotate_continuous_servo] motorNumber not a valid number.\n');
        return;
    end
    
    try
        if(angleStart >= 0 && angleStart <=180)
            if(DBG <= DBG_INFO)
                fprintf('[rotate_continuous_servo] angleStart valid.\n');
            end
        else
            fprintf('[rotate_continuous_servo] angleStart %d invalid.\n', angleStart);
            return;
        end
    catch
        fprintf('[rotate_continuous_servo] angleStart not a valid number.\n');
        return;
    end
    
    try
        if(angleStop >= 0 && angleStop <=180)
            if(DBG <= DBG_INFO)
                fprintf('[rotate_continuous_servo] angleStop valid.\n');
            end
        else
            fprintf('[rotate_continuous_servo] angleStop %d invalid.\n', angleStart);
            return;
        end
    catch
        fprintf('[rotate_continuous_servo] angleStop not a valid number.\n');
        return;
    end
    
    try
        if(duration > 0 && duration <=(1000 * 60))
            if(DBG <= DBG_INFO)
                fprintf('[rotate_continuous_servo] duration valid.\n');
            end
        else
            fprintf('[rotate_continuous_servo] duration %d invalid.\n', angleStart);
            return;
        end
    catch
        fprintf('[rotate_continuous_servo] duration not a valid number.\n');
        return;
    end
    
   
%% Send commands to Arduino    
    
    %write smc
    serial_write_line(s,'rcs');

    %check response that we called function
    fprintf(fgets(s));
    
    %send motorNumber and angle as uint8
    serial_write_data(s,motorNumber,'uint8');
    serial_write_data(s,angleStart,'uint8');
    serial_write_data(s,angleStop,'uint8');
    serial_write_data(s,duration,'uint16');
    %see parameters that were received by Arduino
    fprintf(fgets(s));
    
    sleepms(duration);
    
    %check response of success/failure status
    fprintf(fgets(s));
end

