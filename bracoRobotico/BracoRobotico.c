#define PARTE2

#ifdef PARTE2

#include "meArm.h"
#define ARM_ID 6
#include "armData.h"

#else 

#include "servo.h"

#endif


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

#define MAX_COMMANDS 20
#define TRUE 1
#define INPUT_SIZE MAX_COMMANDS*5 
#define ATTEMPTS 255
#define NUMBER_OF_STEPS 10
#define POSITIONS 6
#define STEP_DELAY 50

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

#ifdef PARTE2
float xyzMatrix[POSITIONS][3] = {{0, 150, -35}, {90, 150, -35}, {-90, 150, -35},
                                 {0, 150, 20}, {90, 150, 20}, {-90, 150, 20}};
#else
//Posicoes pre-definidas
typedef struct angleIterator
{
    float beginAngle;
    float stepSize;
}AngleIterator;
AngleIterator it[3] = {{(BASE_MAX-BASE_MIN)/2.0 + BASE_MIN, 0},
                       {(SHOULDER_MAX-SHOULDER_MIN)/2.0 + SHOULDER_MIN, 0},
                       {(ELBOW_MAX-ELBOW_MIN)/2.0 + ELBOW_MIN, 0}};
float anglesMatrix[POSITIONS][3] = {{135, 80, 180},
                                    {45, 140, 100},
                                    {BASE_MAX, SHOULDER_MAX, ELBOW_MAX}};
#endif

//Metodos auxiliares
int parser(char* input, char* commands, float* params);
float limitAngle(float angle, int servoId);
void writeFloat(float f);
void writeStr(char* str);
void setServosPosition(int position);
void setServoAngle(int id, float angle);

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

#ifdef PARTE2
    meArm_calib(armData);
    meArm_begin(&PORTD, BASE, SHOULDER, ELBOW, GRIPPER);

    //Quando o programa iniciar, mover para a Posição 0, sem iteracao
    meArm_goDirectlyTo(xyzMatrix[3][0],xyzMatrix[3][1],xyzMatrix[3][2]);
#else 
    //Servo
    ServoInit(); 
    Delay_ms(200);
    ServoAttach(BASE, &PORTD, BASE);
    ServoAttach(SHOULDER, &PORTD, SHOULDER);
    ServoAttach(ELBOW, &PORTD, ELBOW);
    ServoAttach(GRIPPER, &PORTD, GRIPPER);

    //Quando o programa iniciar, mover para a Posição 0, sem iteracao
    setServoAngle(BASE, anglesMatrix[0][BASE]);
    setServoAngle(SHOULDER, anglesMatrix[0][SHOULDER]);
    setServoAngle(ELBOW, anglesMatrix[0][ELBOW]);
#endif

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
                    setServoAngle(BASE, params[i]);
                    writeStr("write to base");
                    break;

                case 'o': case 'O':
                    setServoAngle(SHOULDER, params[i]);
                    writeStr("write to shoulder");
                    break;

                case 'c': case 'C':
                    setServoAngle(ELBOW, params[i]);
                    writeStr("write to elbow");
                    break;

                case 'p': case 'P':
                {
                    int pos = (params[i] >= 0 && params[i] < POSITIONS) ? (int)params[i] : 0;
                    writeStr("begin moving to position");
                    setServosPosition(pos);
                    writeStr("end moving to position");
                }
                    break;

                case 'g': case 'G':
                {
#ifdef PARTE2
                    if((int)params[i])
                        meArm_openGripper();
                    else
                        meArm_closeGripper();
#else
                    float gripperAngle = (int)params[i] ? servos[GRIPPER].max : servos[GRIPPER].min;
                    setServoAngle(GRIPPER, gripperAngle);
#endif
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


void setServosPosition(int pos)
{
#ifdef PARTE2
    meArm_gotoPoint(xyzMatrix[pos][0],xyzMatrix[pos][1],xyzMatrix[pos][2]);
#else
    int i;

    it[BASE].stepSize = (anglesMatrix[pos][BASE] - it[BASE].beginAngle) / NUMBER_OF_STEPS; 
    it[SHOULDER].stepSize = (anglesMatrix[pos][SHOULDER] - it[SHOULDER].beginAngle) / NUMBER_OF_STEPS; 
    it[ELBOW].stepSize = (anglesMatrix[pos][ELBOW] - it[ELBOW].beginAngle) / NUMBER_OF_STEPS; 

    for(i = 1; i <= NUMBER_OF_STEPS; i++)
    {
        ServoWrite(BASE, limitAngle(it[BASE].beginAngle + i*it[BASE].stepSize, BASE));
        ServoWrite(SHOULDER, limitAngle(it[SHOULDER].beginAngle + i*it[SHOULDER].stepSize, SHOULDER));
        ServoWrite(ELBOW, limitAngle(it[ELBOW].beginAngle + i*it[ELBOW].stepSize, ELBOW));

        Delay_ms(STEP_DELAY);
    }

    it[BASE].beginAngle = it[BASE].beginAngle + NUMBER_OF_STEPS*it[BASE].stepSize;
    it[SHOULDER].beginAngle = it[SHOULDER].beginAngle + NUMBER_OF_STEPS*it[SHOULDER].stepSize;
    it[ELBOW].beginAngle = it[ELBOW].beginAngle + NUMBER_OF_STEPS*it[ELBOW].stepSize;
#endif
}


void setServoAngle(int id, float angle)
{
#ifdef PARTE2
    meArm_servo((char)id, limitAngle(angle, id));
#else
    ServoWrite(id, limitAngle(angle, id));
#endif
}