%Since no header files in matlab, this will essentially serve for constants
BAUD_RATE = 115200;
SERIAL_ACK_VAL = 6;

%Define print statement debug levels
DBG_ALL = 0;
DBG_INFO = DBG_ALL + 1;
DBG_WARNING = DBG_INFO + 1;
DBG_ERROR = DBG_WARNING + 1;


%Choose current debug level
DBG = DBG_ALL;
