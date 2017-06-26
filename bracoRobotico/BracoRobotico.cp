#line 1 "C:/Users/mplab.LCA-06/Downloads/Micro/bracoRobotico/BracoRobotico.c"
#line 1 "c:/users/mplab.lca-06/downloads/micro/bracorobotico/mearm.h"
#line 19 "c:/users/mplab.lca-06/downloads/micro/bracorobotico/mearm.h"
typedef struct ServoInfo {
 int n_min, n_max;
 float gain;
 float zero;
 int id;
} ServoInfo;


 void meArm_calib(char *calib);

 void meArm_begin(char portAddr, int pinBase, int pinShoulder, int pinElbow, int pinGripper);

 void meArm_gotoPoint(float x, float y, float z);

 void meArm_goDirectlyTo(float x, float y, float z);


 void meArm_gotoPointCylinder(float theta, float r, float z);
 void meArm_goDirectlyToCylinder(float theta, float r, float z);


 void meArm_openGripper();

 void meArm_closeGripper();

 int meArm_isReachable(float x, float y, float z);


 void meArm_servo(char id, float angle);
#line 1 "c:/users/mplab.lca-06/downloads/micro/bracorobotico/armdata.h"
#line 122 "c:/users/mplab.lca-06/downloads/micro/bracorobotico/armdata.h"
char armData[8]={ 180 , 8 ,
  120 , 35 ,
  180 , 140 ,
  80 , 56 };
#line 40 "C:/Users/mplab.LCA-06/Downloads/Micro/bracoRobotico/BracoRobotico.c"
typedef struct servo
{
 float min;
 float max;
}Servo;
volatile Servo servos[4] = {{ 0 ,  180 },
 { 45 ,  135 },
 { 45 ,  180 },
 { 56 ,  80 }};


float xyzMatrix[ 6 ][3] = {{0, 150, -35}, {90, 150, -35}, {-90, 150, -35},
 {0, 150, 20}, {90, 150, 20}, {-90, 150, 20}};
#line 69 "C:/Users/mplab.LCA-06/Downloads/Micro/bracoRobotico/BracoRobotico.c"
int parser(char* input, char* commands, float* params);
float limitAngle(float angle, int servoId);
void writeFloat(float f);
void writeStr(char* str);
void setServosPosition(int position);
void setServoAngle(int id, float angle);

void main()
{

 char uart_rd;
 char input[ 20 *5 ];
 char delimiter[] = "end";


 char commands[ 20 ];
 float params[ 20 ];
 int i, numberOfCommandsRead = 0;


 ADCON1 = 0x06;
 trisd = 0;
 portd = 0;


 meArm_calib(armData);
 meArm_begin(&PORTD,  0 ,  1 ,  2 ,  3 );


 meArm_goDirectlyTo(xyzMatrix[3][0],xyzMatrix[3][1],xyzMatrix[3][2]);
#line 115 "C:/Users/mplab.LCA-06/Downloads/Micro/bracoRobotico/BracoRobotico.c"
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
 setServoAngle( 0 , params[i]);
 writeStr("write to base");
 break;

 case 'o': case 'O':
 setServoAngle( 1 , params[i]);
 writeStr("write to shoulder");
 break;

 case 'c': case 'C':
 setServoAngle( 2 , params[i]);
 writeStr("write to elbow");
 break;

 case 'p': case 'P':
 {
 int pos = (params[i] >= 0 && params[i] <  6 ) ? (int)params[i] : 0;
 writeStr("begin moving to position");
 setServosPosition(pos);
 writeStr("end moving to position");
 }
 break;

 case 'g': case 'G':
 {

 if((int)params[i])
 meArm_openGripper();
 else
 meArm_closeGripper();
#line 167 "C:/Users/mplab.LCA-06/Downloads/Micro/bracoRobotico/BracoRobotico.c"
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

 while (token && i <  20 ){
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


void setServosPosition(int pos)
{

 meArm_gotoPoint(xyzMatrix[pos][0],xyzMatrix[pos][1],xyzMatrix[pos][2]);
#line 247 "C:/Users/mplab.LCA-06/Downloads/Micro/bracoRobotico/BracoRobotico.c"
}


void setServoAngle(int id, float angle)
{

 meArm_servo((char)id, limitAngle(angle, id));
#line 257 "C:/Users/mplab.LCA-06/Downloads/Micro/bracoRobotico/BracoRobotico.c"
}
