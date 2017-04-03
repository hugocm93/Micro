#line 1 "C:/Users/mplab.LCA-06/Downloads/Micro-master/Micro-master/lab1/circuito3/Circuito3.c"

volatile char xx;
void interrupt(void){
 if(INTCON.RBIF){
 PORTD.RD0 = ~PORTD.RD0;
 xx = PORTB;
 INTCON.RBIF = 0;
 }
 }

void main() {

INTCON.GIE = 1;


TRISB.RB4 = 1;

INTCON.RBIE = 1;
INTCON.RBIF = 0;


TRISD.RD0 = 0;
PORTD.RD0 = 0;

}
