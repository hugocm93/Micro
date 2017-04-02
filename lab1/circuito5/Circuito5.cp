#line 1 "C:/Users/hugocm93/Desktop/Micro/lab1/circuito5/Circuito5.c"
const int clockFrequency = 8000000 / 2;
unsigned short int pulses1 = 0, pulses2 = 0;


void setupCounter(char counterNumber, unsigned short int pulses);


unsigned short int calcPulses(float seconds, unsigned short int scale);


void interrupt(void);

void main()
{

TRISD.RD0 = 0;
PORTD.RD0 = 0;

pulses1 = calcPulses(3.2, 256);
pulses2 = calcPulses(2, 16);


setupCounter(0, pulses1);


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

 T0CON.T08BIT = 0;
 T0CON.T0CS = 0;
 T0CON.PSA = 0;


 T0CON.T0PS2 = 1;
 T0CON.T0PS1 = 1;
 T0CON.T0PS0 = 1;


 TMR0H = pulses >> 8;
 TMR0L = pulses;


 INTCON.TMR0IP = 1;
 INTCON.TMR0IF=0;
 INTCON.TMR0IE=1;
 INTCON.PEIE=0;
 INTCON.GIE=1;

 T0CON.TMR0ON=1;
 break;

 case 1:

 T2CON.T2CKPS1 = 1;
 T2CON.T2CKPS0 = 1;


 TMR2 = pulses;


 INTCON.TMR2IP = 1;
 INTCON.TMR2IF=0;
 INTCON.TMR2IE=1;
 INTCON.PEIE=0;
 INTCON.GIE=1;


 T2CON.TMR2ON = 1;
 break;
 }
}


unsigned short int calcPulses(float seconds, unsigned short int scale)
{
 float pulseDuration = 1/(clockFrequency / (float)scale);
 unsigned short int pulses = (seconds*1000000) / pulseDuration;

 return (0xffff - pulses);
}
