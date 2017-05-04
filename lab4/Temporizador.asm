
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
;Temporizador.c,101 :: 		PORTA.RA1 = 1;
	BSF         PORTA+0, 1 
L_interrupt11:
;Temporizador.c,102 :: 		if(nDigit==2)
	MOVLW       0
	XORWF       _nDigit+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt57
	MOVLW       2
	XORWF       _nDigit+0, 0 
L__interrupt57:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt12
;Temporizador.c,103 :: 		PORTC.RC2 = 1;
	BSF         PORTC+0, 2 
L_interrupt12:
;Temporizador.c,105 :: 		nDigit++;
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
;Temporizador.c,107 :: 		PIR2.TMR3IF = 0;
	BCF         PIR2+0, 1 
;Temporizador.c,108 :: 		}
L_interrupt5:
;Temporizador.c,109 :: 		if(PIR1.TMR1IF) //Total timer
	BTFSS       PIR1+0, 0 
	GOTO        L_interrupt13
;Temporizador.c,111 :: 		PORTC.RC1 = 1;
	BSF         PORTC+0, 1 
;Temporizador.c,112 :: 		progMode = 1;
	MOVLW       1
	MOVWF       _progMode+0 
	MOVLW       0
	MOVWF       _progMode+1 
;Temporizador.c,114 :: 		PIR2.TMR3IF = 0;
	BCF         PIR2+0, 1 
;Temporizador.c,115 :: 		PIE2.TMR3IE = 0;
	BCF         PIE2+0, 1 
;Temporizador.c,116 :: 		T3CON.TMR3ON = 0;
	BCF         T3CON+0, 0 
;Temporizador.c,118 :: 		PIR1.TMR1IF=0;
	BCF         PIR1+0, 0 
;Temporizador.c,119 :: 		PIE1.TMR1IE=0;
	BCF         PIE1+0, 0 
;Temporizador.c,120 :: 		T1CON.TMR1ON=0;
	BCF         T1CON+0, 0 
;Temporizador.c,121 :: 		}
L_interrupt13:
;Temporizador.c,122 :: 		if(INTCON.INT0IF)
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt14
;Temporizador.c,124 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;Temporizador.c,125 :: 		time = 0;
	CLRF        _time+0 
	CLRF        _time+1 
	CLRF        _time+2 
	CLRF        _time+3 
;Temporizador.c,126 :: 		timeCounter = 0;
	CLRF        _timeCounter+0 
	CLRF        _timeCounter+1 
	CLRF        _timeCounter+2 
	CLRF        _timeCounter+3 
;Temporizador.c,127 :: 		nPressed = 0;
	CLRF        _nPressed+0 
	CLRF        _nPressed+1 
;Temporizador.c,129 :: 		progMode = 1;
	MOVLW       1
	MOVWF       _progMode+0 
	MOVLW       0
	MOVWF       _progMode+1 
;Temporizador.c,131 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,134 :: 		INTCON.INT0IE = 0;
	BCF         INTCON+0, 4 
;Temporizador.c,135 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,136 :: 		}
L_interrupt14:
;Temporizador.c,137 :: 		if(INTCON3.INT2IF)
	BTFSS       INTCON3+0, 1 
	GOTO        L_interrupt15
;Temporizador.c,139 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,141 :: 		progMode = 0;
	CLRF        _progMode+0 
	CLRF        _progMode+1 
;Temporizador.c,144 :: 		TMR1H = COUNTER1 >> 8;  // RE-Load Timer 1 counter - 1st TMR1H
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
;Temporizador.c,145 :: 		TMR1L = COUNTER1;       // RE-Load Timer 1 counter - 2nd TMR1L
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
;Temporizador.c,146 :: 		PIR1.TMR1IF=0;
	BCF         PIR1+0, 0 
;Temporizador.c,147 :: 		PIE1.TMR1IE=1;
	BSF         PIE1+0, 0 
;Temporizador.c,148 :: 		T1CON.TMR1ON=1;
	BSF         T1CON+0, 0 
;Temporizador.c,151 :: 		TMR3H = COUNTER3 >> 8;  // RE-Load Timer 1 counter - 1st TMR1H
	MOVLW       252
	MOVWF       TMR3H+0 
