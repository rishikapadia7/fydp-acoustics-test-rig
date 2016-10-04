function [  ] = serial_write_data(s, data, dataformat )
    % Wrapper function which is used to write binary data via serial port
        %s is a valid serial port object
        %data is the data to be transmitted
        %dataformat is the type of data (i.e. 'uint8', etc)
    
        %must have ths pause or connection intermittent!!!
            %turns out reading and writing need breaks from each other!
        %pause(1);
%         while(get(s,'BytesAvailable') > 0)
%         end
%         %busy wait while not idle
%         result = strcmp('idle',get(s,'TransferStatus'));
%         while(~result)
%             result = strcmp('idle',get(s,'TransferStatus'));
%         end
        
        fwrite(s,data,dataformat);
end

