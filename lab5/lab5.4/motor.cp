#line 1 "C:/Users/mplab.LCA-06/Downloads/Micro/lab5/lab5.4/motor.c"








sbit lcd_rs at re2_bit;
sbit lcd_en at re1_bit;
sbit lcd_d4 at rd4_bit;
sbit lcd_d5 at rd5_bit;
sbit lcd_d6 at rd6_bit;
sbit lcd_d7 at rd7_bit;
sbit lcd_rs_direction at trise2_bit;
sbit lcd_en_direction at trise1_bit;
sbit lcd_d4_direction at trisd4_bit;
sbit lcd_d5_direction at trisd5_bit;
sbit lcd_d6_direction at trisd6_bit;
sbit lcd_d7_direction at trisd7_bit;


volatile float percent = 0;
volatile unsigned short duty = 0;
volatile int pulse_count = 0;
volatile float freq = 0;
volatile char str[20];
volatile int tempSetPoint = 0;
volatile int setPoint = 0;

typedef enum keyType{
 EQUALS, SUM, SUB, MULT, DIVI, ON_CLEAR, NUM, EMPTY
}KeyType;


int keyHandler(int key, KeyType* type);
void keypadHandler();

void interrupt(void)
{
 if (intcon.tmr0if)
 {

 tmr0h =  (0xffff - 7814/2)  >> 8;
 tmr0l =  (0xffff - 7814/2) ;

 freq = pulse_count/ 0.5 ;
 pulse_count = 0;

 intcon.tmr0if = 0;
 }

 if(intcon.int0if)
 {
 ++pulse_count;

 intcon.int0if=0;
 }

 if(intcon3.int1if)
 {
 keypadhandler();


 tmr3h =  ( 0xffff - 60000 )  >> 8;
 tmr3l =  ( 0xffff - 60000 ) ;
 pir2.tmr3if = 0;
 pie2.tmr3ie = 1;
 t3con.tmr3on = 1;


 intcon3.int1ie = 0;
 intcon3.int1if = 0;
 }

 if(pir2.tmr3if)
 {
 pir2.tmr3if = 0;
 pie2.tmr3ie = 0;
 t3con.tmr3on = 0;


 intcon3.int1ie = 1;
 intcon3.int1if = 0;
 }
}

void main()
{

 adcon1 = 0x04;

 Lcd_init();


 trisa.an0 = 1;


 PWM1_Init(2000);
 PWM1_Start();


 intcon.gie = 1;
 intcon.peie = 1;
 intcon.int0ie = 1;
 intcon.int0if = 0;
 intcon.intedg0 = 1;
 trisb.rb0 = 1;


 t0con.t08bit = 0;
 t0con.t0cs = 0;
 t0con.psa = 0;

 t0con.t0ps2 = 1;
 t0con.t0ps1 = 1;
 t0con.t0ps0 = 1;

 tmr0h =  (0xffff - 7814/2)  >> 8;
 tmr0l =  (0xffff - 7814/2) ;

 intcon.tmr0if=0;
 intcon.tmr0ie=1;

 t0con.tmr0on=1;


 t3con.rd16 = 1;
 t3con.t3ccp2 = 1;
 t3con.t3ckps1 = 0;
 t3con.t3ckps0 = 1;
 t3con.tmr3cs = 0;


 intcon3.int1ie = 1;
 intcon3.int1if = 0;


 trisb.rb1 = 1;



 trisb.rb4 = 0;
 trisb.rb5 = 0;
 trisb.rb6 = 0;
 trisb.rb7 = 0;

 portb.rb4 = 0;
 portb.rb5 = 0;
 portb.rb6 = 0;
 portb.rb7 = 0;



 trisa.ra2 = 1;
 trisa.ra4 = 1;
 trisa.ra5 = 1;
 trisb.rb3 = 1;

 while(1)
 {
 lcd_cmd(_LCD_CLEAR);
 FloatToStr(freq, str);
 lcd_out(1,1,str);
 lcd_out(1,13,"Hz");

 IntToStr(setPoint, str);
 lcd_out(2,1,"SetPoint: ");
 lcd_out(2,11,str);


 percent = ADC_Read(0)/1023.0;
 duty = percent*255;
 PWM1_Set_Duty(duty);

 Delay_ms(800);
 }
}

void keypadHandler()
{
 char i;
 KeyType type;
 int result;
 char rowCode = 0;
 char keycode = 0;
 char columnCode = 0;

 for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
 {

 PORTB = ~(1 << i) << 4;
 columnCode = PORTA.RA2 | (PORTA.RA4 << 1) |
 (PORTA.RA5 << 2) | (PORTB.RB3) << 3;

 }
 rowCode = PORTB >> 4;
 PORTB = 0;

 keycode = rowCode | (columnCode << 4);
 result = keyHandler(keycode, &type);

 if(type == NUM)
 {
 tempSetPoint *= 10;
 tempSetPoint += result;
 }
 else if(type == SUM)
 {
 setPoint = tempSetPoint;
 tempSetPoint = 0;
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
