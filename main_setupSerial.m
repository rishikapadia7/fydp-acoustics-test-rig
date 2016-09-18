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
            s = serial('COM5');
            set(s,'BaudRate',BAUD_RATE);
            fopen(s);
        end
    end
else
    %open first new connection
    s = serial('COM5');
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
% Outputs: {}

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

pause(1);   %must have ths pause or connection intermittent!!!
            %turns out reading and writing need breaks from each other!
fwrite(s,500,'uint16') %write data is 500d == 0x01F4

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
pause(1);
fwrite(s,SERIAL_ACK_VAL,'uint8');

%wait for status message to arrive
while(get(s,'BytesAvailable') < 4)
end

arduinoRetMsg = fgets(s); %gets either [success] or [failure]
fprintf(arduinoRetMsg);
