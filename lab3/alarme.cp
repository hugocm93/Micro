#line 1 "C:/Users/hugocm93/Desktop/Micro/lab3/alarme.c"




sbit LCD_EN at RE1_bit;
sbit LCD_RS at RE2_bit;
sbit LCD_D0 at RD0_bit;
sbit LCD_D1 at RD1_bit;
sbit LCD_D2 at RD2_bit;
sbit LCD_D3 at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_EN_Direction at TRISE1_bit;
sbit LCD_RS_Direction at TRISE2_bit;
sbit LCD_D0_Direction at TRISD0_bit;
sbit LCD_D1_Direction at TRISD1_bit;
sbit LCD_D2_Direction at TRISD2_bit;
sbit LCD_D3_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;

typedef enum keyType{
 EQUALS, SUM, SUB, MULT, DIVI, ON_CLEAR, NUM, EMPTY
}KeyType;


volatile const char activationCode[] = "*2025*";
volatile const char deActivationCode[] = "+1830+";
volatile char rightKeysActivation[] = {0,0,0,0,0,0};
volatile char rightKeysDeActivation[] = {0,0,0,0,0,0};
volatile char nKeyPressed = 0;
volatile char isOn = 0;
volatile float vSensor1 = 0;
volatile float vSensor2 = 0;
volatile char lastText[80] = "";


char msg1[] = "Alerta de intruso. ";
char msg2[] = " sensores ativados";
char msg3[] = "Alerta de possivel intruso ou sensor ";
char msg4[] = " com defeito";


int keyHandler(int key, KeyType* type);
void keypadHandler();


void alarm();


void interrupt(void)
{
 if(INTCON3.INT1IF)
 {
 keypadHandler();


 TMR0H =  ( 0xffff - 200 )  >> 8;
 TMR0L =  ( 0xffff - 200 ) ;
 INTCON.TMR0IF=0;
 INTCON.TMR0IE=1;
 T0CON.TMR0ON=1;


 INTCON3.INT1IE = 0;
 INTCON3.INT1IF = 0;
 }
 else if(INTCON.TMR0IF)
 {

 INTCON.TMR0IF=0;
 INTCON.TMR0IE=0;
 T0CON.TMR0ON=0;


 INTCON3.INT1IE = 1;
 }







}

void main()
{

 ADCON1 = 0x04;


 Lcd_Init();


 T0CON.T08BIT = 0;
 T0CON.T0CS = 0;
 T0CON.PSA = 0;

 T0CON.T0PS2 = 1;
 T0CON.T0PS1 = 1;
 T0CON.T0PS0 = 1;


 INTCON.GIE=1;
 INTCON3.INT1IE = 1;
 INTCON3.INT1IF = 0;


 TRISB.RB1 = 1;



 TRISC.RC4 = 1;
 TRISC.RC5 = 1;
 TRISC.RC6 = 1;
 TRISC.RC7 = 1;

 TRISA.RA0 = 1;
 TRISA.RA1 = 1;



 TRISB.RB4 = 0;
 TRISB.RB5 = 0;
 TRISB.RB6 = 0;
 TRISB.RB7 = 0;

 PORTB.RB4 = 0;
 PORTB.RB5 = 0;
 PORTB.RB6 = 0;
 PORTB.RB7 = 0;



 TRISA.RA2 = 1;
 TRISA.RA3 = 1;
 TRISA.RA5 = 1;
 TRISB.RB3 = 1;


 TRISC.RC0 = 0;
 TRISC.RC1 = 0;
 TRISC.RC2 = 0;
 TRISC.RC3 = 0;

 PORTC.RC0 = 0;
 PORTC.RC1 = 0;
 PORTC.RC2 = 0;
 PORTC.RC3 = 0;
}


