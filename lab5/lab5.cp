#line 1 "C:/Users/marco/Documents/Faculdade/Micro/Micro-master/Micro/lab5/lab5.c"





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



volatile int pulse_count=0;
volatile float freq=0;
volatile char str[20];

void interrupt()
{
 if (INTCON.TMR0IF)
 {
 freq = pulse_count/1.0;

 TMR0H =  (0xffff - 2*3907)  >> 8;
 TMR0L =  (0xffff - 2*3907) ;
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
trisb.rb0 = 1;



T0CON.T08BIT = 0;
T0CON.T0CS = 0;
T0CON.PSA = 0;


T0CON.T0PS2 = 1;
T0CON.T0PS1 = 1;
T0CON.T0PS0 = 1;


TMR0H =  (0xffff - 2*3907)  >> 8;
TMR0L =  (0xffff - 2*3907) ;


INTCON.TMR0IF=0;
INTCON.TMR0IE=1;

T0CON.TMR0ON=1;





while(1)
{
 FloatToStr(freq, str);
 lcd_cmd(_LCD_CLEAR);
 lcd_out(1,1,str);
 Delay_ms(1000);
}

}
