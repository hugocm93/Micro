
_interrupt:

;Temporizador.c,35 :: 		void interrupt(void)
;Temporizador.c,37 :: 		if(INTCON3.INT1IF)
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt0
;Temporizador.c,39 :: 		if(progMode)
	MOVF        _progMode+0, 0 
	IORWF       _progMode+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt1
;Temporizador.c,41 :: 		keypadHandler();
	CALL        _keypadHandler+0, 0
;Temporizador.c,42 :: 		}
L_interrupt1:
;Temporizador.c,44 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,47 :: 		INTCON3.INT1IE = 0;
	BCF         INTCON3+0, 3 
;Temporizador.c,48 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Temporizador.c,49 :: 		}
L_interrupt0:
;Temporizador.c,50 :: 		if(PIR1.TMR2IF) // Related to bouncing
	BTFSS       PIR1+0, 1 
	GOTO        L_interrupt2
;Temporizador.c,53 :: 		PIR1.TMR2IF=0;
	BCF         PIR1+0, 1 
;Temporizador.c,54 :: 		PIE1.TMR2IE=0;
	BCF         PIE1+0, 1 
;Temporizador.c,55 :: 		T2CON.TMR2ON=0;
	BCF         T2CON+0, 2 
;Temporizador.c,58 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;Temporizador.c,59 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Temporizador.c,62 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;Temporizador.c,63 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,66 :: 		INTCON3.INT2IE = 1;
	BSF         INTCON3+0, 4 
;Temporizador.c,67 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,68 :: 		}
L_interrupt2:
;Temporizador.c,69 :: 		if(INTCON.TMR0IF) //timer increment
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt3
;Temporizador.c,71 :: 		TMR0H = COUNTER0 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       251
	MOVWF       TMR0H+0 
;Temporizador.c,72 :: 		TMR0L = COUNTER0;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       29
	MOVWF       TMR0L+0 
;Temporizador.c,74 :: 		PORTC.RC0 = ~PORTC.RC0;
	BTG         PORTC+0, 0 
;Temporizador.c,76 :: 		if(!progMode)
	MOVF        _progMode+0, 0 
	IORWF       _progMode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt4
;Temporizador.c,78 :: 		timeCounter += 0.01;
	MOVF        _timeCounter+0, 0 
	MOVWF       R0 
	MOVF        _timeCounter+1, 0 
	MOVWF       R1 
	MOVF        _timeCounter+2, 0 
	MOVWF       R2 
	MOVF        _timeCounter+3, 0 
	MOVWF       R3 
	MOVLW       10
	MOVWF       R4 
	MOVLW       215
	MOVWF       R5 
	MOVLW       35
	MOVWF       R6 
	MOVLW       120
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _timeCounter+0 
	MOVF        R1, 0 
	MOVWF       _timeCounter+1 
	MOVF        R2, 0 
	MOVWF       _timeCounter+2 
	MOVF        R3, 0 
	MOVWF       _timeCounter+3 
;Temporizador.c,79 :: 		}
L_interrupt4:
;Temporizador.c,81 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;Temporizador.c,82 :: 		}
L_interrupt3:
;Temporizador.c,83 :: 		if(PIR2.TMR3IF) //Display 7seg
	BTFSS       PIR2+0, 1 
	GOTO        L_interrupt5
;Temporizador.c,85 :: 		TMR3H = COUNTER3 >> 8;  // RE-Load Timer 1 counter - 1st TMR1H
	MOVLW       252
	MOVWF       TMR3H+0 
;Temporizador.c,86 :: 		TMR3L = COUNTER3;       // RE-Load Timer 1 counter - 2nd TMR1L
	MOVLW       23
	MOVWF       TMR3L+0 
;Temporizador.c,88 :: 		nDigit = nDigit == 3 ? 0 : nDigit;
	MOVLW       0
	XORWF       _nDigit+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt53
	MOVLW       3
	XORWF       _nDigit+0, 0 
L__interrupt53:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt6
	CLRF        R0 
	CLRF        R1 
	GOTO        L_interrupt7
L_interrupt6:
	MOVF        _nDigit+0, 0 
	MOVWF       R0 
	MOVF        _nDigit+1, 0 
	MOVWF       R1 
L_interrupt7:
	MOVF        R0, 0 
	MOVWF       _nDigit+0 
	MOVF        R1, 0 
	MOVWF       _nDigit+1 
;Temporizador.c,90 :: 		pot = pot == 100 ? 1 : pot*10;
	MOVLW       0
	XORWF       _pot+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt54
	MOVLW       100
	XORWF       _pot+0, 0 