;Temporizador.c,152 :: 		TMR3L = COUNTER3;       // RE-Load Timer 1 counter - 2nd TMR1L
	MOVLW       23
	MOVWF       TMR3L+0 
;Temporizador.c,153 :: 		PIR2.TMR3IF = 0;
	BCF         PIR2+0, 1 
;Temporizador.c,154 :: 		PIE2.TMR3IE = 1;
	BSF         PIE2+0, 1 
;Temporizador.c,155 :: 		T3CON.TMR3ON = 1;
	BSF         T3CON+0, 0 
;Temporizador.c,158 :: 		INTCON3.INT2IE = 0;
	BCF         INTCON3+0, 4 
;Temporizador.c,159 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,160 :: 		}
L_interrupt15:
;Temporizador.c,162 :: 		}
L_end_interrupt:
L__interrupt52:
	RETFIE      1
; end of _interrupt

_loadTimer2:

;Temporizador.c,164 :: 		void loadTimer2()
;Temporizador.c,167 :: 		TMR2 = COUNTER2;
	MOVLW       127
	MOVWF       TMR2+0 
;Temporizador.c,169 :: 		PIR1.TMR2IF=0;
	BCF         PIR1+0, 1 
;Temporizador.c,170 :: 		PIE1.TMR2IE=1;
	BSF         PIE1+0, 1 
;Temporizador.c,172 :: 		T2CON.TMR2ON = 1;
	BSF         T2CON+0, 2 
;Temporizador.c,173 :: 		}
L_end_loadTimer2:
	RETURN      0
; end of _loadTimer2

_main:

;Temporizador.c,175 :: 		void main()
;Temporizador.c,178 :: 		ADCON1 = 0x06;
	MOVLW       6
	MOVWF       ADCON1+0 
;Temporizador.c,181 :: 		T0CON.T08BIT = 0;       // 16 bits
	BCF         T0CON+0, 6 
;Temporizador.c,182 :: 		T0CON.T0CS = 0;         // Internal clock => Crystal/4
	BCF         T0CON+0, 5 
;Temporizador.c,183 :: 		T0CON.PSA = 0;          // Prescaler ON
	BCF         T0CON+0, 3 
;Temporizador.c,185 :: 		T0CON.T0PS2 = 0;
	BCF         T0CON+0, 2 
;Temporizador.c,186 :: 		T0CON.T0PS1 = 1;
	BSF         T0CON+0, 1 
;Temporizador.c,187 :: 		T0CON.T0PS0 = 1;
	BSF         T0CON+0, 0 
;Temporizador.c,189 :: 		TMR0H = COUNTER0 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       251
	MOVWF       TMR0H+0 
;Temporizador.c,190 :: 		TMR0L = COUNTER0;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       29
	MOVWF       TMR0L+0 
;Temporizador.c,191 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;Temporizador.c,192 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;Temporizador.c,193 :: 		T0CON.TMR0ON=1;
	BSF         T0CON+0, 7 
;Temporizador.c,196 :: 		TRISC.RC0 = 0;
	BCF         TRISC+0, 0 
;Temporizador.c,197 :: 		PORTC.RC0 = 0;
	BCF         PORTC+0, 0 
;Temporizador.c,198 :: 		T1CON.RD16 = 1;        // Read/Write in two 8 bits oper
	BSF         T1CON+0, 7 
;Temporizador.c,199 :: 		T1CON.T1OSCEN = 0;     // Disable internal Oscilator
	BCF         T1CON+0, 3 
;Temporizador.c,200 :: 		T1CON.TMR1CS = 1;      // External clock from RC0
	BSF         T1CON+0, 1 
;Temporizador.c,201 :: 		T1CON.T1SYNC = 1;      // Do not synchronize ext clock
	BSF         T1CON+0, 2 
;Temporizador.c,203 :: 		T1CON.T1CKPS1 = 1;
	BSF         T1CON+0, 5 
;Temporizador.c,204 :: 		T1CON.T1CKPS0 = 1;
	BSF         T1CON+0, 4 
