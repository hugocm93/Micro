#include "servo.h"

// Não mudar a ordem!
#define BASE 0
#define SHOULDER 1
#define ELBOW 2
#define GRIPPER 3

#define BASE_MIN 0
#define BASE_MAX 180
#define SHOULDER_MIN 45
#define SHOULDER_MAX 135
#define ELBOW_MIN 45
#define ELBOW_MAX 180
#define GRIPPER_MIN 56
#define GRIPPER_MAX 80

#define MAX_COMMANDS 10 
#define TRUE 1
#define INPUT_SIZE MAX_COMMANDS*5 
#define ATTEMPTS 255
#define NUMBER_OF_STEPS 10
#define POSITIONS 3

// Controle de min e max
typedef struct servo
{ 
    float min;
    float max;
}Servo;
volatile Servo servos[4] = {{BASE_MIN, BASE_MAX},
                            {SHOULDER_MIN, SHOULDER_MAX},
                            {ELBOW_MIN, ELBOW_MAX},
                            {GRIPPER_MIN, GRIPPER_MAX}};

//Posicoes pre-definidas
int position = 0;
int stepSize = 0;
float anglesMatrix[POSITIONS][3] = {{
                                        (BASE_MAX-BASE_MIN)/2.0 + BASE_MIN,
                                        (SHOULDER_MAX-SHOULDER_MIN)/2.0 + SHOULDER_MIN,
                                        (ELBOW_MAX-ELBOW_MIN)/2.0 + ELBOW_MIN
                                    },
                                    {
                                        BASE_MIN,
                                        SHOULDER_MIN,
                                        ELBOW_MIN
                                    },
                                    {
                                        BASE_MAX,
                                        SHOULDER_MAX,
                                        ELBOW_MAX
                                    }};

//Metodos auxiliares
int parser(char* input, char* commands, float* params);
float limitAngle(float angle, int servoId);
void writeFloat(float f);
void writeStr(char* str);

void main() 
{
    // Vars do serial
    char uart_rd;
    char input[INPUT_SIZE];
    char delimiter[] = "end";

    //Vars do while
    char commands[MAX_COMMANDS];
    float params[MAX_COMMANDS];
    int i, numberOfCommandsRead = 0;

    // Configuracao de portas
    ADCON1 = 0x06;
    trisd = 0;
    portd = 0;

    //Servo
    ServoInit(); 
    Delay_ms(200);
    ServoAttach(BASE, &PORTD, BASE);
    ServoAttach(SHOULDER, &PORTD, SHOULDER);
    ServoAttach(ELBOW, &PORTD, ELBOW);
    ServoAttach(GRIPPER, &PORTD, GRIPPER);

    //Quando o programa iniciar, mover para a Posição 0.
    ServoWrite(BASE, limitAngle(anglesMatrix[0][BASE], BASE));
    ServoWrite(SHOULDER, limitAngle(anglesMatrix[0][SHOULDER], SHOULDER));
    ServoWrite(ELBOW, limitAngle(anglesMatrix[0][ELBOW], ELBOW));

    //Serial
    UART1_Init(57600);
    Delay_ms(200);
    writeStr("Start:");
    while(TRUE)
    {
        if(!UART1_Data_Ready())
        {
            continue;
        }
        
        UART1_Read_Text(input, delimiter, ATTEMPTS);
        numberOfCommandsRead = parser(input, commands, params);

        for(i = 0; i < numberOfCommandsRead; i++)
        {
            switch(commands[i])
            {
                case 'b': case 'B':
                    ServoWrite(BASE, limitAngle(params[i], BASE));
                    writeStr("write to base");
                    break;

                case 'o': case 'O':
                    ServoWrite(SHOULDER, limitAngle(params[i], SHOULDER));
                    writeStr("write to shoulder");
                    break;

                case 'c': case 'C':
                    ServoWrite(ELBOW, limitAngle(params[i], ELBOW));
                    writeStr("write to elbow");
                    break;

                case 'p': case 'P':
                {
                    int pos = (int)params[i] >= 0 && (int)params[i] < POSITIONS ? (int)params[i] : 0;
                    ServoWrite(BASE, limitAngle(anglesMatrix[pos][BASE], BASE));
                    ServoWrite(SHOULDER, limitAngle(anglesMatrix[pos][SHOULDER], SHOULDER));
                    ServoWrite(ELBOW, limitAngle(anglesMatrix[pos][ELBOW], ELBOW));
                    writeStr("write position");
                }
                    break;

                case 'g': case 'G':
                {
                    float gripperAngle = (int)params[i] ? servos[GRIPPER].max : servos[GRIPPER].min;
                    ServoWrite(GRIPPER, gripperAngle);
                    writeStr("write to gripper");
                }
                    break;

                default:
                    writeStr("");

            }
        }
    }
}


int parser(char* input, char* commands, float* params)
{
    int i = 0;
    char* token = strtok (input, ";");

    while (token && i < MAX_COMMANDS){
        commands[i] = token[1];
        params[i++] = atof(&token[2]);
        token = strtok (0, ";"); 
    }

    return i;
}


float limitAngle(float angle, int id)
{
    if(angle > servos[id].max)
        return servos[id].max;
    else if(angle < servos[id].min)
        return servos[id].min;
    return angle;
}


void writeFloat(float f)
{
    char str[20];
    FloatToStr(f, str);
    UART1_Write_Text("\r\n");
    UART1_Write_Text(str);
    UART1_Write_Text("\r\n");
}


void writeStr(char* str)
{
    UART1_Write_Text("\r\n");
    UART1_Write_Text(str);
    UART1_Write_Text("\r\n");
}