L__interrupt54:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
	MOVLW       1
	MOVWF       FLOC__interrupt+0 
	MOVLW       0
	MOVWF       FLOC__interrupt+1 
	GOTO        L_interrupt9
L_interrupt8:
	MOVF        _pot+0, 0 
	MOVWF       R0 
	MOVF        _pot+1, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__interrupt+0 
	MOVF        R1, 0 
	MOVWF       FLOC__interrupt+1 
L_interrupt9:
	MOVF        FLOC__interrupt+0, 0 
	MOVWF       _pot+0 
	MOVF        FLOC__interrupt+1, 0 
	MOVWF       _pot+1 
;Temporizador.c,92 :: 		PORTA.RA0 = 0;
	BCF         PORTA+0, 0 
;Temporizador.c,93 :: 		PORTA.RA1 = 0;
	BCF         PORTA+0, 1 
;Temporizador.c,94 :: 		PORTC.RC2 = 0;
	BCF         PORTC+0, 2 
;Temporizador.c,96 :: 		PORTD = display();
	CALL        _display+0, 0
	MOVF        R0, 0 
	MOVWF       PORTD+0 
;Temporizador.c,98 :: 		if(nDigit==0)
	MOVLW       0
	XORWF       _nDigit+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt55
	MOVLW       0
	XORWF       _nDigit+0, 0 
L__interrupt55:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt10
;Temporizador.c,99 :: 		PORTA.RA0 = 1;
	BSF         PORTA+0, 0 
L_interrupt10:
;Temporizador.c,100 :: 		if(nDigit==1)
	MOVLW       0
	XORWF       _nDigit+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt56
	MOVLW       1
	XORWF       _nDigit+0, 0 
L__interrupt56:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt11
;Temporizador.c,102 :: 		PORTD.RD7 = 1;
	BSF         PORTD+0, 7 
;Temporizador.c,103 :: 		PORTA.RA1 = 1;
	BSF         PORTA+0, 1 
;Temporizador.c,104 :: 		}
L_interrupt11:
;Temporizador.c,105 :: 		if(nDigit==2)
	MOVLW       0
	XORWF       _nDigit+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt57
	MOVLW       2
	XORWF       _nDigit+0, 0 
L__interrupt57:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt12
;Temporizador.c,106 :: 		PORTC.RC2 = 1;
	BSF         PORTC+0, 2 
L_interrupt12:
;Temporizador.c,108 :: 		nDigit++;
	MOVLW       1
	ADDWF       _nDigit+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _nDigit+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _nDigit+0 
	MOVF        R1, 0 
	MOVWF       _nDigit+1 
;Temporizador.c,110 :: 		PIR2.TMR3IF = 0;
	BCF         PIR2+0, 1 
;Temporizador.c,111 :: 		}
L_interrupt5:
;Temporizador.c,112 :: 		if(PIR1.TMR1IF) //Total timer
	BTFSS       PIR1+0, 0 
	GOTO        L_interrupt13
;Temporizador.c,114 :: 		PORTC.RC1 = 1;
	BSF         PORTC+0, 1 
;Temporizador.c,115 :: 		progMode = 1;
	MOVLW       1
	MOVWF       _progMode+0 
	MOVLW       0
	MOVWF       _progMode+1 
;Temporizador.c,117 :: 		PIR2.TMR3IF = 0;
	BCF         PIR2+0, 1 
;Temporizador.c,118 :: 		PIE2.TMR3IE = 0;
	BCF         PIE2+0, 1 
;Temporizador.c,119 :: 		T3CON.TMR3ON = 0;
	BCF         T3CON+0, 0 
;Temporizador.c,121 :: 		PORTA.RA0 = 0;
	BCF         PORTA+0, 0 
;Temporizador.c,122 :: 		PORTA.RA1 = 0;
	BCF         PORTA+0, 1 
;Temporizador.c,123 :: 		PORTC.RC2 = 0;
	BCF         PORTC+0, 2 
;Temporizador.c,125 :: 		PIR1.TMR1IF=0;
	BCF         PIR1+0, 0 
;Temporizador.c,126 :: 		PIE1.TMR1IE=0;
	BCF         PIE1+0, 0 
;Temporizador.c,127 :: 		T1CON.TMR1ON=0;
	BCF         T1CON+0, 0 
;Temporizador.c,128 :: 		}
L_interrupt13:
;Temporizador.c,129 :: 		if(INTCON.INT0IF)
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt14
;Temporizador.c,131 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;Temporizador.c,132 :: 		time = 0;
	CLRF        _time+0 
	CLRF        _time+1 
	CLRF        _time+2 
	CLRF        _time+3 
