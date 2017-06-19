#line 1 "C:/Users/mplab.LCA-06/Downloads/Micro/bracoRobotico/BracoRobotico.c"
#line 1 "c:/users/mplab.lca-06/downloads/micro/bracorobotico/servo.h"




typedef struct
{
 char Port;
 char Pino;
 unsigned PWM;
 union
 {
 char Enable:1;
 };
}Servos;


void ServoInit();

void ServoAttach( char servo, char out, char pin );

void ServoWrite(char srv_id, float angle);
#line 8 "C:/Users/mplab.LCA-06/Downloads/Micro/bracoRobotico/BracoRobotico.c"
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

 ServoInit();
 UART1_Init(57600);
 Delay_ms(200);
 UART1_Write_Text("Start\r\n");

 ServoAttach( 0 , &PORTD,  0 );
 ServoAttach( 1 , &PORTD,  1 );
 ServoAttach( 2 , &PORTD,  2 );
 ServoAttach( 3 , &PORTD,  3 );

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
 ServoWrite( 0 , params[i]);
 UART1_Write_Text("write base\r\n");
 break;

 case 'o':
 case 'O':
 ServoWrite( 1 , params[i]);
 UART1_Write_Text("write shoulder\r\n");
 break;

 case 'c':
 case 'C':
 ServoWrite( 2 , params[i]);
 UART1_Write_Text("write elbow\r\n");
 break;

 case 'p':
 case 'P':
 ServoWrite( 0 , params[i]);
 ServoWrite( 1 , params[i]);
 ServoWrite( 2 , params[i]);
 UART1_Write_Text("write all\r\n");
 break;

 case 'g':
 case 'G':
 if(params[i])
 ServoWrite( 3 , 80);
 else
 ServoWrite( 3 , 56);

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
