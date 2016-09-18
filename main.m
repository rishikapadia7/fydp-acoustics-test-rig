%% Establish Serial Connection with Arduino
s = serial('COM5');
set(s,'BaudRate',115200);
fopen(s);

%% Send to arduino
readData=fscanf(s); %reads "Ready" signal from Arduino 
% writedata=uint16(500); %0x01F4
% fwrite(s,writedata,'uint16') %write data
% 
%  for i=1:2 %read 2 lines of data
%     readData=fscanf(s); %first iteration is F4, second is 1 (little endian)
%  end
for i = 1:10
    speakerMotorControl(s,0,20);
    pause(1); % wait 1 second
    speakerMotorControl(s,0,60);
    pause(1); % wait 1 second
end
%% Close serial connection
 fclose(s);
 delete(s);