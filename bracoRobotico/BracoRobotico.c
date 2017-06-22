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
#define ELBOW_MIN -45
#define ELBOW_MAX 180
#define GRIPPER_MIN 56
#define GRIPPER_MAX 80

typedef struct servo
{ 
    float min;
    float max;
}Servo;

volatile Servo servos[4] = {{BASE_MIN, BASE_MAX},
                            {SHOULDER_MIN, SHOULDER_MAX},
                            {ELBOW_MIN, ELBOW_MAX},
                            {GRIPPER_MIN, GRIPPER_MAX}};

int parser(char* input, char* commands, int* params, int max);

float limitAngle(float angle, int servoId);

void main() 
{
    char uart_rd;
    char output[40];
    char delimiter[] = "end";
    char attempts = 255;
    int param = 0;

    ADCON1 = 0x06;
    trisd = 0;
    portd = 0;

    ServoInit(); //Inicializa Servo
    Delay_ms(200);
    UART1_Init(57600);
    Delay_ms(200);
    UART1_Write_Text("Start:\r\n");

    ServoAttach(BASE, &PORTD, BASE);
    ServoAttach(SHOULDER, &PORTD, SHOULDER);
    ServoAttach(ELBOW, &PORTD, ELBOW);
    ServoAttach(GRIPPER, &PORTD, GRIPPER);

    ServoWrite(BASE, limitAngle(58, BASE));
    ServoWrite(SHOULDER, limitAngle(72, SHOULDER));
    ServoWrite(ELBOW, limitAngle(-20, ELBOW));
    ServoWrite(GRIPPER, limitAngle(56, GRIPPER));

    while(1)
    {
        if(UART1_Data_Ready())
        {
            char commands[80];
            char params[80];
            int i, max = 80;
            
            UART1_Read_Text(output, delimiter, attempts);
            max = parser(output, commands, params, max);

            for(i = 0; i < max; i++)
            {
                switch(commands[i])
                {
                    case 'b':
                    case 'B':
                        ServoWrite(BASE, limitAngle(params[i], BASE));
                        UART1_Write_Text("write base\r\n");
                        break;

                    case 'o':
                    case 'O':
                        ServoWrite(SHOULDER, limitAngle(params[i], SHOULDER));
                        UART1_Write_Text("write shoulder\r\n");
                        break;

                    case 'c':
                    case 'C':
                        ServoWrite(ELBOW, limitAngle(params[i], ELBOW));
                        UART1_Write_Text("write elbow\r\n");
                        break;

                    case 'p':
                    case 'P':
                        ServoWrite(BASE, limitAngle(params[i], BASE));
                        ServoWrite(SHOULDER, limitAngle(params[i], SHOULDER));
                        ServoWrite(ELBOW, limitAngle(params[i], ELBOW));
                        UART1_Write_Text("write all\r\n");
                        break;

                    case 'g':
                    case 'G':
                        if(params[i])
                            ServoWrite(GRIPPER, servos[GRIPPER].max);
                        else
                            ServoWrite(GRIPPER, servos[GRIPPER].min);

                        UART1_Write_Text("write gripper\r\n");
                        break;
                }
            }
        }
    }
}


int parser(char* input, char* commands, int* params, int max)
{
    int i = 0;
    char* token = strtok (input, ";");

    while (token && i < max){
        commands[i] = token[1];
        params[i++] = atoi(&token[2]);
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
