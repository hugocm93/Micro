const int clockFrequency = 8000000 / 2;
unsigned short int pulses1 = 0, pulses2 = 0;

// Sets up and initializes timer with number of pulses
void setupCounter(char counterNumber, unsigned short int pulses);

// Calculates the number of pulses according to the provided scale and secons
unsigned short int calcPulses(float seconds, unsigned short int scale);

// High priority interrupt function
void interrupt(void);

void main()
{
// LED config
TRISD.RD0 = 0;  // digital output
PORTD.RD0 = 0;  // LED off

pulses1 = calcPulses(3.2, 256);
pulses2 = calcPulses(2, 16);

//Timer 0, 3.2 seconds, scale -> 256
setupCounter(0, pulses1);

//Timer 1, 2 seconds, scale -> 16
setupCounter(1, pulses2);
}


void interrupt(void)
{
        if (INTCON.TMR0IF)
        {
                PORTD.RD0 = 1;

                TMR2 = pulses2;
                
                INTCON.TMR2IF=0;
        }
        else if (INTCON.TMR2IF)
        {
                PORTD.RD0 = 0;
                
                TMR0H = pulses1 >> 8;
                TMR0L = pulses1;
                
                INTCON.TMR0IF=0;
        }
}


void setupCounter(char counterNumber, unsigned short int pulses)
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
                        TMR2 = pulses;  // Load Timer 2 counter

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


unsigned short int calcPulses(float seconds, unsigned short int scale)
{
        float pulseDuration = 1/(clockFrequency / (float)scale);
        unsigned short int pulses = (seconds*1000000) / pulseDuration;

        return (0xffff - pulses);
}
