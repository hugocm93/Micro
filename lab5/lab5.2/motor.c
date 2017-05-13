volatile float percent = 0;
volatile unsigned short duty = 0;

void main(void)
{
    //Definir porta analogica
    adcon1 = 0x04;

    // an0 como entrada
    trisa.an0 = 1;

    //Inicializando pwm
    PWM1_Init(5000); 
    PWM1_Start(); 

    while(1)
    {
        // Atualiza duty de acorco com leitura analogica
        percent = ADC_Read(0)/1023.0; 
        duty = percent*255;
        PWM1_Set_Duty(duty);

        //Delay entre leituras analogicas
        Delay_ms(100);
    }

}

