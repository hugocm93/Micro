#line 1 "C:/Users/hugocm93/Desktop/Micro/lab5/lab5.2/motor.c"
volatile float percent = 0;
volatile unsigned short duty = 0;

void main(void)
{

 adcon1 = 0x04;


 trisa.an0 = 1;


 PWM1_Init(5000);
 PWM1_Start();

 while(1)
 {

 percent = ADC_Read(0)/1023.0;
 duty = percent*255;
 PWM1_Set_Duty(duty);


 Delay_ms(100);
 }

}
