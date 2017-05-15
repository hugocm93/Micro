#define WINDOW 0.5

//(8Mhz/4)/256 => 128us x 7814/2 = WINDOW
#define COUNTER (0xffff - 7814/2)

// (8MHz / 4 ) / 2 => 1us x 60000 = 0.06s
#define COUNTER3 ( 0xffff - 60000 )

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

//motor vars
volatile float percent = 0;
volatile unsigned short duty = 0;
volatile int pulse_count = 0;
volatile float freq = 0;
volatile char str[20];
volatile int tempSetPoint = 0;
volatile int setPoint = 0;
volatile int u0 = 128;
volatile int error = 0;
volatile int duty = 0;
volatile int P = 0, I = 0;

const int kp = 100, ki = 1;

typedef enum keyType{
        EQUALS, SUM, SUB, MULT, DIVI, ON_CLEAR, NUM, EMPTY
}KeyType;

// Keypad functions and vars
int keyHandler(int key, KeyType* type);
void keypadHandler();

void interrupt(void)
{
    if (intcon.tmr0if)
    {
        // Load Timer 0 COUNTER
        tmr0h = COUNTER >> 8;  // Load Timer 0 COUNTER - 1st TMR0H
        tmr0l = COUNTER;       // Load Timer 0 COUNTER - 2nd TMR0L

        freq = pulse_count/WINDOW;
        pulse_count = 0;

        error = freq/64 - setPoint;
        I += error;
        duty = u0 + kp*error + ki*I;

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

        //start timer 3
        tmr3h = COUNTER3 >> 8;  
        tmr3l = COUNTER3;      
        pir2.tmr3if = 0;
        pie2.tmr3ie = 1;
        t3con.tmr3on = 1;

        // stop interruption
        intcon3.int1ie = 0;
        intcon3.int1if = 0;
    }

    if(pir2.tmr3if) // related to bouncing
    {
        pir2.tmr3if = 0;
        pie2.tmr3ie = 0;
        t3con.tmr3on = 0;

        // resume interruption
        intcon3.int1ie = 1;
        intcon3.int1if = 0;
    }
}

void main()
{
    //Definir porta analogica
    adcon1 = 0x04;

    Lcd_init();

    // an0 como entrada
    trisa.an0 = 1;

    //Inicializando pwm
    PWM1_Init(2000); 
    PWM1_Start(); 

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
    // load timer 0 COUNTER
    tmr0h = COUNTER >> 8;  // load timer 0 COUNTER - 1st tmr0h
    tmr0l = COUNTER;       // load timer 0 COUNTER - 2nd tmr0l
    // timer 0 interrupt
    intcon.tmr0if=0;
    intcon.tmr0ie=1;
    // start timer 0
    t0con.tmr0on=1;         // timer on

    // timer 3 configuration
    t3con.rd16 = 1;
    t3con.t3ccp2 = 1;
    t3con.t3ckps1 = 0;
    t3con.t3ckps0 = 1;
    t3con.tmr3cs = 0;

    // external interrupt
    intcon3.int1ie = 1;
    intcon3.int1if = 0;
    // int0/portb0 interrupt config
    // digital input
    trisb.rb1 = 1;

    // keypad rows
    // digital output
    trisb.rb4 = 0;
    trisb.rb5 = 0;
    trisb.rb6 = 0;
    trisb.rb7 = 0;
    // init with low
    portb.rb4 = 0;
    portb.rb5 = 0;
    portb.rb6 = 0;
    portb.rb7 = 0;

    // keypad cols
    // digital input
    trisa.ra2 = 1;
    trisa.ra4 = 1;
    trisa.ra5 = 1;
    trisb.rb3 = 1;

    while(1)
    {
        lcd_cmd(_LCD_CLEAR);
        FloatToStr(freq/64, str);
        lcd_out(1,1,str);
        lcd_out(1,13,"RPM");

        IntToStr(setPoint, str);
        lcd_out(2,1,"SetPoint: ");
        lcd_out(2,11,str);

        // Atualiza duty de acorco com leitura analogica
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
