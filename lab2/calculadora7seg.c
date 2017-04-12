// (8MHz / 4 ) / 256 => 128us x 100 = 0.0128
#define COUNTER ( 0xffff - 100 )

typedef enum keyType{
        EQUALS, SUM, SUB, MULT, DIVI, ON_CLEAR, NUM, EMPTY
}KeyType;

char edge = 1; //Controle de nível na interrupção

//Calculator vars
char columnCode = 0;
int operando1 = 0;
int operando2 = 0;
int numberOnDisplay = 0;
KeyType operation = EMPTY;

// Keypad functions
int keyHandler(int key, KeyType* type);
void keypadHandler();

// 7 segment display functions
unsigned int display();
int nDigit = 0;

void interrupt(void)
{
  if(INTCON.TMR0IF)
  {
     TMR0H = COUNTER >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
     TMR0L = COUNTER;       // RE-Load Timer 0 counter - 2nd TMR0L

     if(nDigit == 4)
     {
	nDigit = 0;
     }

	PORTA.RA2 = 0;
	PORTA.RA3 = 0;
	PORTA.RA0 = 0;
	PORTA.RA5 = 0;
	
	PORTD = display();

     if(nDigit==0)PORTA.RA2 = 1;
     if(nDigit==1)PORTA.RA3 = 1;
     if(nDigit==2)PORTA.RA0 = 1;
     if(nDigit==3)PORTA.RA5 = 1;
	
     nDigit++;
     INTCON.TMR0IF=0;
  }

  if(INTCON.RBIF)
  {
    keypadHandler();

    edge = !edge;
    INTCON.RBIF = 0;
  }
}

void main()
{
    // Timer 0 Configuration
    T0CON.T08BIT = 0;       // 16 bits
    T0CON.T0CS = 0;         // Internal clock => Crystal/4
    T0CON.PSA = 0;          // Prescaler ON
    
    // Prescaler = 111 => 1:256
    T0CON.T0PS2 = 1;
    T0CON.T0PS1 = 1;
    T0CON.T0PS0 = 1;
    
    // Load Timer 0 counter
    TMR0H = COUNTER >> 8;  // Load Timer 0 counter - 1st TMR0H
    TMR0L = COUNTER;       // Load Timer 0 counter - 2nd TMR0L
    
    // Timer 0 interrupt
    INTCON.TMR0IP = 1;
    INTCON.TMR0IF=0;
    INTCON.TMR0IE=1;
    INTCON.PEIE=0;
    INTCON.GIE=1;

    // Start timer 0
    T0CON.TMR0ON=1;         
    
    // Timer ON//Pins as digital I/O
    ADCON1 = 0x6;

    // Global Interrupt Enable
    INTCON.GIE = 1;

    // Int0/PORTB0 interrupt config
    TRISB.RB4 = 1; // digital input
    TRISB.RB5 = 1; // digital input
    TRISB.RB6 = 1; // digital input
    TRISB.RB7 = 1; // digital input

    TRISB.RB0 = 0; // digital output
    TRISB.RB1 = 0;
    TRISB.RB2 = 0;
    TRISB.RB3 = 0;

    PORTB.RB0 = 0; // digital output
    PORTB.RB1 = 0;
    PORTB.RB2 = 0;
    PORTB.RB3 = 0;

    //7 segments
    TRISD.RD0 = 0; // digital output
    TRISD.RD1 = 0;
    TRISD.RD2 = 0;
    TRISD.RD3 = 0;
    TRISD.RD4 = 0;
    TRISD.RD5 = 0;
    TRISD.RD6 = 0;
    TRISD.RD7 = 0;

    PORTD.RD0 = 0;
    PORTD.RD1 = 0;
    PORTD.RD2 = 0;
    PORTD.RD3 = 0;
    PORTD.RD4 = 0;
    PORTD.RD5 = 0;
    PORTD.RD6 = 0;
    PORTD.RD7 = 0;

    //7 seg controle
    TRISA.RA2 = 0; // digital output
    TRISA.RA3 = 0;
    TRISA.RA0 = 0;
    TRISA.RA5 = 0;

    PORTA.RA2 = 0;
    PORTA.RA3 = 0;
    PORTA.RA0 = 0;
    PORTA.RA5 = 0;

    INTCON.RBIE = 1;
    INTCON.RBIF = 0;
}

