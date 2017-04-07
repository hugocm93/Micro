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
    char rows = PORTA;
    char text[7];
    xx = ~(PORTB) >> 4;
    xx += rows;
    Lcd_Cmd(_LCD_CLEAR);
    IntToStr(xx, text);
    Lcd_Out(1,1,text);
    INTCON.RBIF = 0;
   }
 }

void main()
{
  trisa = 0; //digital output
  PORTA = 0xf; //PORTA HIGH

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

  INTCON.RBIE = 1;
  INTCON.RBIF = 0;

  while(1)
  {
    char i = 0;
    for(; i < 4; i++)
    {
     PORTA = ~(1 << i); // varredura
    }
 }
}