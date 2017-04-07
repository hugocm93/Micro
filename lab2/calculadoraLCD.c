  // LCD module connections
  sbit LCD_EN at RE1_bit;
  sbit LCD_RS at RE2_bit;
  sbit LCD_D4 at RD4_bit;
  sbit LCD_D5 at RD5_bit;
  sbit LCD_D6 at RD6_bit;
  sbit LCD_D7 at RD7_bit;

  sbit LCD_EN_Direction at TRISE1_bit;
  sbit LCD_RS_Direction at TRISE2_bit;
  sbit LCD_D4_Direction at TRISD4_bit;
  sbit LCD_D5_Direction at TRISD5_bit;
  sbit LCD_D6_Direction at TRISD6_bit;
  sbit LCD_D7_Direction at TRISD7_bit;

// High priority interrupt function
volatile char xx;
void interrupt(void){
   if(INTCON.RBIF)
   {
    char text[7];
    char i;
    for(i = 0, xx = 0x0f; (i < 4) && (xx==0x0f); i++)
    {
    PORTB.RB0 = 1; // digital output
  PORTB.RB1 = 1;
  PORTB.RB2 = 1;
  PORTB.RB3 = 1;


     if(i==0)PORTB.RB0 = 0; // digital output
  if(i==1)PORTB.RB1 = 0;
  if(i==2)PORTB.RB2 = 0;
  if(i==3)PORTB.RB3 = 0;
     xx = PORTB >> 4;
    }

    Lcd_Cmd(_LCD_CLEAR);
    IntToStr(PORTB, text);
    Lcd_Out(1,1,text);

    INTCON.RBIF = 0;
    PORTB.RB0 = 0; // digital output
  PORTB.RB1 = 0;
  PORTB.RB2 = 0;
  PORTB.RB3 = 0;
   }
 }

void main()
{
  //Pins as digital I/O
  ADCON1 = 0x6;

  // Configuring display
  Lcd_Init();

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

  INTCON.RBIE = 1;
  INTCON.RBIF = 0;
}