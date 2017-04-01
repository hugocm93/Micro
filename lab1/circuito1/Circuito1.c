// High priority interrupt function
 void interrupt(void){
   if (INTCON.INT0IF){
     PORTD.RD0 = 1;   // led on
     INTCON.INT0IF=0;
   }
   else if (INTCON3.INT1IF){
     PORTD.RD0 = 0;   //led off
     INTCON3.INT1IF=0;
   }
 }

void main() {
// Global Interrupt Enable
INTCON.GIE = 1;

// Int0/PORTB0 interrupt config
TRISB.RB0 = 1; // digital input
INTCON.INT0IF = 0;    // init flag with zero
INTCON.INT0IE = 1;    // Interrupt is enabled

// Int1/PORTB1 interrupt config
TRISB.RB1 = 1; // digital input
INTCON3.INT1IF = 0;    // init flag with zero
INTCON3.INT1IE = 1;    // Interrupt is enabled

// LED config
TRISD.RD0 = 0;  // digital output
PORTD.RD0 = 0;  // LED Off

}