;Temporizador.c,133 :: 		timeCounter = 0;
	CLRF        _timeCounter+0 
	CLRF        _timeCounter+1 
	CLRF        _timeCounter+2 
	CLRF        _timeCounter+3 
;Temporizador.c,134 :: 		nPressed = 0;
	CLRF        _nPressed+0 
	CLRF        _nPressed+1 
;Temporizador.c,136 :: 		progMode = 1;
	MOVLW       1
	MOVWF       _progMode+0 
	MOVLW       0
	MOVWF       _progMode+1 
;Temporizador.c,138 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,141 :: 		INTCON.INT0IE = 0;
	BCF         INTCON+0, 4 
;Temporizador.c,142 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,143 :: 		}
L_interrupt14:
;Temporizador.c,144 :: 		if(INTCON3.INT2IF)
	BTFSS       INTCON3+0, 1 
	GOTO        L_interrupt15
;Temporizador.c,146 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,148 :: 		progMode = 0;
	CLRF        _progMode+0 
	CLRF        _progMode+1 
;Temporizador.c,151 :: 		TMR1H = COUNTER1 >> 8;  // RE-Load Timer 1 counter - 1st TMR1H
	MOVLW       10
	MOVWF       R4 
	MOVLW       215
	MOVWF       R5 
	MOVLW       35
	MOVWF       R6 
	MOVLW       124
	MOVWF       R7 
	MOVF        _time+0, 0 
	MOVWF       R0 
	MOVF        _time+1, 0 
	MOVWF       R1 
	MOVF        _time+2, 0 
	MOVWF       R2 
	MOVF        _time+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	SUBLW       255
	MOVWF       R3 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVLW       255
	SUBFWB      R4, 1 
	MOVF        R4, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVF        R0, 0 
	MOVWF       TMR1H+0 
;Temporizador.c,152 :: 		TMR1L = COUNTER1;       // RE-Load Timer 1 counter - 2nd TMR1L
	MOVLW       10
	MOVWF       R4 
	MOVLW       215
	MOVWF       R5 
	MOVLW       35
	MOVWF       R6 
	MOVLW       124
	MOVWF       R7 
	MOVF        _time+0, 0 
	MOVWF       R0 
	MOVF        _time+1, 0 
	MOVWF       R1 
	MOVF        _time+2, 0 
	MOVWF       R2 
	MOVF        _time+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	SUBLW       255
	MOVWF       TMR1L+0 
;Temporizador.c,153 :: 		PIR1.TMR1IF=0;
	BCF         PIR1+0, 0 
;Temporizador.c,154 :: 		PIE1.TMR1IE=1;
	BSF         PIE1+0, 0 
;Temporizador.c,155 :: 		T1CON.TMR1ON=1;
	BSF         T1CON+0, 0 
;Temporizador.c,158 :: 		TMR3H = COUNTER3 >> 8;  // RE-Load Timer 1 counter - 1st TMR1H
	MOVLW       252
	MOVWF       TMR3H+0 
;Temporizador.c,159 :: 		TMR3L = COUNTER3;       // RE-Load Timer 1 counter - 2nd TMR1L
	MOVLW       23
	MOVWF       TMR3L+0 
;Temporizador.c,160 :: 		PIR2.TMR3IF = 0;
	BCF         PIR2+0, 1 
;Temporizador.c,161 :: 		PIE2.TMR3IE = 1;
	BSF         PIE2+0, 1 
;Temporizador.c,162 :: 		T3CON.TMR3ON = 1;
	BSF         T3CON+0, 0 
;Temporizador.c,165 :: 		INTCON3.INT2IE = 0;
	BCF         INTCON3+0, 4 
;Temporizador.c,166 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,167 :: 		}
L_interrupt15:
;Temporizador.c,169 :: 		}
L_end_interrupt:
L__interrupt52:
	RETFIE      1
; end of _interrupt

_loadTimer2:

;Temporizador.c,171 :: 		void loadTimer2()
;Temporizador.c,174 :: 		TMR2 = COUNTER2;
	MOVLW       127
	MOVWF       TMR2+0 
;Temporizador.c,176 :: 		PIR1.TMR2IF=0;
	BCF         PIR1+0, 1 
;Temporizador.c,177 :: 		PIE1.TMR2IE=1;
	BSF         PIE1+0, 1 
;Temporizador.c,179 :: 		T2CON.TMR2ON = 1;
	BSF         T2CON+0, 2 
