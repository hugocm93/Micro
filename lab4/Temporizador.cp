#line 1 "C:/Users/mplab.LCA-06/Downloads/Micro/lab4/Temporizador.c"
#line 13 "C:/Users/mplab.LCA-06/Downloads/Micro/lab4/Temporizador.c"
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


unsigned int display();
volatile int nDigit = 0;
volatile int pot = 100;

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
 TMR3H =  ( 0xffff - 1000 )  >> 8;
 TMR3L =  ( 0xffff - 1000 ) ;

 nDigit = nDigit == 3 ? 0 : nDigit;

 pot = pot == 100 ? 1 : pot*10;

 PORTA.RA2 = 0;
 PORTA.RA3 = 0;
 PORTA.RA4 = 0;

 PORTD = display();

 if(nDigit==0)
 PORTA.RA4 = 1;
 if(nDigit==1)
 {
 PORTD.RD7 = 1;
 PORTA.RA3 = 1;
 }
 if(nDigit==2)
 PORTA.RA2 = 1;

 nDigit++;

 PIR2.TMR3IF = 0;
 }
 if(PIR1.TMR1IF)
 {
 PORTC.RC1 = 1;
 progMode = 1;

 PIR2.TMR3IF = 0;
 PIE2.TMR3IE = 0;
 T3CON.TMR3ON = 0;

 PORTA.RA2 = 0;
 PORTA.RA3 = 0;
 PORTA.RA4 = 0;

 PIR1.TMR1IF=0;
 PIE1.TMR1IE=0;
 T1CON.TMR1ON=0;
 }
 if(INTCON.INT0IF)
 {
 PORTC.RC1 = 0;
 time = 0;
 timeCounter = 0;
 nPressed = 0;

 progMode = 1;

 loadTimer2();


 INTCON.INT0IE = 0;
 INTCON.INT0IF = 0;
 }
 if(INTCON3.INT2IF)
 {
 loadTimer2();

 progMode = 0;


 TMR1H =  ( 0xffff - (unsigned int)(time/0.16) )  >> 8;
 TMR1L =  ( 0xffff - (unsigned int)(time/0.16) ) ;
 PIR1.TMR1IF=0;
 PIE1.TMR1IE=1;
 T1CON.TMR1ON=1;


 TMR3H =  ( 0xffff - 1000 )  >> 8;
 TMR3L =  ( 0xffff - 1000 ) ;
 PIR2.TMR3IF = 0;
 PIE2.TMR3IE = 1;
 T3CON.TMR3ON = 1;


 INTCON3.INT2IE = 0;
 INTCON3.INT2IF = 0;
 }

}

void loadTimer2()
{

 TMR2 =  ( 0xffff - 7500 ) ;

 PIR1.TMR2IF=0;
 PIE1.TMR2IE=1;

 T2CON.TMR2ON = 1;
}

void main()
{

 ADCON1 = 0x06;


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



 TRISA.RA0 = 1;
 TRISA.RA1 = 1;
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


 TRISD.RD0 = 0;
 TRISD.RD1 = 0;
 TRISD.RD2 = 0;
 TRISD.RD3 = 0;
 TRISD.RD4 = 0;
 TRISD.RD5 = 0;
 TRISD.RD6 = 0;
 TRISD.RD7 = 0;

 PORTD.RD0 = 0;
 PORTD.RD1 = 0;
 PORTD.RD2 = 0;
 PORTD.RD3 = 0;
 PORTD.RD4 = 0;
 PORTD.RD5 = 0;
 PORTD.RD6 = 0;
 PORTD.RD7 = 0;

 TRISA.RA2 = 0;
 TRISA.RA3 = 0;
 TRISA.RA4 = 0;

 PORTA.RA2 = 0;
 PORTA.RA3 = 0;
 PORTA.RA4 = 0;
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
 columnCode = PORTA.RA0 | (PORTA.RA1 << 1) |
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
 time += 0.001;
 }
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


unsigned int display ()
{
 int number = ((int)((time - timeCounter)*10)/pot) % 10;
 switch(number)
 {
 case 0: return 0x3F;
 case 1: return 0x06;
 case 2: return 0x5B;
 case 3: return 0x4F;
 case 4: return 0x66;
 case 5: return 0x6D;
 case 6: return 0x7D;
 case 7: return 0x07;
 case 8: return 0x7F;
 case 9: return 0x6F;
 }
}
