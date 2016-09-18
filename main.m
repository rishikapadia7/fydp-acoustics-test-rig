%% Establish Serial Connection with Arduino
clear;

% See if there is an open COM connection already
coms = instrfind;
if length(coms) > 0
    for i = 1:length(coms)
        if (strcmp(coms(i).status,'open'))
            s = coms(i);
            break;
        end
        %otherwise open a new connection
        if (i == length(coms))
            s = serial('COM5');
            set(s,'BaudRate',115200);
            fopen(s);
        end
    end
end
set(s,'Timeout',1); %read/write timeout in seconds

%stopasync(s);
%serialbreak(s); %ensures hardware is ready to go for communication
set(s,'ReadAsyncMode','continuous');
set(s,'Terminator','LF');
pause(1); %wait for initialization

if(isvalid(s))
    %fprintf('%s', 's is valid');
else
    fprintf('%s', 's invalid');
end


%% Send to arduino

%clear pending input bytes
readbytes = get(s,'BytesAvailable');
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
    fprintf('%s',readData);
 end

%% Close serial connection
 fclose(s);
 delete(s);
 clear;