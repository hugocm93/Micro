//(8Mhz/4)/256 => 128us x 2*3907 = 1.0s

#define COUNTER (0xffff - 2*3907)

sbit lcd_rs at re1_bit;
sbit lcd_en at re2_bit;
sbit lcd_d4 at rd4_bit;
sbit lcd_d5 at rd5_bit;
sbit lcd_d6 at rd6_bit;
sbit lcd_d7 at rd7_bit;
sbit lcd_rs_direction at trise1_bit;
sbit lcd_en_direction at trise2_bit;
sbit lcd_d4_direction at trisd4_bit;
sbit lcd_d5_direction at trisd5_bit;
sbit lcd_d6_direction at trisd6_bit;
sbit lcd_d7_direction at trisd7_bit;

volatile int pulse_count=0;
volatile float freq=0;
volatile char str[20];

void interrupt()
{
    if (intcon.tmr0if)
    {
        freq = pulse_count/1.0;

        // Load Timer 0 counter
        tmr0h = COUNTER >> 8;  // Load Timer 0 counter - 1st TMR0H
        tmr0l = COUNTER;       // Load Timer 0 counter - 2nd TMR0L

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
    adcon1 = 0x06;

    Lcd_init();

    //Interrupcao 0
    intcon.gie = 1;
    intcon.peie = 1;
    intcon.int0ie = 1;
    intcon.int0if = 0;
    intcon.intedg0 = 1;
    trisb.rb0 = 1; //definindo rb0 como in


    // timer 0 configuration
    t0con.t08bit = 0;       // 16 bits
    t0con.t0cs = 0;         // internal clock => crystal/4
    t0con.psa = 0;          // prescaler on

    // prescaler = 111 => 1:256
    t0con.t0ps2 = 1;
    t0con.t0ps1 = 1;
    t0con.t0ps0 = 1;

    // load timer 0 counter
    tmr0h = COUNTER >> 8;  // load timer 0 counter - 1st tmr0h
    tmr0l = COUNTER;       // load timer 0 counter - 2nd tmr0l

    // timer 0 interrupt
    intcon.tmr0if=0;
    intcon.tmr0ie=1;
    // start timer 0
    t0con.tmr0on=1;         // timer on

    while(1)
    {
        lcd_cmd(_LCD_CLEAR);
        FloatToStr(freq, str);
        lcd_out(1,1,str);
        lcd_out(1,13,"Hz");

        Delay_ms(1000);
    }
}
