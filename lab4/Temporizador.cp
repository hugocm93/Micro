#line 1 "C:/Users/mplab.LCA-06/Downloads/Micro/lab4/Temporizador.c"
#line 14 "C:/Users/mplab.LCA-06/Downloads/Micro/lab4/Temporizador.c"
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


int keyHandler(int key, KeyType* type);
void keypadHandler();


volatile float time = 0;
volatile float timeCounter = 0;
volatile char str[14];
volatile int nPressed = 0;
volatile int progMode = 1;

void loadTimer2();

void interrupt(void)
{
 if(INTCON3.INT1IF)
 {
 if(progMode)
 {
 keypadHandler();
 }

 loadTimer2();


 INTCON3.INT1IE = 0;
 INTCON3.INT1IF = 0;
 }
 if(PIR1.TMR2IF)
 {

 PIR1.TMR2IF=0;
 PIE1.TMR2IE=0;
 T2CON.TMR2ON=0;


 INTCON3.INT1IE = 1;
 INTCON3.INT1IF = 0;


 INTCON.INT0IE = 1;
 INTCON.INT0IF = 0;


 INTCON3.INT2IE = 1;
 INTCON3.INT2IF = 0;
 }
 if(INTCON.TMR0IF)
 {
 TMR0H =  ( 0xffff - 1250 )  >> 8;
 TMR0L =  ( 0xffff - 1250 ) ;

 PORTC.RC0 = ~PORTC.RC0;

 if(!progMode)
 {
 timeCounter += 0.01;
 }

 INTCON.TMR0IF = 0;
 }
 if(PIR2.TMR3IF)
 {
 TMR3H =  ( 0xffff - 60000 )  >> 8;
 TMR3L =  ( 0xffff - 60000 ) ;

 FloatToStr((time - timeCounter), str);
 Lcd_Out(1, 1, str);

 PIR2.TMR3IF = 0;
 }
 if(PIR1.TMR1IF)
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Time's up");

 progMode = 1;

 PIR2.TMR3IF = 0;
 PIE2.TMR3IE = 0;
 T3CON.TMR3ON = 0;

 PIR1.TMR1IF=0;
 PIE1.TMR1IE=0;
 T1CON.TMR1ON=0;
 }
 if(INTCON.INT0IF)
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Prog");

 progMode = 1;

 loadTimer2();


 INTCON.INT0IE = 0;
 INTCON.INT0IF = 0;
 }
 if(INTCON3.INT2IF)
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Disp");

 FloatToStr((time - timeCounter), str);
 Lcd_Out(2, 1, str);

 loadTimer2();

 progMode = 0;


 TMR1H =  ( 0xffff - (unsigned int)(time/0.16) )  >> 8;
 TMR1L =  ( 0xffff - (unsigned int)(time/0.16) ) ;
 PIR1.TMR1IF=0;
 PIE1.TMR1IE=1;
 T1CON.TMR1ON=1;


 TMR3H =  ( 0xffff - 60000 )  >> 8;
 TMR3L =  ( 0xffff - 60000 ) ;
 PIR2.TMR3IF = 0;
 PIE2.TMR3IE = 1;
 T3CON.TMR3ON = 1;


 INTCON3.INT2IE = 0;
 INTCON3.INT2IF = 0;
 }

}

void loadTimer2()
{

 TMR2 =  ( 0xffff - 3200 ) ;

 PIR1.TMR2IF=0;
 PIE1.TMR2IE=1;

 T2CON.TMR2ON = 1;
}

void main()
{

 ADCON1 = 0x04;


 Lcd_Init();


 T0CON.T08BIT = 0;
 T0CON.T0CS = 0;
 T0CON.PSA = 0;

 T0CON.T0PS2 = 0;
 T0CON.T0PS1 = 1;
 T0CON.T0PS0 = 1;

 TMR0H =  ( 0xffff - 1250 )  >> 8;
 TMR0L =  ( 0xffff - 1250 ) ;
 INTCON.TMR0IF=0;
 INTCON.TMR0IE=1;
 T0CON.TMR0ON=1;


 TRISC.RC0 = 0;
 PORTC.RC0 = 0;
 T1CON.RD16 = 1;
 T1CON.T1OSCEN = 0;
 T1CON.TMR1CS = 1;
 T1CON.T1SYNC = 1;

 T1CON.T1CKPS1 = 1;
 T1CON.T1CKPS0 = 1;



 T2CON.T2CKPS1 = 1;
 T2CON.T2CKPS0 = 1;


 T3CON.RD16 = 1;
 T3CON.T3CCP2 = 1;
 T3CON.T3CKPS1 = 0;
 T3CON.T3CKPS0 = 1;
 T3CON.TMR3CS = 0;


 INTCON.GIE=1;
 INTCON3.INT1IE = 1;
 INTCON3.INT1IF = 0;


 TRISB.RB1 = 1;



 TRISB.RB4 = 0;
 TRISB.RB5 = 0;
 TRISB.RB6 = 0;
 TRISB.RB7 = 0;

 PORTB.RB4 = 0;
 PORTB.RB5 = 0;
 PORTB.RB6 = 0;
 PORTB.RB7 = 0;



 TRISA.RA2 = 1;
 TRISA.RA4 = 1;
 TRISA.RA5 = 1;
 TRISB.RB3 = 1;


 TRISC.RC1 = 0;
 PORTC.RC1 = 0;


 INTCON.INT0IE = 1;
 INTCON.INT0IF = 0;
 TRISB.RB0 = 1;
 INTCON3.INT2IE = 1;
 INTCON3.INT2IF = 0;
 TRISB.RB2 = 1;
}


void keypadHandler()
{
 char i;
 KeyType type;
 int result;
 char rowCode = 0;
 char realCode = 0;
 char columnCode = 0;

 for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
 {

 PORTB = ~(1 << i) << 4;
 columnCode = PORTA.RA2 | (PORTA.RA4 << 1) |
 (PORTA.RA5 << 2) | (PORTB.RB3) << 3;

 }
 rowCode = PORTB >> 4;
 PORTB = 0;

 realCode = rowCode | (columnCode << 4);
 result = keyHandler(realCode, &type);

 nPressed += 1;

 if(nPressed < 3)
 {
 time *= 10;
 time += result;
 }
 else
 {
 time += (result * 0.1);
 }

 Lcd_Cmd(_LCD_CLEAR);
 FloatToStr(time, str);
 Lcd_Out(1, 1, str);
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
 result = 1;
 break;

 case 219:
 *type = NUM;
 result = 2;
 break;

 case 187:
 *type = NUM;
 result = 3;
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
 result = 7;
 break;

 case 222:
 *type = NUM;
 result = 8;
 break;

 case 190:
 *type = NUM;
 result = 9;
 break;

 case 126:
 *type = DIVI;
 break;
 }

 return result;
}