;Temporizador.c,180 :: 		}
L_end_loadTimer2:
	RETURN      0
; end of _loadTimer2

_main:

;Temporizador.c,182 :: 		void main()
;Temporizador.c,185 :: 		ADCON1 = 0x06;
	MOVLW       6
	MOVWF       ADCON1+0 
;Temporizador.c,188 :: 		T0CON.T08BIT = 0;       // 16 bits
	BCF         T0CON+0, 6 
;Temporizador.c,189 :: 		T0CON.T0CS = 0;         // Internal clock => Crystal/4
	BCF         T0CON+0, 5 
;Temporizador.c,190 :: 		T0CON.PSA = 0;          // Prescaler ON
	BCF         T0CON+0, 3 
;Temporizador.c,192 :: 		T0CON.T0PS2 = 0;
	BCF         T0CON+0, 2 
;Temporizador.c,193 :: 		T0CON.T0PS1 = 1;
	BSF         T0CON+0, 1 
;Temporizador.c,194 :: 		T0CON.T0PS0 = 1;
	BSF         T0CON+0, 0 
;Temporizador.c,196 :: 		TMR0H = COUNTER0 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       251
	MOVWF       TMR0H+0 
;Temporizador.c,197 :: 		TMR0L = COUNTER0;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       29
	MOVWF       TMR0L+0 
;Temporizador.c,198 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;Temporizador.c,199 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;Temporizador.c,200 :: 		T0CON.TMR0ON=1;
	BSF         T0CON+0, 7 
;Temporizador.c,203 :: 		TRISC.RC0 = 0;
	BCF         TRISC+0, 0 
;Temporizador.c,204 :: 		PORTC.RC0 = 0;
	BCF         PORTC+0, 0 
;Temporizador.c,205 :: 		T1CON.RD16 = 1;        // Read/Write in two 8 bits oper
	BSF         T1CON+0, 7 
;Temporizador.c,206 :: 		T1CON.T1OSCEN = 0;     // Disable internal Oscilator
	BCF         T1CON+0, 3 
;Temporizador.c,207 :: 		T1CON.TMR1CS = 1;      // External clock from RC0
	BSF         T1CON+0, 1 
;Temporizador.c,208 :: 		T1CON.T1SYNC = 1;      // Do not synchronize ext clock
	BSF         T1CON+0, 2 
;Temporizador.c,210 :: 		T1CON.T1CKPS1 = 1;
	BSF         T1CON+0, 5 
;Temporizador.c,211 :: 		T1CON.T1CKPS0 = 1;
	BSF         T1CON+0, 4 
;Temporizador.c,215 :: 		T2CON.T2CKPS1 = 1;
	BSF         T2CON+0, 1 
;Temporizador.c,216 :: 		T2CON.T2CKPS0 = 1;
	BSF         T2CON+0, 0 
;Temporizador.c,219 :: 		T3CON.RD16 = 1;
	BSF         T3CON+0, 7 
;Temporizador.c,220 :: 		T3CON.T3CCP2 = 1;
	BSF         T3CON+0, 6 
;Temporizador.c,221 :: 		T3CON.T3CKPS1 = 0;
	BCF         T3CON+0, 5 
;Temporizador.c,222 :: 		T3CON.T3CKPS0 = 1;
	BSF         T3CON+0, 4 
;Temporizador.c,223 :: 		T3CON.TMR3CS = 0;
	BCF         T3CON+0, 1 
;Temporizador.c,226 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;Temporizador.c,227 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;Temporizador.c,228 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Temporizador.c,231 :: 		TRISB.RB1 = 1;
	BSF         TRISB+0, 1 
;Temporizador.c,235 :: 		TRISB.RB4 = 0;
	BCF         TRISB+0, 4 
;Temporizador.c,236 :: 		TRISB.RB5 = 0;
	BCF         TRISB+0, 5 
;Temporizador.c,237 :: 		TRISB.RB6 = 0;
	BCF         TRISB+0, 6 
;Temporizador.c,238 :: 		TRISB.RB7 = 0;
	BCF         TRISB+0, 7 
;Temporizador.c,240 :: 		PORTB.RB4 = 0;
	BCF         PORTB+0, 4 
;Temporizador.c,241 :: 		PORTB.RB5 = 0;
	BCF         PORTB+0, 5 
;Temporizador.c,242 :: 		PORTB.RB6 = 0;
	BCF         PORTB+0, 6 
;Temporizador.c,243 :: 		PORTB.RB7 = 0;
	BCF         PORTB+0, 7 
;Temporizador.c,247 :: 		TRISA.RA2 = 1;
	BSF         TRISA+0, 2 
