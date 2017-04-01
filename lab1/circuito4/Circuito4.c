// (8MHz / 4 ) / 256 => 128us x 25000 = 3.2s
#define COUNTER1 ( 0xffff - 25000 )

// (8MHz / 4 ) / 256 => 128us x 15625 = 2s
#define COUNTER2 ( 0xffff - 15625 )

 // High priority interrupt function
 void interrupt(void){
   if (INTCON.TMR0IF == 1){
     if(PORTD.RD0==0)
     {
       TMR0H = COUNTER2 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
       TMR0L = COUNTER2;       // RE-Load Timer 0 counter - 2nd TMR0L
       PORTD.RD0=1;
     }
     else if(PORTD.RD0==1)
     {
       TMR0H = COUNTER1 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
       TMR0L = COUNTER1;       // RE-Load Timer 0 counter - 2nd TMR0L
       PORTD.RD0=0;
     }
     INTCON.TMR0IF=0;
   }
 }

void main() {
// LED config
TRISD.RD0 = 0;  // digital output
PORTD.RD0 = 0;  // LED off

// Timer 0 Configuration
T0CON.T08BIT = 0;       // 16 bits
T0CON.T0CS = 0;         // Internal clock => Crystal/4
T0CON.PSA = 0;          // Prescaler ON

// Prescaler = 111 => 1:256
T0CON.T0PS2 = 1;
T0CON.T0PS1 = 1;
T0CON.T0PS0 = 1;

// Load Timer 0 counter
TMR0H = COUNTER1 >> 8;  // Load Timer 0 counter - 1st TMR0H
TMR0L = COUNTER1;       // Load Timer 0 counter - 2nd TMR0L

// Timer 0 interrupt
INTCON.TMR0IP = 1;
INTCON.TMR0IF=0;
INTCON.TMR0IE=1;
INTCON.PEIE=0;
INTCON.GIE=1;
// Start timer 0
T0CON.TMR0ON=1;         // Timer ON

}