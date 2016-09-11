function [ ] = speakerOutput( s, speaker_number, val)
%Outputs val to speaker_number
    %val is 16-bit value that will be converted to analog
        %by the DAC attached to microcontroller
    if (speaker_number >= 0) && (speaker_number < 10)
        if (val >= 0) && (val < pow(2,16))
            %so,uint8,uint16
            fprintf(s,'%s','so');
            fwrite(s,speaker_number,'uint8');
            fwrite(s,val,'uint16');
        else
            printf('speakerOutput val out of range: %d',val);
        end
    else
        printf('speakerOutput speaker_number out of range: %d',speaker_number);
    end
end

