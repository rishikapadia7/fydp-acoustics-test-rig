function [ ] = speakerMotorControl( s, motor_number, angle )
%Adjusts the angle of the motor specified by motor_number
    %motor_number must be within <>
    %angle must be within 0 and 180 degrees
    if (motor_number >= 0) && (motor_number < 6)
        if (angle >= 0) && (angle <= 180)
            %smc,uint8,uint8
            fprintf(s,'%s','smc');
            fwrite(s,motor_number,'uint8');
            fwrite(s,angle,'uint8');
        else
            printf('speakerMotorControl angle out of range: %d',angle);
        end
    else
        printf('speakerMotorControl motor_number out of range: %d',motor_number);
    end
end

