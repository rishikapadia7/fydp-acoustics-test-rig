function [  ] = serial_write_line(s, text)
    % Wrapper function which is used to write text via serial port
        %s is a valid serial port object
        %text is to be transmitted

        %must have ths pause or connection intermittent!!!
            %turns out reading and writing need breaks from each other!
        %pause(1);
        fprintf(s,text);
end

