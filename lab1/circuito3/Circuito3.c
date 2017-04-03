// High priority interrupt function
volatile char xx;
void interrupt(void){
        if(INTCON.RBIF){
                PORTD.RD0 = ~PORTD.RD0;
                xx = PORTB;
                INTCON.RBIF = 0;
        }
 }

void main() {
// Global Interrupt Enable
INTCON.GIE = 1;

// Int0/PORTB0 interrupt config
TRISB.RB4 = 1; // digital input

INTCON.RBIE = 1;
INTCON.RBIF = 0;

// LED config
TRISD.RD0 = 0;  // digital output
PORTD.RD0 = 0;  // LED Off

}