;Temporizador.c,248 :: 		TRISA.RA4 = 1;
	BSF         TRISA+0, 4 
;Temporizador.c,249 :: 		TRISA.RA5 = 1;
	BSF         TRISA+0, 5 
;Temporizador.c,250 :: 		TRISB.RB3 = 1;
	BSF         TRISB+0, 3 
;Temporizador.c,253 :: 		TRISC.RC1 = 0;
	BCF         TRISC+0, 1 
;Temporizador.c,254 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;Temporizador.c,257 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;Temporizador.c,258 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,259 :: 		TRISB.RB0 = 1;
	BSF         TRISB+0, 0 
;Temporizador.c,260 :: 		INTCON3.INT2IE = 1;
	BSF         INTCON3+0, 4 
;Temporizador.c,261 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,262 :: 		TRISB.RB2 = 1;
	BSF         TRISB+0, 2 
;Temporizador.c,265 :: 		TRISD.RD0 = 0; // digital output
	BCF         TRISD+0, 0 
;Temporizador.c,266 :: 		TRISD.RD1 = 0;
	BCF         TRISD+0, 1 
;Temporizador.c,267 :: 		TRISD.RD2 = 0;
	BCF         TRISD+0, 2 
;Temporizador.c,268 :: 		TRISD.RD3 = 0;
	BCF         TRISD+0, 3 
;Temporizador.c,269 :: 		TRISD.RD4 = 0;
	BCF         TRISD+0, 4 
;Temporizador.c,270 :: 		TRISD.RD5 = 0;
	BCF         TRISD+0, 5 
;Temporizador.c,271 :: 		TRISD.RD6 = 0;
	BCF         TRISD+0, 6 
;Temporizador.c,272 :: 		TRISD.RD7 = 0;
	BCF         TRISD+0, 7 
;Temporizador.c,274 :: 		PORTD.RD0 = 0;
	BCF         PORTD+0, 0 
;Temporizador.c,275 :: 		PORTD.RD1 = 0;
	BCF         PORTD+0, 1 
;Temporizador.c,276 :: 		PORTD.RD2 = 0;
	BCF         PORTD+0, 2 
;Temporizador.c,277 :: 		PORTD.RD3 = 0;
	BCF         PORTD+0, 3 
;Temporizador.c,278 :: 		PORTD.RD4 = 0;
	BCF         PORTD+0, 4 
;Temporizador.c,279 :: 		PORTD.RD5 = 0;
	BCF         PORTD+0, 5 
;Temporizador.c,280 :: 		PORTD.RD6 = 0;
	BCF         PORTD+0, 6 
;Temporizador.c,281 :: 		PORTD.RD7 = 0;
	BCF         PORTD+0, 7 
;Temporizador.c,283 :: 		TRISA.RA0 = 0; // digital output
	BCF         TRISA+0, 0 
;Temporizador.c,284 :: 		TRISA.RA1 = 0;
	BCF         TRISA+0, 1 
;Temporizador.c,285 :: 		TRISC.RC2 = 0;
	BCF         TRISC+0, 2 
;Temporizador.c,287 :: 		PORTA.RA0 = 0;
	BCF         PORTA+0, 0 
;Temporizador.c,288 :: 		PORTA.RA1 = 0;
	BCF         PORTA+0, 1 
;Temporizador.c,289 :: 		PORTC.RC2 = 0;
	BCF         PORTC+0, 2 
;Temporizador.c,290 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_keypadHandler:

;Temporizador.c,293 :: 		void keypadHandler()
;Temporizador.c,298 :: 		char rowCode = 0;
;Temporizador.c,299 :: 		char realCode = 0;
;Temporizador.c,300 :: 		char columnCode = 0;
	CLRF        keypadHandler_columnCode_L0+0 
;Temporizador.c,302 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	CLRF        keypadHandler_i_L0+0 
	MOVLW       15
	MOVWF       keypadHandler_columnCode_L0+0 
L_keypadHandler16:
	MOVF        keypadHandler_columnCode_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler17
;Temporizador.c,305 :: 		PORTB = ~(1 << i) << 4;
	MOVF        keypadHandler_i_L0+0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__keypadHandler61:
	BZ          L__keypadHandler62
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__keypadHandler61
L__keypadHandler62:
	COMF        R0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       PORTB+0 
;Temporizador.c,306 :: 		columnCode = PORTA.RA2 | (PORTA.RA4 << 1) |
	CLRF        R2 
	BTFSC       PORTA+0, 4 
	INCF        R2, 1 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVLW       0
	BTFSC       PORTA+0, 2 
	MOVLW       1
	MOVWF       keypadHandler_columnCode_L0+0 
	MOVF        R0, 0 
	IORWF       keypadHandler_columnCode_L0+0, 1 
