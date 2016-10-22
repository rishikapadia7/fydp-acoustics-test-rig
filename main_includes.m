%Since no header files in matlab, this will essentially serve for constants and hardware configurations
COM_PORT = 'COM3';
USING_DUE = 0; %Currently using arduino due?

%% Manually synchronize these with Arduino code
BAUD_RATE = 115200;
SERIAL_ACK_VAL = 6;
PWM_PIN_COUNT = 4;

%% Debug level printing

%Define print statement debug levels
DBG_INFO = 0;
DBG_WARNING = DBG_INFO + 1;
DBG_ERROR = DBG_WARNING + 1;

%Choose current debug level
DBG = DBG_INFO;

%% Hardware configurations and pin mappings

%Indicate which PWM pin to use for each motor
%NOTE: Matlab is 1-indexed and Arduino subtracts 1 from received motor number

%continuous servos
MOTOR_X = Motor();
MOTOR_X.id = 0;
MOTOR_X.pwmpin = 11;
MOTOR_X.angleforward = 0;
MOTOR_X.anglestop = 90;
MOTOR_X.anglereverse = 180;

MOTOR_Y = Motor();
MOTOR_Y.id = 1;
MOTOR_Y.pwmpin = 10;
MOTOR_Y.angleforward = 0;
MOTOR_Y.anglestop = 95;
MOTOR_Y.anglereverse = 180;


%TODO: Add Speed of continuous servos in millimeter per second


%regular 180 degree limited servos
MOTOR_SERVO_LEFT = Motor();
MOTOR_SERVO_LEFT.id = 3;
MOTOR_SERVO_LEFT.pwmpin = 9;

MOTOR_SERVO_RIGHT = Motor();
MOTOR_SERVO_RIGHT.id = 3;
MOTOR_SERVO_RIGHT.pwmpin = 9;

MOTORS = [MOTOR_X, MOTOR_Y, MOTOR_SERVO_LEFT, MOTOR_SERVO_RIGHT];

assert(PWM_PIN_COUNT == length(MOTORS));

