// (8MHz / 4 ) / 16 => 8us x 1250 = 0.01s
#define COUNTER0 ( 0xffff - 1250 )

// (100 / 2) / 8 => 0.16s x ? = time
#define COUNTER1 ( 0xffff - (unsigned int)(time/0.16) )

// (8MHz / 4 ) / 16 => 8us x 7500 = 0.06s
#define COUNTER2 ( 0xffff - 7500 )

// (8MHz / 4 ) / 2 => 1us x 1000 = 0.001s
#define COUNTER3 ( 0xffff - 1000 )

typedef enum keyType{
        EQUALS, SUM, SUB, MULT, DIVI, ON_CLEAR, NUM, EMPTY
}KeyType;

// Keypad functions
int keyHandler(int key, KeyType* type);
void keypadHandler();

//Timer vars
volatile float time = 0;
volatile float timeCounter = 0;
volatile char str[14];
volatile int nPressed = 0;
volatile int progMode = 1;

// 7 segment display functions
unsigned int display();
volatile int nDigit = 0;
volatile int pot = 100;

void loadTimer2();

void interrupt(void)
{
    if(INTCON3.INT1IF)
    {
        if(progMode)
        {
            keypadHandler();
        }

        loadTimer2();

        // Stop interruption
        INTCON3.INT1IE = 0;
        INTCON3.INT1IF = 0;
    }
    if(PIR1.TMR2IF) // Related to bouncing
    {
        // End timer 2
        PIR1.TMR2IF=0;
        PIE1.TMR2IE=0;
        T2CON.TMR2ON=0;

        // Resume interruption 1
        INTCON3.INT1IE = 1;
        INTCON3.INT1IF = 0;

        // Resume interruption 0
        INTCON.INT0IE = 1;
        INTCON.INT0IF = 0;

        // Resume interruption 2
        INTCON3.INT2IE = 1;
        INTCON3.INT2IF = 0;
    }
    if(INTCON.TMR0IF) //timer increment
    {
        TMR0H = COUNTER0 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
        TMR0L = COUNTER0;       // RE-Load Timer 0 counter - 2nd TMR0L

        PORTC.RC0 = ~PORTC.RC0; 

        if(!progMode)
        {
            timeCounter += 0.01;
        }

        INTCON.TMR0IF = 0;
    }
    if(PIR2.TMR3IF) //Display 7seg
    {
        TMR3H = COUNTER3 >> 8;  // RE-Load Timer 1 counter - 1st TMR1H
        TMR3L = COUNTER3;       // RE-Load Timer 1 counter - 2nd TMR1L

        nDigit = nDigit == 3 ? 0 : nDigit;

        pot = pot == 100 ? 1 : pot*10;

        PORTA.RA2 = 0;
        PORTA.RA3 = 0;
        PORTA.RA4 = 0;

        PORTD = display();

        if(nDigit==0)
            PORTA.RA4 = 1;
        if(nDigit==1)
        {
            PORTD.RD7 = 1;
            PORTA.RA3 = 1;
        }
        if(nDigit==2)
            PORTA.RA2 = 1;

        nDigit++;

        PIR2.TMR3IF = 0;
    }
    if(PIR1.TMR1IF) //Total timer
    {
        PORTC.RC1 = 1;
        progMode = 1;

        PIR2.TMR3IF = 0;
        PIE2.TMR3IE = 0;
        T3CON.TMR3ON = 0;

        PORTA.RA2 = 0;
        PORTA.RA3 = 0;
        PORTA.RA4 = 0;

        PIR1.TMR1IF=0;
        PIE1.TMR1IE=0;
        T1CON.TMR1ON=0;
    }
    if(INTCON.INT0IF)
    {
        PORTC.RC1 = 0;
        time = 0;
        timeCounter = 0;
        nPressed = 0;

        progMode = 1;

        loadTimer2();

        // Stop interruption
        INTCON.INT0IE = 0;
        INTCON.INT0IF = 0;
    }
    if(INTCON3.INT2IF)
    {
        loadTimer2();

        progMode = 0;

        // Start timer 1
        TMR1H = COUNTER1 >> 8;  // RE-Load Timer 1 counter - 1st TMR1H
        TMR1L = COUNTER1;       // RE-Load Timer 1 counter - 2nd TMR1L
        PIR1.TMR1IF=0;
        PIE1.TMR1IE=1;
        T1CON.TMR1ON=1;

        //Start timer 3
        TMR3H = COUNTER3 >> 8;  // RE-Load Timer 1 counter - 1st TMR1H
        TMR3L = COUNTER3;       // RE-Load Timer 1 counter - 2nd TMR1L
        PIR2.TMR3IF = 0;
        PIE2.TMR3IE = 1;
        T3CON.TMR3ON = 1;

        // Stop interruption
        INTCON3.INT2IE = 0;
        INTCON3.INT2IF = 0;
    }

}

