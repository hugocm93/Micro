#line 1 "C:/Users/aula/Downloads/Micro/bracoRobotico/BracoRobotico.c"
#line 1 "c:/users/aula/downloads/micro/bracorobotico/servo.h"




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
#line 18 "C:/Users/aula/Downloads/Micro/bracoRobotico/BracoRobotico.c"
typedef struct servo
{
 float min;
 float max;
}Servo;

volatile Servo servos[4] = {{ 0 ,  180 },
 { 45 ,  135 },
 { -45 ,  180 },
 { 56 ,  80 }};

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

 ServoInit();
 Delay_ms(200);
 UART1_Init(57600);
 Delay_ms(200);
 UART1_Write_Text("Start:\r\n");

 ServoAttach( 0 , &PORTD,  0 );
 ServoAttach( 1 , &PORTD,  1 );
 ServoAttach( 2 , &PORTD,  2 );
 ServoAttach( 3 , &PORTD,  3 );

 ServoWrite( 0 , limitAngle(58,  0 ));
 ServoWrite( 1 , limitAngle(72,  1 ));
 ServoWrite( 2 , limitAngle(-20,  2 ));
 ServoWrite( 3 , limitAngle(56,  3 ));

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
 ServoWrite( 0 , limitAngle(params[i],  0 ));
 UART1_Write_Text("write base\r\n");
 break;

 case 'o':
 case 'O':
 ServoWrite( 1 , limitAngle(params[i],  1 ));
 UART1_Write_Text("write shoulder\r\n");
 break;

 case 'c':
 case 'C':
 ServoWrite( 2 , limitAngle(params[i],  2 ));
 UART1_Write_Text("write elbow\r\n");
 break;

 case 'p':
 case 'P':
 ServoWrite( 0 , limitAngle(params[i],  0 ));
 ServoWrite( 1 , limitAngle(params[i],  1 ));
 ServoWrite( 2 , limitAngle(params[i],  2 ));
 UART1_Write_Text("write all\r\n");
 break;

 case 'g':
 case 'G':
 if(params[i])
 ServoWrite( 3 , servos[ 3 ].max);
 else
 ServoWrite( 3 , servos[ 3 ].min);

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
