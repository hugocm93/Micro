int flag = 1;

// High priority interrupt function
 void interrupt(void){
        if(INTCON.INT0IF){
                PORTD.RD0 = flag;

                INTCON.INT0IF=0;
                flag = !flag;
        }
 }

void main() {
// Global Interrupt Enable
INTCON.GIE = 1;

// Int0/PORTB0 interrupt config
TRISB.RB0 = 1; // digital input
INTCON.INT0IF = 0;    // init flag with zero
INTCON.INT0IE = 1;    // Interrupt is enabled

// LED config
TRISD.RD0 = 0;  // digital output
PORTD.RD0 = 0;  // LED Off

}