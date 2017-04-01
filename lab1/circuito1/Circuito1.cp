#line 1 "C:/Users/mplab.LCA-08/Desktop/lab1/circuito1/Circuito1.c"

 void interrupt(void){
 if (INTCON.INT0IF){
 PORTD.RD0 = 1;
 INTCON.INT0IF=0;
 }
 else if (INTCON3.INT1IF){
 PORTD.RD0 = 0;
 INTCON3.INT1IF=0;
 }
 }

void main() {

INTCON.GIE = 1;


TRISB.RB0 = 1;
INTCON.INT0IF = 0;
INTCON.INT0IE = 1;


TRISB.RB1 = 1;
INTCON3.INT1IF = 0;
INTCON3.INT1IE = 1;


TRISD.RD0 = 0;
PORTD.RD0 = 0;

}