void loadTimer2()
{
    // Load Timer 2 counter
    TMR2 = COUNTER2;
    // Timer 2 interrupt
    PIR1.TMR2IF=0;
    PIE1.TMR2IE=1;
    // Timer 2 Configuration
    T2CON.TMR2ON = 1;
}

void main()
{
    // Timer ON//Pins as digital I/O
    ADCON1 = 0x06;

    // Timer 0 Configuration
    T0CON.T08BIT = 0;       // 16 bits
    T0CON.T0CS = 0;         // Internal clock => Crystal/4
    T0CON.PSA = 0;          // Prescaler ON
    // Prescaler = 011 => 1:16
    T0CON.T0PS2 = 0;
    T0CON.T0PS1 = 1;
    T0CON.T0PS0 = 1;
    // Start timer 0
    TMR0H = COUNTER0 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
    TMR0L = COUNTER0;       // RE-Load Timer 0 counter - 2nd TMR0L
    INTCON.TMR0IF=0;
    INTCON.TMR0IE=1;
    T0CON.TMR0ON=1;

    // Timer 1
    TRISC.RC0 = 0;
    PORTC.RC0 = 0;
    T1CON.RD16 = 1;        // Read/Write in two 8 bits oper 
    T1CON.T1OSCEN = 0;     // Disable internal Oscilator 
    T1CON.TMR1CS = 1;      // External clock from RC0 
    T1CON.T1SYNC = 1;      // Do not synchronize ext clock
    // Prescaler = 11 => 1:8
    T1CON.T1CKPS1 = 1;
    T1CON.T1CKPS0 = 1;

    // Timer 2 configuration
    // Prescaler = 11 => 1:16
    T2CON.T2CKPS1 = 1;
    T2CON.T2CKPS0 = 1;

    // Timer 3 Configuration
    T3CON.RD16 = 1;
    T3CON.T3CCP2 = 1;
    T3CON.T3CKPS1 = 0;
    T3CON.T3CKPS0 = 1;
    T3CON.TMR3CS = 0;

    // External interrupt
    INTCON.GIE=1;
    INTCON3.INT1IE = 1;
    INTCON3.INT1IF = 0;
    // Int0/PORTB0 interrupt config
    // digital input
    TRISB.RB1 = 1;

    // Keypad rows
    // digital output
    TRISB.RB4 = 0;
    TRISB.RB5 = 0;
    TRISB.RB6 = 0;
    TRISB.RB7 = 0;
    // Init with low
    PORTB.RB4 = 0;
    PORTB.RB5 = 0;
    PORTB.RB6 = 0;
    PORTB.RB7 = 0;

    // Keypad cols
    // digital input
    TRISA.RA0 = 1;
    TRISA.RA1 = 1;
    TRISA.RA5 = 1;
    TRISB.RB3 = 1;

    // Led
    TRISC.RC1 = 0;
    PORTC.RC1 = 0;

    // Switches
    INTCON.INT0IE = 1;
    INTCON.INT0IF = 0;
    TRISB.RB0 = 1;
    INTCON3.INT2IE = 1;
    INTCON3.INT2IF = 0;
    TRISB.RB2 = 1;

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
    TRISA.RA4 = 0;

    PORTA.RA2 = 0;
    PORTA.RA3 = 0;
    PORTA.RA4 = 0;
}


void keypadHandler()
{
    char i;
    KeyType type;
    int result;
    char rowCode = 0;
    char realCode = 0;
    char columnCode = 0;

    for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
    {

        PORTB = ~(1 << i) << 4;
        columnCode = PORTA.RA0 | (PORTA.RA1 << 1) |
                     (PORTA.RA5 << 2) | (PORTB.RB3) << 3;

    }
    rowCode = PORTB >> 4;
    PORTB = 0;

    realCode = rowCode | (columnCode << 4);
    result = keyHandler(realCode, &type);

    nPressed += 1;

    if(nPressed < 3)
    {   
        time *= 10;
        time += result;
    }
    else
    {
        time += (result * 0.1);
        time += 0.001;
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
    int number = ((int)((time - timeCounter)*10)/pot) % 10;
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