;Temporizador.c,208 :: 		T2CON.T2CKPS1 = 1;
	BSF         T2CON+0, 1 
;Temporizador.c,209 :: 		T2CON.T2CKPS0 = 1;
	BSF         T2CON+0, 0 
;Temporizador.c,212 :: 		T3CON.RD16 = 1;
	BSF         T3CON+0, 7 
;Temporizador.c,213 :: 		T3CON.T3CCP2 = 1;
	BSF         T3CON+0, 6 
;Temporizador.c,214 :: 		T3CON.T3CKPS1 = 0;
	BCF         T3CON+0, 5 
;Temporizador.c,215 :: 		T3CON.T3CKPS0 = 1;
	BSF         T3CON+0, 4 
;Temporizador.c,216 :: 		T3CON.TMR3CS = 0;
	BCF         T3CON+0, 1 
;Temporizador.c,219 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;Temporizador.c,220 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;Temporizador.c,221 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Temporizador.c,224 :: 		TRISB.RB1 = 1;
	BSF         TRISB+0, 1 
;Temporizador.c,228 :: 		TRISB.RB4 = 0;
	BCF         TRISB+0, 4 
;Temporizador.c,229 :: 		TRISB.RB5 = 0;
	BCF         TRISB+0, 5 
;Temporizador.c,230 :: 		TRISB.RB6 = 0;
	BCF         TRISB+0, 6 
;Temporizador.c,231 :: 		TRISB.RB7 = 0;
	BCF         TRISB+0, 7 
;Temporizador.c,233 :: 		PORTB.RB4 = 0;
	BCF         PORTB+0, 4 
;Temporizador.c,234 :: 		PORTB.RB5 = 0;
	BCF         PORTB+0, 5 
;Temporizador.c,235 :: 		PORTB.RB6 = 0;
	BCF         PORTB+0, 6 
;Temporizador.c,236 :: 		PORTB.RB7 = 0;
	BCF         PORTB+0, 7 
;Temporizador.c,240 :: 		TRISA.RA2 = 1;
	BSF         TRISA+0, 2 
;Temporizador.c,241 :: 		TRISA.RA4 = 1;
	BSF         TRISA+0, 4 
;Temporizador.c,242 :: 		TRISA.RA5 = 1;
	BSF         TRISA+0, 5 
;Temporizador.c,243 :: 		TRISB.RB3 = 1;
	BSF         TRISB+0, 3 
;Temporizador.c,246 :: 		TRISC.RC1 = 0;
	BCF         TRISC+0, 1 
;Temporizador.c,247 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;Temporizador.c,250 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;Temporizador.c,251 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,252 :: 		TRISB.RB0 = 1;
	BSF         TRISB+0, 0 
;Temporizador.c,253 :: 		INTCON3.INT2IE = 1;
	BSF         INTCON3+0, 4 
;Temporizador.c,254 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,255 :: 		TRISB.RB2 = 1;
	BSF         TRISB+0, 2 
;Temporizador.c,258 :: 		TRISD.RD0 = 0; // digital output
	BCF         TRISD+0, 0 
;Temporizador.c,259 :: 		TRISD.RD1 = 0;
	BCF         TRISD+0, 1 
;Temporizador.c,260 :: 		TRISD.RD2 = 0;
	BCF         TRISD+0, 2 
;Temporizador.c,261 :: 		TRISD.RD3 = 0;
	BCF         TRISD+0, 3 
;Temporizador.c,262 :: 		TRISD.RD4 = 0;
	BCF         TRISD+0, 4 
;Temporizador.c,263 :: 		TRISD.RD5 = 0;
	BCF         TRISD+0, 5 
;Temporizador.c,264 :: 		TRISD.RD6 = 0;
	BCF         TRISD+0, 6 
;Temporizador.c,265 :: 		TRISD.RD7 = 0;
	BCF         TRISD+0, 7 
;Temporizador.c,267 :: 		PORTD.RD0 = 0;
	BCF         PORTD+0, 0 
;Temporizador.c,268 :: 		PORTD.RD1 = 0;
	BCF         PORTD+0, 1 
