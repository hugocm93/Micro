//(8Mhz/4)/256 => 128us x 2*3907 = 1.0s

#define COUNTER (0xffff - 2*3907)

// LCD module connections
sbit LCD_RS at RE1_bit;
sbit LCD_EN at RE2_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISE1_bit;
sbit LCD_EN_Direction at TRISE2_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;
// End LCD module connections


volatile int pulse_count=0;
volatile float freq=0;
volatile char str[20];

void interrupt()
{
    if (INTCON.TMR0IF)
    {
    freq = pulse_count/1.0;
    // Load Timer 0 counter
    TMR0H = COUNTER >> 8;  // Load Timer 0 counter - 1st TMR0H
    TMR0L = COUNTER;       // Load Timer 0 counter - 2nd TMR0L
    pulse_count = 0;
    intcon.tmr0if = 0;     
    }


    if(intcon.int0if)
    {
    ++pulse_count;
    intcon.int0if=0;
    }

}



void main() 
{
ADCON1 = 0x06;
Lcd_init();


intcon.gie = 1;
intcon.peie = 1;
intcon.int0ie = 1;
intcon.int0if = 0;
intcon.intedg0 = 1;
trisb.rb0 = 1; //definindo rb0 como in


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
INTCON.TMR0IF=0;
INTCON.TMR0IE=1;
// Start timer 0
T0CON.TMR0ON=1;         // Timer ON





while(1)
{
  FloatToStr(freq, str);
  lcd_cmd(_LCD_CLEAR);
  lcd_out(1,1,str);
  Delay_ms(1000);
}

}