;Temporizador.c,307 :: 		(PORTA.RA5 << 2) | (PORTB.RB3) << 3;
	CLRF        R3 
	BTFSC       PORTA+0, 5 
	INCF        R3, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	IORWF       keypadHandler_columnCode_L0+0, 1 
	CLRF        R3 
	BTFSC       PORTB+0, 3 
	INCF        R3, 1 
	MOVLW       3
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__keypadHandler63:
	BZ          L__keypadHandler64
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__keypadHandler63
L__keypadHandler64:
	MOVF        R0, 0 
	IORWF       keypadHandler_columnCode_L0+0, 1 
;Temporizador.c,302 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	INCF        keypadHandler_i_L0+0, 1 
;Temporizador.c,309 :: 		}
	GOTO        L_keypadHandler16
L_keypadHandler17:
;Temporizador.c,310 :: 		rowCode = PORTB >> 4;
	MOVLW       4
	MOVWF       R0 
	MOVF        PORTB+0, 0 
	MOVWF       FARG_keyHandler_key+0 
	MOVLW       0
	MOVWF       FARG_keyHandler_key+1 
	MOVF        R0, 0 
L__keypadHandler65:
	BZ          L__keypadHandler66
	RRCF        FARG_keyHandler_key+0, 1 
	BCF         FARG_keyHandler_key+0, 7 
	ADDLW       255
	GOTO        L__keypadHandler65
L__keypadHandler66:
;Temporizador.c,311 :: 		PORTB = 0;
	CLRF        PORTB+0 
;Temporizador.c,313 :: 		realCode = rowCode | (columnCode << 4);
	MOVF        keypadHandler_columnCode_L0+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	IORWF       FARG_keyHandler_key+0, 0 
	MOVWF       FARG_keyHandler_key+0 
;Temporizador.c,314 :: 		result = keyHandler(realCode, &type);
	MOVLW       0
	MOVWF       FARG_keyHandler_key+1 
	MOVLW       keypadHandler_type_L0+0
	MOVWF       FARG_keyHandler_type+0 
	MOVLW       hi_addr(keypadHandler_type_L0+0)
	MOVWF       FARG_keyHandler_type+1 
	CALL        _keyHandler+0, 0
	MOVF        R0, 0 
	MOVWF       keypadHandler_result_L0+0 
	MOVF        R1, 0 
	MOVWF       keypadHandler_result_L0+1 
;Temporizador.c,316 :: 		nPressed += 1;
	INFSNZ      _nPressed+0, 1 
	INCF        _nPressed+1, 1 
;Temporizador.c,318 :: 		if(nPressed < 3)
	MOVLW       128
	XORWF       _nPressed+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler67
	MOVLW       3
	SUBWF       _nPressed+0, 0 
L__keypadHandler67:
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadHandler19
;Temporizador.c,320 :: 		time *= 10;
	MOVF        _time+0, 0 
	MOVWF       R0 
	MOVF        _time+1, 0 
	MOVWF       R1 
	MOVF        _time+2, 0 
	MOVWF       R2 
	MOVF        _time+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _time+0 
	MOVF        R1, 0 
	MOVWF       _time+1 
	MOVF        R2, 0 
	MOVWF       _time+2 
	MOVF        R3, 0 
	MOVWF       _time+3 
;Temporizador.c,321 :: 		time += result;
	MOVF        keypadHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keypadHandler_result_L0+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        _time+0, 0 
	MOVWF       R4 
	MOVF        _time+1, 0 
	MOVWF       R5 
	MOVF        _time+2, 0 
	MOVWF       R6 
	MOVF        _time+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _time+0 
	MOVF        R1, 0 
	MOVWF       _time+1 
	MOVF        R2, 0 
	MOVWF       _time+2 
	MOVF        R3, 0 
	MOVWF       _time+3 
;Temporizador.c,322 :: 		}
	GOTO        L_keypadHandler20
L_keypadHandler19:
;Temporizador.c,325 :: 		time += (result * 0.1);
	MOVF        keypadHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keypadHandler_result_L0+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       123
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        _time+0, 0 
	MOVWF       R4 
	MOVF        _time+1, 0 
	MOVWF       R5 
	MOVF        _time+2, 0 
	MOVWF       R6 
	MOVF        _time+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _time+0 
	MOVF        R1, 0 
	MOVWF       _time+1 
	MOVF        R2, 0 
	MOVWF       _time+2 
	MOVF        R3, 0 
	MOVWF       _time+3 
