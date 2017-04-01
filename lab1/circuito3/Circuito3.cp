#line 1 "C:/Users/mplab.LCA-08/Desktop/lab1/circuito3/Circuito3.c"

 void interrupt(void){
 if(INTCON3.INT1IF){
 PORTD.RD0 = 0;
 INTCON3.INT1IF = 0;
 }
 else if(INTCON3.INT2IF){
 PORTD.RD0 = 1;
 INTCON3.INT2IF = 0;
 }
 }

void main() {

INTCON.GIE = 1;


TRISB.RB0 = 1;
TRISB.RB1 = 1;
TRISB.RB2 = 1;

INTCON3.INT1IE = 1;
INTCON3.INT1IF = 0;

INTCON3.INT2IE = 1;
INTCON3.INT2IF = 0;

INTCON2.INTEDG1 = 1;
INTCON2.INTEDG2 = 0;


TRISD.RD0 = 0;
PORTD.RD0 = 0;

}
