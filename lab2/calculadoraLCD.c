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

  char edge = 1; //tratar mudan�a de n�vel

typedef enum keyType
{
        IGUAL, SOMA, SUB, MULT, DIVI, ON_CLEAR, NUM
}KeyType;

int convertTecla (int tecla, KeyType* type);

// High priority interrupt function
  volatile char xx;
  void interrupt(void){
   if(INTCON.RBIF)
   {
        char text[7];
        char i;
        KeyType type;
        int result;

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

    result = convertTecla(PORTB, &type);
    IntToStr(result, text);
    //Lcd_Out(1,1,text);

    PORTB.RB0 = 0; // digital output
    PORTB.RB1 = 0;
    PORTB.RB2 = 0;
    PORTB.RB3 = 0;

        if(edge == 1)
        {
         Lcd_Cmd(_LCD_CLEAR);
         Lcd_Out(1,1,text);
        }
        else
        {
         //Lcd_Out(1,1,"soltar");
        }

    edge = !edge;
    INTCON.RBIF = 0;
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

int convertTecla (int tecla, KeyType* type)
{
    int result = -1;
    switch(tecla)
    {
     case 231:
     *type = ON_CLEAR;
     break;

     case 215:
     *type = NUM;
     result = 0;
     break;

     case 183:
     *type = IGUAL;
     break;

     case 119:
     *type = SOMA;
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