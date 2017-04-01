// High priority interrupt function
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
// Global Interrupt Enable
INTCON.GIE = 1;

// Int0/PORTB0 interrupt config
TRISB.RB1 = 1; // digital input
TRISB.RB2 = 1; // digital input

INTCON3.INT1IE = 1;
INTCON3.INT1IF = 0;

INTCON3.INT2IE = 1;
INTCON3.INT2IF = 0;

INTCON2.INTEDG1 = 1;  // Rising edge (1->0)
INTCON2.INTEDG2 = 0;  // Falling edge (0->1)

// LED config
TRISD.RD0 = 0;  // digital output
PORTD.RD0 = 0;  // LED Off

}