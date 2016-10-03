clear;
main_includes;
%% Establish Serial Connection with Arduino (create and validate)
main_setupSerial;
% returns: s variable is a validated serial connection object

%%TODO: the current serial setup only runs when Arduino is first flashed
%%need to change Arduino code so that it can run at any time




%% Close serial connection
fclose(s);
delete(s);
clear;