;Temporizador.c,326 :: 		time += 0.001;
	MOVF        _time+0, 0 
	MOVWF       R0 
	MOVF        _time+1, 0 
	MOVWF       R1 
	MOVF        _time+2, 0 
	MOVWF       R2 
	MOVF        _time+3, 0 
	MOVWF       R3 
	MOVLW       111
	MOVWF       R4 
	MOVLW       18
	MOVWF       R5 
	MOVLW       3
	MOVWF       R6 
	MOVLW       117
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _time+0 
	MOVF        R1, 0 
	MOVWF       _time+1 
	MOVF        R2, 0 
	MOVWF       _time+2 
	MOVF        R3, 0 
	MOVWF       _time+3 
;Temporizador.c,327 :: 		}
L_keypadHandler20:
;Temporizador.c,328 :: 		}
L_end_keypadHandler:
	RETURN      0
; end of _keypadHandler

_keyHandler:

;Temporizador.c,331 :: 		int keyHandler (int key, KeyType* type)
;Temporizador.c,333 :: 		int result = -1;
	MOVLW       255
	MOVWF       keyHandler_result_L0+0 
	MOVLW       255
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,334 :: 		switch(key)
	GOTO        L_keyHandler21
;Temporizador.c,336 :: 		case 231:
L_keyHandler23:
;Temporizador.c,337 :: 		*type = ON_CLEAR;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       5
	MOVWF       POSTINC1+0 
;Temporizador.c,338 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,340 :: 		case 215:
L_keyHandler24:
;Temporizador.c,341 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,342 :: 		result = 0;
	CLRF        keyHandler_result_L0+0 
	CLRF        keyHandler_result_L0+1 
;Temporizador.c,343 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,345 :: 		case 183:
L_keyHandler25:
;Temporizador.c,346 :: 		*type = EQUALS;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	CLRF        POSTINC1+0 
;Temporizador.c,347 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,349 :: 		case 119:
L_keyHandler26:
;Temporizador.c,350 :: 		*type = SUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
;Temporizador.c,351 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,353 :: 		case 235:
L_keyHandler27:
;Temporizador.c,354 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,355 :: 		result = 1;
	MOVLW       1
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,356 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,358 :: 		case 219:
L_keyHandler28:
;Temporizador.c,359 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,360 :: 		result = 2;
	MOVLW       2
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,361 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,363 :: 		case 187:
L_keyHandler29:
;Temporizador.c,364 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,365 :: 		result = 3;
	MOVLW       3
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,366 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,368 :: 		case 123:
L_keyHandler30:
;Temporizador.c,369 :: 		*type = SUB;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       2
	MOVWF       POSTINC1+0 
;Temporizador.c,370 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,372 :: 		case 237:
L_keyHandler31:
;Temporizador.c,373 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,374 :: 		result = 4;
	MOVLW       4
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,375 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,377 :: 		case 221:
L_keyHandler32:
;Temporizador.c,378 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,379 :: 		result = 5;
	MOVLW       5
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,380 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,382 :: 		case 189:
L_keyHandler33:
;Temporizador.c,383 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,384 :: 		result = 6;
	MOVLW       6
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,385 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,387 :: 		case 125:
L_keyHandler34:
;Temporizador.c,388 :: 		*type = MULT;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       3
	MOVWF       POSTINC1+0 
;Temporizador.c,389 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,391 :: 		case 238:
L_keyHandler35:
;Temporizador.c,392 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,393 :: 		result = 7;
	MOVLW       7
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,394 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,396 :: 		case 222:
L_keyHandler36:
;Temporizador.c,397 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,398 :: 		result = 8;
	MOVLW       8
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,399 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,401 :: 		case 190:
L_keyHandler37:
;Temporizador.c,402 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,403 :: 		result = 9;
	MOVLW       9
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,404 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,406 :: 		case 126:
L_keyHandler38:
;Temporizador.c,407 :: 		*type = DIVI;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       4
	MOVWF       POSTINC1+0 