;Temporizador.c,269 :: 		PORTD.RD2 = 0;
	BCF         PORTD+0, 2 
;Temporizador.c,270 :: 		PORTD.RD3 = 0;
	BCF         PORTD+0, 3 
;Temporizador.c,271 :: 		PORTD.RD4 = 0;
	BCF         PORTD+0, 4 
;Temporizador.c,272 :: 		PORTD.RD5 = 0;
	BCF         PORTD+0, 5 
;Temporizador.c,273 :: 		PORTD.RD6 = 0;
	BCF         PORTD+0, 6 
;Temporizador.c,274 :: 		PORTD.RD7 = 0;
	BCF         PORTD+0, 7 
;Temporizador.c,276 :: 		TRISA.RA0 = 0; // digital output
	BCF         TRISA+0, 0 
;Temporizador.c,277 :: 		TRISA.RA1 = 0;
	BCF         TRISA+0, 1 
;Temporizador.c,278 :: 		TRISC.RC2 = 0;
	BCF         TRISC+0, 2 
;Temporizador.c,280 :: 		PORTA.RA0 = 0;
	BCF         PORTA+0, 0 
;Temporizador.c,281 :: 		PORTA.RA1 = 0;
	BCF         PORTA+0, 1 
;Temporizador.c,282 :: 		PORTC.RC2 = 0;
	BCF         PORTC+0, 2 
;Temporizador.c,283 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_keypadHandler:

;Temporizador.c,286 :: 		void keypadHandler()
;Temporizador.c,291 :: 		char rowCode = 0;
;Temporizador.c,292 :: 		char realCode = 0;
;Temporizador.c,293 :: 		char columnCode = 0;
	CLRF        keypadHandler_columnCode_L0+0 
;Temporizador.c,295 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	CLRF        keypadHandler_i_L0+0 
	MOVLW       15
	MOVWF       keypadHandler_columnCode_L0+0 
L_keypadHandler16:
	MOVF        keypadHandler_columnCode_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler17
;Temporizador.c,298 :: 		PORTB = ~(1 << i) << 4;
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
;Temporizador.c,299 :: 		columnCode = PORTA.RA2 | (PORTA.RA4 << 1) |
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
;Temporizador.c,300 :: 		(PORTA.RA5 << 2) | (PORTB.RB3) << 3;
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
;Temporizador.c,295 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	INCF        keypadHandler_i_L0+0, 1 
;Temporizador.c,302 :: 		}
	GOTO        L_keypadHandler16
L_keypadHandler17:
;Temporizador.c,303 :: 		rowCode = PORTB >> 4;
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
;Temporizador.c,304 :: 		PORTB = 0;
	CLRF        PORTB+0 
;Temporizador.c,306 :: 		realCode = rowCode | (columnCode << 4);
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
;Temporizador.c,307 :: 		result = keyHandler(realCode, &type);
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
;Temporizador.c,309 :: 		nPressed += 1;
	INFSNZ      _nPressed+0, 1 
	INCF        _nPressed+1, 1 
;Temporizador.c,311 :: 		if(nPressed < 3)
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
;Temporizador.c,313 :: 		time *= 10;
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
;Temporizador.c,314 :: 		time += result;
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
;Temporizador.c,315 :: 		}
	GOTO        L_keypadHandler20
L_keypadHandler19:
;Temporizador.c,318 :: 		time += (result * 0.1);
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
;Temporizador.c,319 :: 		}
L_keypadHandler20:
;Temporizador.c,320 :: 		}
L_end_keypadHandler:
	RETURN      0
; end of _keypadHandler

_keyHandler:

;Temporizador.c,323 :: 		int keyHandler (int key, KeyType* type)
;Temporizador.c,325 :: 		int result = -1;
	MOVLW       255
	MOVWF       keyHandler_result_L0+0 
	MOVLW       255
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,326 :: 		switch(key)
	GOTO        L_keyHandler21
;Temporizador.c,328 :: 		case 231:
L_keyHandler23:
;Temporizador.c,329 :: 		*type = ON_CLEAR;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       5
	MOVWF       POSTINC1+0 