void keypadHandler()
{
    char i;
    KeyType type;
    int result;

    for(i = 0, columnCode = 0x0f; (i < 4) && (columnCode==0x0f); i++)
    {
       PORTB.RB0 = 1; // digital output
       PORTB.RB1 = 1;
       PORTB.RB2 = 1;
       PORTB.RB3 = 1;
       if(i==0)PORTB.RB0 = 0; // digital output
       if(i==1)PORTB.RB1 = 0;
       if(i==2)PORTB.RB2 = 0;
       if(i==3)PORTB.RB3 = 0;
       columnCode = PORTB >> 4;
    }
    result = keyHandler(PORTB, &type);
    PORTB.RB0 = 0; // digital output
    PORTB.RB1 = 0;
    PORTB.RB2 = 0;
    PORTB.RB3 = 0;

    if(edge == 1)
    {

      if(type == NUM && operation == EMPTY)
      {
       operando1 *= 10;
       operando1 += result;
       numberOnDisplay = operando1;
      }
      if(type != NUM && type != ON_CLEAR && type != EQUALS)
      {
       operation = type;
      }
      if(type == NUM && operation != EMPTY)
      {
       operando2 *= 10;
       operando2 += result;
       numberOnDisplay = operando2;
      }
      if(type == EQUALS)
      {
       if(operation == SUM)
	       numberOnDisplay = operando1 + operando2;

       if(operation == SUB)
	       numberOnDisplay = operando1 - operando2;

       if(operation == MULT)
	       numberOnDisplay = operando1 * operando2;

       if(operation == DIVI)
	       numberOnDisplay = operando1 / operando2;
	       
       operando1 = numberOnDisplay;
       operando2 = 0;
       operation = EMPTY;
      }
      if(type == ON_CLEAR)
      {
       operando1 = 0;
       operando2 = 0;
       operation = EMPTY;
       numberOnDisplay = 0;
      }
    }
}


int keyHandler (int key, KeyType* type)
{
    int result = -1;
    switch(key)
    {
     case 231:
     *type = ON_CLEAR;
     break;

     case 215:
     *type = NUM;
     result = 0;
     break;

     case 183:
     *type = EQUALS;
     break;

     case 119:
     *type = SUM;
     break;

     case 235:
     *type = NUM;
     result = 1;
     break;

     case 219:
     *type = NUM;
     result = 2;
     break;

     case 187:
     *type = NUM;
     result = 3;
     break;

     case 123:
     *type = SUB;
     break;

     case 237:
     *type = NUM;
     result = 4;
     break;

     case 221:
     *type = NUM;
     result = 5;
     break;

     case 189:
     *type = NUM;
     result = 6;
     break;

     case 125:
     *type = MULT;
     break;

     case 238:
     *type = NUM;
     result = 7;
     break;

     case 222:
     *type = NUM;
     result = 8;
     break;

     case 190:
     *type = NUM;
     result = 9;
     break;

     case 126:
     *type = DIVI;
     break;
    }

    return result;
}


unsigned int display ()
{
    int number = (int)(numberOnDisplay/pow(10, nDigit)) % 10;
    switch(number)
    {
          case 0: return 0x3F;
          case 1: return 0x06;
          case 2: return 0x5B;
          case 3: return 0x4F;
          case 4: return 0x66;
          case 5: return 0x6D;
          case 6: return 0x7D;
          case 7: return 0x07;
          case 8: return 0x7F;
          case 9: return 0x6F;
    }
}