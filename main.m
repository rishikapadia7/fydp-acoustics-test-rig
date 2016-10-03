try
    if(isvalid(s))
        fclose(s);
        delete(s);
    end
catch
end
clear;
main_includes;
%% Establish Serial Connection with Arduino (create and validate)
%NOTE: When a serial connection is stopped and started again
%The arduino resets and re-runs the setup() function.
%thus be careful about loss of state in Arduino
%http://forum.arduino.cc/index.php?topic=42691.0
%Tested on Arduino Duemilanove

main_setupSerial;
% returns: s variable is a validated serial connection object

%write smc
pause(1);
cmd = sprintf('smc');
fprintf(s,cmd);

%check response
pause(1);
arduinoRetMsg = sprintf('[failure] main, fgets did not work.');
arduinoRetMsg = fgets(s); %gets either [success] or [failure]
fprintf(arduinoRetMsg);

%write so
pause(1);
cmd = sprintf('so');
fprintf(s,cmd);

%check response
pause(1);
arduinoRetMsg = sprintf('[failure] main, fgets did not work.');
arduinoRetMsg = fgets(s); %gets either [success] or [failure]
fprintf(arduinoRetMsg);

%write mr
pause(1);
cmd = sprintf('mr');
fprintf(s,cmd);

%check response
pause(1);
arduinoRetMsg = sprintf('[failure] main, fgets did not work.');
arduinoRetMsg = fgets(s); %gets either [success] or [failure]
fprintf(arduinoRetMsg);




%% Close serial connection
fclose(s);
delete(s);
clear;