;Temporizador.c,408 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,409 :: 		}
L_keyHandler21:
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler69
	MOVLW       231
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler69:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler23
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler70
	MOVLW       215
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler70:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler24
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler71
	MOVLW       183
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler71:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler25
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler72
	MOVLW       119
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler72:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler26
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler73
	MOVLW       235
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler73:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler27
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler74
	MOVLW       219
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler74:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler28
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler75
	MOVLW       187
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler75:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler29
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler76
	MOVLW       123
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler76:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler30
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler77
	MOVLW       237
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler77:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler31
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler78
	MOVLW       221
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler78:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler32
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler79
	MOVLW       189
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler79:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler33
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler80
	MOVLW       125
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler80:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler34
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler81
	MOVLW       238
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler81:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler35
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler82
	MOVLW       222
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler82:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler36
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler83
	MOVLW       190
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler83:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler37
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler84
	MOVLW       126
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler84:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler38
L_keyHandler22:
;Temporizador.c,411 :: 		return result;
	MOVF        keyHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keyHandler_result_L0+1, 0 
	MOVWF       R1 
;Temporizador.c,412 :: 		}
L_end_keyHandler:
	RETURN      0
; end of _keyHandler

_display:

;Temporizador.c,415 :: 		unsigned int display ()
;Temporizador.c,417 :: 		int number = ((int)((time - timeCounter)*10)/pot) % 10;
	MOVF        _timeCounter+0, 0 
	MOVWF       R4 
	MOVF        _timeCounter+1, 0 
	MOVWF       R5 
	MOVF        _timeCounter+2, 0 
	MOVWF       R6 
	MOVF        _timeCounter+3, 0 
	MOVWF       R7 
	MOVF        _time+0, 0 
	MOVWF       R0 
	MOVF        _time+1, 0 
	MOVWF       R1 
	MOVF        _time+2, 0 
	MOVWF       R2 
	MOVF        _time+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Int+0, 0
	MOVF        _pot+0, 0 
	MOVWF       R4 
	MOVF        _pot+1, 0 
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       display_number_L0+0 
	MOVF        R1, 0 
	MOVWF       display_number_L0+1 
;Temporizador.c,418 :: 		switch(number)
	GOTO        L_display39
;Temporizador.c,420 :: 		case 0: return 0x3F;
L_display41:
	MOVLW       63
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,421 :: 		case 1: return 0x06;
L_display42:
	MOVLW       6
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,422 :: 		case 2: return 0x5B;
L_display43:
	MOVLW       91
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,423 :: 		case 3: return 0x4F;
L_display44:
	MOVLW       79
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,424 :: 		case 4: return 0x66;
L_display45:
	MOVLW       102
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,425 :: 		case 5: return 0x6D;
L_display46:
	MOVLW       109
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,426 :: 		case 6: return 0x7D;
L_display47:
	MOVLW       125
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,427 :: 		case 7: return 0x07;
L_display48:
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,428 :: 		case 8: return 0x7F;
L_display49:
	MOVLW       127
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,429 :: 		case 9: return 0x6F;
L_display50:
	MOVLW       111
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,430 :: 		}
L_display39:
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display86
	MOVLW       0
	XORWF       display_number_L0+0, 0 
L__display86:
	BTFSC       STATUS+0, 2 
	GOTO        L_display41
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display87
	MOVLW       1
	XORWF       display_number_L0+0, 0 
L__display87:
	BTFSC       STATUS+0, 2 
	GOTO        L_display42
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display88
	MOVLW       2
	XORWF       display_number_L0+0, 0 
L__display88:
	BTFSC       STATUS+0, 2 
	GOTO        L_display43
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display89
	MOVLW       3
	XORWF       display_number_L0+0, 0 
L__display89:
	BTFSC       STATUS+0, 2 
	GOTO        L_display44
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display90
	MOVLW       4
	XORWF       display_number_L0+0, 0 
L__display90:
	BTFSC       STATUS+0, 2 
	GOTO        L_display45
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display91
	MOVLW       5
	XORWF       display_number_L0+0, 0 
L__display91:
	BTFSC       STATUS+0, 2 
	GOTO        L_display46
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display92
	MOVLW       6
	XORWF       display_number_L0+0, 0 
L__display92:
	BTFSC       STATUS+0, 2 
	GOTO        L_display47
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display93
	MOVLW       7
	XORWF       display_number_L0+0, 0 
L__display93:
	BTFSC       STATUS+0, 2 
	GOTO        L_display48
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display94
	MOVLW       8
	XORWF       display_number_L0+0, 0 
L__display94:
	BTFSC       STATUS+0, 2 
	GOTO        L_display49
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display95
	MOVLW       9
	XORWF       display_number_L0+0, 0 
L__display95:
	BTFSC       STATUS+0, 2 
	GOTO        L_display50
;Temporizador.c,431 :: 		}
L_end_display:
	RETURN      0
; end of _display
