const int clockFrequency = 8000000 / 2;

// Sets up and initializes timer with number of pulses
void setupCounter(char counterNumber, short pulses);

// Calculates the number of pulses according to the provided scale and secons
int calcPulses(float seconds, char scale);

 // High priority interrupt function
void interrupt(void)
{
	if (INTCON.TMR0IF)
	{
		PORTD.RD0 = 1;

		//Timer 1, 2 seconds, scale -> 16
		setupCounter(1, calcPulses(2, 16));
	}
	else if (INTCON.TMR2F)
	{
		PORTD.RD0 = 0;
		INTCON.TMR0IF=0;
	}
}

void main() {
// LED config
TRISD.RD0 = 0;  // digital output
PORTD.RD0 = 0;  // LED off

//Timer 0, 3.2 seconds, scale -> 256
setupCounter(0, calcPulses(3.2, 256));

}


void setupCounter(char counterNumber, short pulses)
{
	switch(counterNumber)
	{
		case 0:
			// Timer 0 Configuration
			T0CON.T08BIT = 0;       // 16 bits
			T0CON.T0CS = 0;         // Internal clock => Crystal/4
			T0CON.PSA = 0;          // Prescaler ON

			// Prescaler = 111 => 1:256
			T0CON.T0PS2 = 1;
			T0CON.T0PS1 = 1;
			T0CON.T0PS0 = 1;

			// Load Timer 0 counter
			TMR0H = pulses >> 8;  // Load Timer 0 counter - 1st TMR0H
			TMR0L = pulses;       // Load Timer 0 counter - 2nd TMR0L

			// Timer 0 interrupt
			INTCON.TMR0IP = 1;
			INTCON.TMR0IF=0;
			INTCON.TMR0IE=1;
			INTCON.PEIE=0;
			INTCON.GIE=1;
			// Start timer 0
			T0CON.TMR0ON=1;         // Timer ON
		break;

		case 1:
			// Prescaler = 11 => 1:16
			T2CON.T2CKPS1 = 1;
			T2CON.T2CKPS0 = 1;

			// Load Timer 2 counter
			TMR2H = pulses;  // Load Timer 2 counter

			// Timer 2 interrupt
			INTCON.TMR2IP = 1;
			INTCON.TMR2IF=0;
			INTCON.TMR2IE=1;
			INTCON.PEIE=0;
			INTCON.GIE=1;

			// Timer 2 Configuration
			T2CON.TMR2ON = 1;       // On
		break;
	}
}


int calcPulses(float seconds, char scale)
{
	float pulseDuration = 1/(clockFrequency / (float)scale);
	short pulses = seconds / pulseDuration;

	return (0xffff - pulses);
}