void alarm()
{
 vSensor1 = (ADC_read(0)/1023.0) * 5;
 vSensor2 = (ADC_read(1)/1023.0) * 5;
 if(isOn)
 {
 char activated = 0;
 int sensorCount = 0;


 PORTC.RC0 = PORTC.RC4;
 PORTC.RC1 = PORTC.RC5;
 PORTC.RC2 = PORTC.RC6;
 PORTC.RC3 = PORTC.RC7;

 sensorCount += PORTC.RC4;
 sensorCount += PORTC.RC5;
 sensorCount += PORTC.RC6;
 sensorCount += PORTC.RC7;
 sensorCount += vSensor1 >= 4 ? 1 : 0;
 sensorCount += vSensor2 > 3 ? 1 : 0;

 activated = sensorCount >= 2 ? 1 : 0;

 if(activated)
 {
 char number[4];
 char str[60];
 IntToStr(sensorCount, number);

 strcat(str, msg1);
 strcat(str, number);
 strcat(str, msg2);

 if(strcmp(lastText, str))
 {
 Lcd_Cmd(_LCD_CLEAR);
 strcpy(lastText, str);

 Lcd_Out(1,1,str);
 }
 }
 else
 {
 char number[4];
 char str[60];

 if(PORTC.RC4)
 strcpy(number, "1");

 if(PORTC.RC5)
 strcpy(number, "2");

 if(PORTC.RC6)
 strcpy(number, "3");

 if(PORTC.RC7)
 strcpy(number, "4");

 if(vSensor1 >= 4)
 strcpy(number, "5");

 if(vSensor2 > 3)
 strcpy(number, "6");


 strcat(str, msg3);
 strcat(str, number);
 strcat(str, msg4);

 if(strcmp(lastText, str))
 {
 Lcd_Cmd(_LCD_CLEAR);
 strcpy(lastText, str);

 Lcd_Out(1,1,str);
 }
 }
 }
 else
 {
 char number[4];
 char str[60];

 char str1[5];
 char str2[5];
 IntToStr(vSensor1, str1);
 IntToStr(vSensor2, str2);

 strcat(str, str1);
 strcat(str, "V ");
 strcat(str, str2);
 strcat(str, "V");

 if(strcmp(lastText, str))
 {
 Lcd_Cmd(_LCD_CLEAR);
 strcpy(lastText, str);

 Lcd_Out(1,1,str);
 }
 }
}


void keypadHandler()
{
 char i;
 KeyType type;
 int result;
 char keyPressed[2];
 char rowCode = 0;
 char realCode = 0;
 char columnCode = 0;

 for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
 {
 PORTB = ~(1 << i) << 4;
 columnCode = PORTA.RA2 | (PORTA.RA3 << 1) |
 (PORTA.RA5 << 2) | (PORTB.RB3) << 3;
 }
 rowCode = PORTB >> 4;
 PORTB = 0;

 realCode = rowCode | (columnCode << 4);
 result = keyHandler(realCode, &type);

 if(type == NUM)
 {
 if(result == 0)
 keyPressed[0] = '0';

 if(result == 1)
 keyPressed[0] = '1';

 if(result == 2)
 keyPressed[0] = '2';

 if(result == 3)
 keyPressed[0] = '3';

 if(result == 4)
 keyPressed[0] = '4';

 if(result == 5)
 keyPressed[0] = '5';

 if(result == 6)
 keyPressed[0] = '6';

 if(result == 7)
 keyPressed[0] = '7';

 if(result == 8)
 keyPressed[0] = '8';

 if(result == 9)
 keyPressed[0] = '9';
 }

 if(type == SUM)
 keyPressed[0] = '+';

 if(type == SUB)
 keyPressed[0] = '-';

 if(type == MULT)
 keyPressed[0] = '*';

 if(type == DIVI)
 keyPressed[0] = '/';

 keyPressed[1] = '\0';


 Lcd_Cmd(_LCD_CLEAR);

 IntToStr(rowCode, lastText);
 Lcd_Out(1,1,lastText);

 IntToStr(columnCode, lastText);
 Lcd_Out(2,1,lastText);


 rightKeysActivation[nKeyPressed] = (activationCode[nKeyPressed] != keyPressed[0]) == 0 ? 1 : 0;
 rightKeysDeActivation[nKeyPressed] = (DeActivationCode[nKeyPressed] != keyPressed[0]) == 0 ? 1 : 0;

 if(nKeyPressed == 6)
 {
 int i;
 char activationCounter = 0;
 char deActivationCounter = 0;
 for(i = 0; i < nKeyPressed; i++)
 {
 activationCounter += rightKeysActivation[i];
 deActivationCounter += rightKeysDeActivation[i];
 }

 if(activationCounter == 6)
 {
 isOn = 1;
 }

 if(deActivationCounter == 6)
 {
 isOn = 0;
 }
 }

 nKeyPressed = nKeyPressed == 6 ? 0 : nKeyPressed++;
}


int keyHandler (int key, KeyType* type)
{
 int result = -1;
 switch(key)
 {
 case 231:
 *type = ON_CLEAR;
 break;

 case 215:
 *type = NUM;
 result = 0;
 break;

 case 183:
 *type = EQUALS;
 break;

 case 119:
 *type = SUM;
 break;

 case 235:
 *type = NUM;
 result = 7;
 break;

 case 219:
 *type = NUM;
 result = 8;
 break;

 case 187:
 *type = NUM;
 result = 9;
 break;

 case 123:
 *type = SUB;
 break;

 case 237:
 *type = NUM;
 result = 4;
 break;

 case 221:
 *type = NUM;
 result = 5;
 break;

 case 189:
 *type = NUM;
 result = 6;
 break;

 case 125:
 *type = MULT;
 break;

 case 238:
 *type = NUM;
 result = 1;
 break;

 case 222:
 *type = NUM;
 result = 2;
 break;

 case 190:
 *type = NUM;
 result = 3;
 break;

 case 126:
 *type = DIVI;
 break;
 }

 return result;
}
