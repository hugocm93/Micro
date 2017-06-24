#line 1 "C:/Users/hugocm93/Desktop/Micro/bracoRobotico/BracoRobotico.c"
#line 1 "c:/users/hugocm93/desktop/micro/bracorobotico/servo.h"




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
#line 26 "C:/Users/hugocm93/Desktop/Micro/bracoRobotico/BracoRobotico.c"
typedef struct servo
{
 float min;
 float max;
}Servo;
volatile Servo servos[4] = {{ 0 ,  180 },
 { 45 ,  135 },
 { 45 ,  180 },
 { 56 ,  80 }};


int position = 0;
int stepSize = 0;
float anglesMatrix[ 3 ][3] = {{
 ( 180 - 0 )/2.0 +  0 ,
 ( 135 - 45 )/2.0 +  45 ,
 ( 180 - 45 )/2.0 +  45 
 },
 {
  0 ,
  45 ,
  45 
 },
 {
  180 ,
  135 ,
  180 
 }};


int parser(char* input, char* commands, float* params);
float limitAngle(float angle, int servoId);
void writeFloat(float f);
void writeStr(char* str);

void main()
{

 char uart_rd;
 char input[ 10 *5 ];
 char delimiter[] = "end";


 char commands[ 10 ];
 float params[ 10 ];
 int i, numberOfCommandsRead = 0;


 ADCON1 = 0x06;
 trisd = 0;
 portd = 0;


 ServoInit();
 Delay_ms(200);
 ServoAttach( 0 , &PORTD,  0 );
 ServoAttach( 1 , &PORTD,  1 );
 ServoAttach( 2 , &PORTD,  2 );
 ServoAttach( 3 , &PORTD,  3 );


 ServoWrite( 0 , limitAngle(anglesMatrix[0][ 0 ],  0 ));
 ServoWrite( 1 , limitAngle(anglesMatrix[0][ 1 ],  1 ));
 ServoWrite( 2 , limitAngle(anglesMatrix[0][ 2 ],  2 ));


 UART1_Init(57600);
 Delay_ms(200);
 writeStr("Start:");
 while( 1 )
 {
 if(!UART1_Data_Ready())
 {
 continue;
 }

 UART1_Read_Text(input, delimiter,  255 );
 numberOfCommandsRead = parser(input, commands, params);

 for(i = 0; i < numberOfCommandsRead; i++)
 {
 switch(commands[i])
 {
 case 'b': case 'B':
 ServoWrite( 0 , limitAngle(params[i],  0 ));
 writeStr("write to base");
 break;

 case 'o': case 'O':
 ServoWrite( 1 , limitAngle(params[i],  1 ));
 writeStr("write to shoulder");
 break;

 case 'c': case 'C':
 ServoWrite( 2 , limitAngle(params[i],  2 ));
 writeStr("write to elbow");
 break;

 case 'p': case 'P':
 {
 int pos = (int)params[i] >= 0 && (int)params[i] <  3  ? (int)params[i] : 0;
 ServoWrite( 0 , limitAngle(anglesMatrix[pos][ 0 ],  0 ));
 ServoWrite( 1 , limitAngle(anglesMatrix[pos][ 1 ],  1 ));
 ServoWrite( 2 , limitAngle(anglesMatrix[pos][ 2 ],  2 ));
 writeStr("write position");
 writeFloat(anglesMatrix[pos][ 0 ]);
 writeFloat(anglesMatrix[pos][ 1 ]);
 writeFloat(anglesMatrix[pos][ 2 ]);
 }
 break;

 case 'g': case 'G':
 {
 float gripperAngle = (int)params[i] ? servos[ 3 ].max : servos[ 3 ].min;
 ServoWrite( 3 , gripperAngle);
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

 while (token && i <  10 ){
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
