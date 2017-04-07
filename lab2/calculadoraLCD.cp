#line 1 "C:/Users/mplab.LCA-06/Downloads/Micro/lab2/calculadoraLCD.c"

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
 trisa = 0;
 PORTA = 0xf;


 ADCON1 = 0x6;


 Lcd_Init();


 INTCON.GIE = 1;


 TRISB.RB4 = 1;
 TRISB.RB5 = 1;
 TRISB.RB6 = 1;
 TRISB.RB7 = 1;

 INTCON.RBIE = 1;
 INTCON.RBIF = 0;

 while(1)
 {
 char i = 0;
 for(; i < 4; i++)
 {
 PORTA = ~(1 << i);
 }
 }
}
