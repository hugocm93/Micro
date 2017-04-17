// LCD module connections
sbit LCD_EN at RE1_bit;
sbit LCD_RS at RE2_bit;
sbit LCD_D4 at RC4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_EN_Direction at TRISE1_bit;
sbit LCD_RS_Direction at TRISE2_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;

// (8MHz / 4 ) / 256 => 128us x 10 = 0.00128s
#define COUNTER ( 0xffff - 10 )

typedef enum keyType{
        EQUALS, SUM, SUB, MULT, DIVI, ON_CLEAR, NUM, EMPTY
}KeyType;

// Edge control
char edge = 1; 

//Alarm vars
const char[] activationCode = "*2025*";
const char[] deActivationCode = "+1830+";
volatile char columnCode = 0;
volatile KeyType operation = EMPTY;
volatile char nKeyPressed = 0;
volatile char[] rightKeysActivation = {0,0,0,0,0,0};
volatile char[] rightKeysDeActivation = {0,0,0,0,0,0};
volatile char isOn = 0;

// Messages
const char[] msg1 = "Alerta de intruso. ";
const char[] msg2 = " sensores ativados";
const char[] msg3 = "Alerta de possivel intruso ou sensor ";
const char[] msg4 = " com defeito";

// Keypad functions
int keyHandler(int key, KeyType* type);
void keypadHandler();

void interrupt(void)
{
  if(INTCON.TMR0IF)
  {
     INTCON.TMR0IE=0;
     TMR0H = COUNTER >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
     TMR0L = COUNTER;       // RE-Load Timer 0 counter - 2nd TMR0L
     
     INTCON.TMR0IF=0;
     INTCON.TMR0IE=1;
     timer += COUNTER;
  }

  if(INTCON.RBIF)
  {
    if(edge == 1 && (timer > 0.02))
    {
         keypadHandler();
         timer = 0;
	}

    edge = !edge;
    INTCON.RBIF = 0;
  }
}

void main()
{
	//LCD
	Lcd_Init();
	Lcd_Cmd(_LCD_CURSOR_OFF);

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
    ADCON1 = 0x04;

	// Sensors
	// digital input
	TRISA.RA5 = 1;
	TRISC.RC5 = 1;
	TRISC.RC6 = 1;
	TRISC.RC7 = 1;
	// analog input
	TRISA.RA0 = 1;
	TRISA.RA1 = 1;

    // Global Interrupt Enable
    INTCON.GIE = 1;
    INTCON.RBIE = 1;
    INTCON.RBIF = 0;

    // Int0/PORTB0 interrupt config
	// digital input
    TRISB.RB4 = 1; 
    TRISB.RB5 = 1; 
    TRISB.RB6 = 1;
    TRISB.RB7 = 1;

	// Keypad
	// digital output
    TRISB.RB0 = 0; 
    TRISB.RB1 = 0; 
    TRISB.RB2 = 0;
    TRISB.RB3 = 0;
	// Init with low
    PORTB.RB0 = 0; 
    PORTB.RB1 = 0;
    PORTB.RB2 = 0;
    PORTB.RB3 = 0;

	// Leds
    TRISC.RC0 = 0;
    TRISC.RC1 = 0; 
    TRISC.RC2 = 0;
    TRISC.RC3 = 0;
	// Init with low
    PORTC.RC0 = 0;
    PORTC.RC1 = 0;
    PORTC.RC2 = 0;
    PORTC.RC3 = 0;

	while(1)
	{
		Delay_ms(100);
		Lcd_Cmd(_LCD_CLEAR);
		if(isOn)
		{
			char activated = 0;

			int sensorCount = 0;
			float vSensor1 = (ADC_read(0)/1023) * 5;
			float vSensor2 = (ADC_read(1)/1023) * 5;

			PORTC.RC0 = PORTA.RA5;
			PORTC.RC1 = PORTC.RC5;
			PORTC.RC2 = PORTC.RC6;
			PORTC.RC3 = PORTC.RC7;

			sensorCount += PORTA.RA5;
			sensorCount += PORTC.RC5;
			sensorCount += PORTC.RC6;
			sensorCount += PORTC.RC7;
			sensorCount += vSensor1 >= 4 ? 1 : 0;
			sensorCount += vSensor2 > 3 ? 1 : 0;

			activated = sensorCount >= 2 ? 1 : 0;

			if(activated)
			{
				char[4] number;
				char[60] str;
				IntToStr(sensorCount, number);
	
				strcat(str, msg1);	
				strcat(str, number);	
				strcat(str, msg2);	

				Lcd_Out(1,1,str);
			}
			else
			{
				char[4] number;
				char[60] str;

				if(PORTA.RA5)
					number = "1";
	
				if(PORTC.RC5)
					number = "2";
	
				if(PORTC.RC6)
					number = "3";
	
				if(PORTC.RC7)
					number = "4";
	
				if(vSensor1 >= 4)
					number = "5";
	
				if(vSensor2 > 3)
					number = "6";
	
				strcat(str, msg3);	
				strcat(str, number);	
				strcat(str, msg4);	

				Lcd_Out(1,1,str);
			}
		}
		else
		{
			char[60] str;

			strcat(str, IntToStr(vSensor1, number));	
			strcat(str, "V ");	
			strcat(str, IntToStr(vSensor2, number));	
			strcat(str, "V");	

			Lcd_Out(1,1,str);
		}
	}
}

void keypadHandler()
{
    char i;
    KeyType type;
    int result;
	char[2] keyPressed;

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
		if(type == NUM)
		{
			IntToStr(result, keyPressed);
		}

		if(type == SUM)
			nKeyPressed = "+";

		if(type == SUB)
			nKeyPressed = "-";

		if(type == MULT)
			nKeyPressed = "*";

		if(type == DIVI)
			nKeyPressed = "/";

		rightKeysActivation[nKeyPressed] = strcmp(activationCode[nKeyPressed], keyPressed) == 0 ? 1 : 0;
		rightKeysDeActivation[nKeyPressed] = strcmp(DeActivationCode[nKeyPressed], keyPressed) == 0 ? 1 : 0;
		
		if(nKeyPressed == 6)
		{
			int i;
			char activationCounter = 0;
			char deActivationCounter = 0;
			for(i = 0; i < nKeyPressed; i++)
			{
				activationCounter += rightKeysActivation[i];
				deActivationCounter += rightKeysDeActivation[i];
			}
		
			if(activationCounter == 6)
			{
				isOn = 1;
			}
			
			if(deActivationCounter == 6)
			{
				isOn = 0;
			}
		}
	
		nKeyPressed = nKeyPressed == 6 ? 0 : nKeyPressed++;
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
     result = 7;
     break;

     case 219:
     *type = NUM;
     result = 8;
     break;

     case 187:
     *type = NUM;
     result = 9;
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
     result = 1;
     break;

     case 222:
     *type = NUM;
     result = 2;
     break;

     case 190:
     *type = NUM;
     result = 3;
     break;

     case 126:
     *type = DIVI;
     break;
    }

    return result;
}
