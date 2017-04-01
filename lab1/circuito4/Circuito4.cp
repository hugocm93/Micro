#line 1 "C:/Users/mplab.LCA-08/Desktop/lab1/circuito4/Circuito4.c"







 void interrupt(void){
 if (INTCON.TMR0IF == 1){
 if(PORTD.RD0==0)
 {
 TMR0H =  ( 0xffff - 15625 )  >> 8;
 TMR0L =  ( 0xffff - 15625 ) ;
 PORTD.RD0=1;
 }
 else if(PORTD.RD0==1)
 {
 TMR0H =  ( 0xffff - 25000 )  >> 8;
 TMR0L =  ( 0xffff - 25000 ) ;
 PORTD.RD0=0;
 }
 INTCON.TMR0IF=0;
 }
 }

void main() {

TRISD.RD0 = 0;
PORTD.RD0 = 0;


T0CON.T08BIT = 0;
T0CON.T0CS = 0;
T0CON.PSA = 0;


T0CON.T0PS2 = 1;
T0CON.T0PS1 = 1;
T0CON.T0PS0 = 1;


TMR0H =  ( 0xffff - 25000 )  >> 8;
TMR0L =  ( 0xffff - 25000 ) ;


INTCON.TMR0IP = 1;
INTCON.TMR0IF=0;
INTCON.TMR0IE=1;
INTCON.PEIE=0;
INTCON.GIE=1;

T0CON.TMR0ON=1;

}