;Temporizador.c,330 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,332 :: 		case 215:
L_keyHandler24:
;Temporizador.c,333 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,334 :: 		result = 0;
	CLRF        keyHandler_result_L0+0 
	CLRF        keyHandler_result_L0+1 
;Temporizador.c,335 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,337 :: 		case 183:
L_keyHandler25:
;Temporizador.c,338 :: 		*type = EQUALS;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	CLRF        POSTINC1+0 
;Temporizador.c,339 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,341 :: 		case 119:
L_keyHandler26:
;Temporizador.c,342 :: 		*type = SUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
;Temporizador.c,343 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,345 :: 		case 235:
L_keyHandler27:
;Temporizador.c,346 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,347 :: 		result = 1;
	MOVLW       1
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,348 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,350 :: 		case 219:
L_keyHandler28:
;Temporizador.c,351 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,352 :: 		result = 2;
	MOVLW       2
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,353 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,355 :: 		case 187:
L_keyHandler29:
;Temporizador.c,356 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,357 :: 		result = 3;
	MOVLW       3
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,358 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,360 :: 		case 123:
L_keyHandler30:
;Temporizador.c,361 :: 		*type = SUB;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       2
	MOVWF       POSTINC1+0 
;Temporizador.c,362 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,364 :: 		case 237:
L_keyHandler31:
;Temporizador.c,365 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,366 :: 		result = 4;
	MOVLW       4
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,367 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,369 :: 		case 221:
L_keyHandler32:
;Temporizador.c,370 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,371 :: 		result = 5;
	MOVLW       5
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,372 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,374 :: 		case 189:
L_keyHandler33:
;Temporizador.c,375 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,376 :: 		result = 6;
	MOVLW       6
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,377 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,379 :: 		case 125:
L_keyHandler34:
;Temporizador.c,380 :: 		*type = MULT;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       3
	MOVWF       POSTINC1+0 
;Temporizador.c,381 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,383 :: 		case 238:
L_keyHandler35:
;Temporizador.c,384 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,385 :: 		result = 7;
	MOVLW       7
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,386 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,388 :: 		case 222:
L_keyHandler36:
;Temporizador.c,389 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,390 :: 		result = 8;
	MOVLW       8
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,391 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,393 :: 		case 190:
L_keyHandler37:
;Temporizador.c,394 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,395 :: 		result = 9;
	MOVLW       9
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,396 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,398 :: 		case 126:
L_keyHandler38:
;Temporizador.c,399 :: 		*type = DIVI;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       4
	MOVWF       POSTINC1+0 
;Temporizador.c,400 :: 		break;
	GOTO        L_keyHandler22
;Temporizador.c,401 :: 		}
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
;Temporizador.c,403 :: 		return result;
	MOVF        keyHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keyHandler_result_L0+1, 0 
	MOVWF       R1 
;Temporizador.c,404 :: 		}
L_end_keyHandler:
	RETURN      0
; end of _keyHandler

_display:

;Temporizador.c,407 :: 		unsigned int display ()
;Temporizador.c,409 :: 		int number = ((int)(time - timeCounter)/pot) % 10;
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
;Temporizador.c,410 :: 		switch(number)
	GOTO        L_display39
;Temporizador.c,412 :: 		case 0: return 0x3F;
L_display41:
	MOVLW       63
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,413 :: 		case 1: return 0x06;
L_display42:
	MOVLW       6
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,414 :: 		case 2: return 0x5B;
L_display43:
	MOVLW       91
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,415 :: 		case 3: return 0x4F;
L_display44:
	MOVLW       79
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,416 :: 		case 4: return 0x66;
L_display45:
	MOVLW       102
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,417 :: 		case 5: return 0x6D;
L_display46:
	MOVLW       109
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,418 :: 		case 6: return 0x7D;
L_display47:
	MOVLW       125
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,419 :: 		case 7: return 0x07;
L_display48:
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,420 :: 		case 8: return 0x7F;
L_display49:
	MOVLW       127
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,421 :: 		case 9: return 0x6F;
L_display50:
	MOVLW       111
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;Temporizador.c,422 :: 		}
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
;Temporizador.c,423 :: 		}
L_end_display:
	RETURN      0
; end of _display
