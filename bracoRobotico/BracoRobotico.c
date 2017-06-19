#include "servo.h"

#define BASE 0
#define SHOULDER 1
#define ELBOW 2
#define GRIPPER 3

int parser(char* input, char* commands, int* params, int max);

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
    UART1_Init(57600);
    Delay_ms(200);
    UART1_Write_Text("Start\r\n");

    ServoAttach(BASE, &PORTD, BASE);
    ServoAttach(SHOULDER, &PORTD, SHOULDER);
    ServoAttach(ELBOW, &PORTD, ELBOW);
    ServoAttach(GRIPPER, &PORTD, GRIPPER);

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
                        ServoWrite(BASE, params[i]);
                        UART1_Write_Text("write base\r\n");
                        break;

                    case 'o':
                    case 'O':
                        ServoWrite(SHOULDER, params[i]);
                        UART1_Write_Text("write shoulder\r\n");
                        break;

                    case 'c':
                    case 'C':
                        ServoWrite(ELBOW, params[i]);
                        UART1_Write_Text("write elbow\r\n");
                        break;

                    case 'p':
                    case 'P':
                        ServoWrite(BASE, params[i]);
                        ServoWrite(SHOULDER, params[i]);
                        ServoWrite(ELBOW, params[i]);
                        UART1_Write_Text("write all\r\n");
                        break;

                    case 'g':
                    case 'G':
                        if(params[i])
                            ServoWrite(GRIPPER, 80);
                        else
                            ServoWrite(GRIPPER, 56);

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
