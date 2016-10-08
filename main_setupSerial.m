%this script initializes s to be the serial object used for connecting
%to the Arduino.  Useful output variable is s.

% See if there is an open COM connection already
coms = instrfind;
if length(coms) > 0
    for i = 1:length(coms)
        if (strcmp(coms(i).status,'open'))
            s = coms(i);
            break;
        end
        %all connections are closed, open new one
        if (i == length(coms))
            s = serial(COM_PORT);
            set(s,'BaudRate',BAUD_RATE);
            fopen(s);
        end
    end
else
    %open first new connection
    s = serial(COM_PORT);
    set(s,'BaudRate',115200);
    fopen(s);
end
set(s,'Timeout',1); %read/write timeout in seconds

set(s,'ReadAsyncMode','continuous');
set(s,'Terminator','LF');
pause(1); %wait for initialization

if(isvalid(s))
    %fprintf('%s', 's is valid');
else
    fprintf('%s', 's invalid');
    exit;
end

fprintf('[success] serial setup.\n');
%% validates both send and receive using serial object s.
% Requires: s
% Outputs: s (unchanged which has been validated}

%clear pending input bytes
readbytes = get(s,'BytesAvailable');
if(readbytes > 100)
    fprintf('Warning, BytesAvailable=%d', readbytes);
end
while (readbytes > 0)
    readData=fscanf(s); %reads "Ready" signal from Arduino if available
    %fprintf('clearing buffer, got %d', readData);
    readbytes = get(s,'BytesAvailable');
end

%must have ths pause (only right here) or connection intermittent!!!
pause(1);
serial_write_data(s,500,'uint16'); %write data is 500d == 0x01F4

for i=1:2 %read 2 lines of data
    readData=fscanf(s); %first iteration is F4, second is 1 (little endian)
    %fprintf('%s',readData);
    readData = {readData};    
    if(i == 1)
        compString = 'F4';
    else
        compString = '1';
    end
    %hacky way to ensure readData contains the comparison string
    validatestring(compString,readData);
end

% Let Arduino know that validation has completed successfully.
serial_write_data(s,SERIAL_ACK_VAL,'uint8');

%wait for status message to arrive
while(get(s,'BytesAvailable') < 4)
end

arduinoRetMsg = sprintf('[failure] serial validation, fgets did not work.');
arduinoRetMsg = fgets(s); %gets either [success] or [failure]
fprintf(arduinoRetMsg);

%see if there is any other trailing debug info
if(get(s,'BytesAvailable') > 0)
    arduinoRetMsg = fgets(s);
    fprintf(arduinoRetMsg);
end
