%Since no header files in matlab, this will essentially serve for constants
BAUD_RATE = 115200;
SERIAL_ACK_VAL = 6;

%Define print statement debug levels
DBG_INFO = 0;
DBG_WARNING = DBG_INFO + 1;
DBG_ERROR = DBG_WARNING + 1;


%Choose current debug level
DBG = DBG_INFO;

SPEAKER_MOTOR_COUNT = 1;