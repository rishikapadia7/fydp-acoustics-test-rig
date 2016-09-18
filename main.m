clear;
main_includes;
%% Establish Serial Connection with Arduino (create and validate)
main_setupSerial;
% returns: s variable is a validated serial connection object



%% Close serial connection
%% fclose(s);
%% delete(s);
%% clear;