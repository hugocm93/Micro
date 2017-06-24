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

typedef struct servo
{ 
    float min;
    float max;
}Servo;

volatile Servo servos[4] = {{BASE_MIN, BASE_MAX},
                            {SHOULDER_MIN, SHOULDER_MAX},
                            {ELBOW_MIN, ELBOW_MAX},
                            {GRIPPER_MIN, GRIPPER_MAX}};

int parser(char* input, char* commands, float* params);

float limitAngle(float angle, int servoId);

void writeFloat(float f);

void writeStr(char* str);

void main() 
{
    char uart_rd;
    char input[INPUT_SIZE];
    char delimiter[] = "end";

    //Vars do while
    char commands[MAX_COMMANDS];
    float params[MAX_COMMANDS];
    int i, numberOfCommandsRead = 0;

    ADCON1 = 0x06;
    trisd = 0;
    portd = 0;

    ServoInit(); 
    Delay_ms(200);
    UART1_Init(57600);
    Delay_ms(200);
    writeStr("Start:");

    ServoAttach(BASE, &PORTD, BASE);
    ServoAttach(SHOULDER, &PORTD, SHOULDER);
    ServoAttach(ELBOW, &PORTD, ELBOW);
    ServoAttach(GRIPPER, &PORTD, GRIPPER);

    //Quando o programa iniciar, mover para a Posição 0.
    //O que eh a posicao zero??

    ServoWrite(BASE, limitAngle(58, BASE));
    ServoWrite(SHOULDER, limitAngle(72, SHOULDER));
    ServoWrite(ELBOW, limitAngle(50, ELBOW));
    ServoWrite(GRIPPER, limitAngle(56, GRIPPER));

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
                    ServoWrite(BASE, limitAngle(params[i], BASE));
                    ServoWrite(SHOULDER, limitAngle(params[i], SHOULDER));
                    ServoWrite(ELBOW, limitAngle(params[i], ELBOW));
                    writeStr("write to all");
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
