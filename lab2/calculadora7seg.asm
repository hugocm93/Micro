
_interrupt:

;calculadora7seg.c,27 :: 		void interrupt(void)
;calculadora7seg.c,29 :: 		if(INTCON.TMR0IF)
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;calculadora7seg.c,31 :: 		INTCON.TMR0IE=0;
	BCF         INTCON+0, 5 
;calculadora7seg.c,32 :: 		TMR0H = COUNTER >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       255
	MOVWF       TMR0H+0 
;calculadora7seg.c,33 :: 		TMR0L = COUNTER;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       245
	MOVWF       TMR0L+0 
;calculadora7seg.c,35 :: 		nDigit = nDigit == -1 ? 3 : nDigit;
	MOVLW       255
	XORWF       _nDigit+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt69
	MOVLW       255
	XORWF       _nDigit+0, 0 
L__interrupt69:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_interrupt2
L_interrupt1:
	MOVF        _nDigit+0, 0 
	MOVWF       R0 
	MOVF        _nDigit+1, 0 
	MOVWF       R1 
L_interrupt2:
	MOVF        R0, 0 
	MOVWF       _nDigit+0 
	MOVF        R1, 0 
	MOVWF       _nDigit+1 
;calculadora7seg.c,37 :: 		pot = pot == 1000 ? 1 : pot*10;
	MOVF        _pot+1, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt70
	MOVLW       232
	XORWF       _pot+0, 0 
L__interrupt70:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
	MOVLW       1
	MOVWF       FLOC__interrupt+0 
	MOVLW       0
	MOVWF       FLOC__interrupt+1 
	GOTO        L_interrupt4
L_interrupt3:
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
L_interrupt4:
	MOVF        FLOC__interrupt+0, 0 
	MOVWF       _pot+0 
	MOVF        FLOC__interrupt+1, 0 
	MOVWF       _pot+1 
;calculadora7seg.c,39 :: 		PORTA = 0;
	CLRF        PORTA+0 
;calculadora7seg.c,41 :: 		PORTD = display();
	CALL        _display+0, 0
	MOVF        R0, 0 
	MOVWF       PORTD+0 
;calculadora7seg.c,43 :: 		PORTA = 1 << nDigit + 2;
	MOVLW       2
	ADDWF       _nDigit+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__interrupt71:
	BZ          L__interrupt72
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__interrupt71
L__interrupt72:
	MOVF        R0, 0 
	MOVWF       PORTA+0 
;calculadora7seg.c,45 :: 		nDigit--;
	MOVLW       1
	SUBWF       _nDigit+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      _nDigit+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _nDigit+0 
	MOVF        R1, 0 
	MOVWF       _nDigit+1 
;calculadora7seg.c,47 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;calculadora7seg.c,48 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;calculadora7seg.c,49 :: 		timer += COUNTER;
	MOVF        _timer+0, 0 
	MOVWF       R0 
	MOVF        _timer+1, 0 
	MOVWF       R1 
	MOVF        _timer+2, 0 
	MOVWF       R2 
	MOVF        _timer+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       245
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       142
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _timer+0 
	MOVF        R1, 0 
	MOVWF       _timer+1 
	MOVF        R2, 0 
	MOVWF       _timer+2 
	MOVF        R3, 0 
	MOVWF       _timer+3 
;calculadora7seg.c,50 :: 		}
L_interrupt0:
;calculadora7seg.c,52 :: 		if(INTCON.RBIF)
	BTFSS       INTCON+0, 0 
	GOTO        L_interrupt5
;calculadora7seg.c,54 :: 		if(/*edge == 1 && */(timer > 0.02))
	MOVF        _timer+0, 0 
	MOVWF       R4 
	MOVF        _timer+1, 0 
	MOVWF       R5 
	MOVF        _timer+2, 0 
	MOVWF       R6 
	MOVF        _timer+3, 0 
	MOVWF       R7 
	MOVLW       10
	MOVWF       R0 
	MOVLW       215
	MOVWF       R1 
	MOVLW       35
	MOVWF       R2 
	MOVLW       121
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt6
;calculadora7seg.c,56 :: 		PORTC.RC1 = 1;
	BSF         PORTC+0, 1 
;calculadora7seg.c,57 :: 		keypadHandler();
	CALL        _keypadHandler+0, 0
;calculadora7seg.c,58 :: 		timer = 0;
	CLRF        _timer+0 
	CLRF        _timer+1 
	CLRF        _timer+2 
	CLRF        _timer+3 
;calculadora7seg.c,59 :: 		}
	GOTO        L_interrupt7
L_interrupt6:
;calculadora7seg.c,62 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;calculadora7seg.c,63 :: 		}
L_interrupt7:
;calculadora7seg.c,65 :: 		edge = !edge;
	MOVF        _edge+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _edge+0 
;calculadora7seg.c,66 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;calculadora7seg.c,67 :: 		}
L_interrupt5:
;calculadora7seg.c,68 :: 		}
L_end_interrupt:
L__interrupt68:
	RETFIE      1
; end of _interrupt

_main:

;calculadora7seg.c,70 :: 		void main()
;calculadora7seg.c,73 :: 		T0CON.T08BIT = 0;       // 16 bits
	BCF         T0CON+0, 6 
;calculadora7seg.c,74 :: 		T0CON.T0CS = 0;         // Internal clock => Crystal/4
	BCF         T0CON+0, 5 
;calculadora7seg.c,75 :: 		T0CON.PSA = 0;          // Prescaler ON
	BCF         T0CON+0, 3 
;calculadora7seg.c,78 :: 		T0CON.T0PS2 = 1;
	BSF         T0CON+0, 2 
;calculadora7seg.c,79 :: 		T0CON.T0PS1 = 1;
	BSF         T0CON+0, 1 
;calculadora7seg.c,80 :: 		T0CON.T0PS0 = 1;
	BSF         T0CON+0, 0 
;calculadora7seg.c,83 :: 		TMR0H = COUNTER >> 8;  // Load Timer 0 counter - 1st TMR0H
	MOVLW       255
	MOVWF       TMR0H+0 
;calculadora7seg.c,84 :: 		TMR0L = COUNTER;       // Load Timer 0 counter - 2nd TMR0L
	MOVLW       245
	MOVWF       TMR0L+0 
;calculadora7seg.c,87 :: 		INTCON.TMR0IP = 1;
	BSF         INTCON+0, 2 
;calculadora7seg.c,88 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;calculadora7seg.c,89 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;calculadora7seg.c,90 :: 		INTCON.PEIE=0;
	BCF         INTCON+0, 6 
;calculadora7seg.c,91 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;calculadora7seg.c,94 :: 		T0CON.TMR0ON=1;
	BSF         T0CON+0, 7 
;calculadora7seg.c,97 :: 		ADCON1 = 0x6;
	MOVLW       6
	MOVWF       ADCON1+0 
;calculadora7seg.c,100 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;calculadora7seg.c,103 :: 		TRISB.RB4 = 1; // digital input
	BSF         TRISB+0, 4 
;calculadora7seg.c,104 :: 		TRISB.RB5 = 1; // digital input
	BSF         TRISB+0, 5 
;calculadora7seg.c,105 :: 		TRISB.RB6 = 1; // digital input
	BSF         TRISB+0, 6 
;calculadora7seg.c,106 :: 		TRISB.RB7 = 1; // digital input
	BSF         TRISB+0, 7 
;calculadora7seg.c,108 :: 		TRISB.RB0 = 0; // digital output
	BCF         TRISB+0, 0 
;calculadora7seg.c,109 :: 		TRISB.RB1 = 0;
	BCF         TRISB+0, 1 
;calculadora7seg.c,110 :: 		TRISB.RB2 = 0;
	BCF         TRISB+0, 2 
;calculadora7seg.c,111 :: 		TRISB.RB3 = 0;
	BCF         TRISB+0, 3 
;calculadora7seg.c,113 :: 		PORTB.RB0 = 0; // digital output
	BCF         PORTB+0, 0 
;calculadora7seg.c,114 :: 		PORTB.RB1 = 0;
	BCF         PORTB+0, 1 
;calculadora7seg.c,115 :: 		PORTB.RB2 = 0;
	BCF         PORTB+0, 2 
;calculadora7seg.c,116 :: 		PORTB.RB3 = 0;
	BCF         PORTB+0, 3 
;calculadora7seg.c,119 :: 		TRISD.RD0 = 0; // digital output
	BCF         TRISD+0, 0 
;calculadora7seg.c,120 :: 		TRISD.RD1 = 0;
	BCF         TRISD+0, 1 
;calculadora7seg.c,121 :: 		TRISD.RD2 = 0;
	BCF         TRISD+0, 2 
;calculadora7seg.c,122 :: 		TRISD.RD3 = 0;
	BCF         TRISD+0, 3 
;calculadora7seg.c,123 :: 		TRISD.RD4 = 0;
	BCF         TRISD+0, 4 
;calculadora7seg.c,124 :: 		TRISD.RD5 = 0;
	BCF         TRISD+0, 5 
;calculadora7seg.c,125 :: 		TRISD.RD6 = 0;
	BCF         TRISD+0, 6 
;calculadora7seg.c,126 :: 		TRISD.RD7 = 0;
	BCF         TRISD+0, 7 
;calculadora7seg.c,128 :: 		PORTD.RD0 = 0;
	BCF         PORTD+0, 0 
;calculadora7seg.c,129 :: 		PORTD.RD1 = 0;
	BCF         PORTD+0, 1 
;calculadora7seg.c,130 :: 		PORTD.RD2 = 0;
	BCF         PORTD+0, 2 
;calculadora7seg.c,131 :: 		PORTD.RD3 = 0;
	BCF         PORTD+0, 3 
;calculadora7seg.c,132 :: 		PORTD.RD4 = 0;
	BCF         PORTD+0, 4 
;calculadora7seg.c,133 :: 		PORTD.RD5 = 0;
	BCF         PORTD+0, 5 
;calculadora7seg.c,134 :: 		PORTD.RD6 = 0;
	BCF         PORTD+0, 6 
;calculadora7seg.c,135 :: 		PORTD.RD7 = 0;
	BCF         PORTD+0, 7 
;calculadora7seg.c,137 :: 		TRISC.RC1 = 0; // digital output
	BCF         TRISC+0, 1 
;calculadora7seg.c,140 :: 		TRISA.RA2 = 0; // digital output
	BCF         TRISA+0, 2 
;calculadora7seg.c,141 :: 		TRISA.RA3 = 0;
	BCF         TRISA+0, 3 
;calculadora7seg.c,142 :: 		TRISA.RA4 = 0;
	BCF         TRISA+0, 4 
;calculadora7seg.c,143 :: 		TRISA.RA5 = 0;
	BCF         TRISA+0, 5 
;calculadora7seg.c,145 :: 		PORTA.RA2 = 0;
	BCF         PORTA+0, 2 
;calculadora7seg.c,146 :: 		PORTA.RA3 = 0;
	BCF         PORTA+0, 3 
;calculadora7seg.c,147 :: 		PORTA.RA4 = 0;
	BCF         PORTA+0, 4 
;calculadora7seg.c,148 :: 		PORTA.RA5 = 0;
	BCF         PORTA+0, 5 
;calculadora7seg.c,150 :: 		INTCON.RBIE = 1;
	BSF         INTCON+0, 3 
;calculadora7seg.c,151 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;calculadora7seg.c,152 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_keypadHandler:

;calculadora7seg.c,154 :: 		void keypadHandler()
;calculadora7seg.c,160 :: 		for(i = 0, columnCode = 0x0f; (i < 4) && (columnCode==0x0f); i++)
	CLRF        keypadHandler_i_L0+0 
	MOVLW       15
	MOVWF       _columnCode+0 
L_keypadHandler8:
	MOVLW       4
	SUBWF       keypadHandler_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadHandler9
	MOVF        _columnCode+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler9
L__keypadHandler66:
;calculadora7seg.c,162 :: 		PORTB.RB0 = 1; // digital output
	BSF         PORTB+0, 0 
;calculadora7seg.c,163 :: 		PORTB.RB1 = 1;
	BSF         PORTB+0, 1 
;calculadora7seg.c,164 :: 		PORTB.RB2 = 1;
	BSF         PORTB+0, 2 
;calculadora7seg.c,165 :: 		PORTB.RB3 = 1;
	BSF         PORTB+0, 3 
;calculadora7seg.c,166 :: 		if(i==0)PORTB.RB0 = 0; // digital output
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler13
	BCF         PORTB+0, 0 
L_keypadHandler13:
;calculadora7seg.c,167 :: 		if(i==1)PORTB.RB1 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler14
	BCF         PORTB+0, 1 
L_keypadHandler14:
;calculadora7seg.c,168 :: 		if(i==2)PORTB.RB2 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler15
	BCF         PORTB+0, 2 
L_keypadHandler15:
;calculadora7seg.c,169 :: 		if(i==3)PORTB.RB3 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler16
	BCF         PORTB+0, 3 
L_keypadHandler16:
;calculadora7seg.c,170 :: 		columnCode = PORTB >> 4;
	MOVF        PORTB+0, 0 
	MOVWF       _columnCode+0 
	RRCF        _columnCode+0, 1 
	BCF         _columnCode+0, 7 
	RRCF        _columnCode+0, 1 
	BCF         _columnCode+0, 7 
	RRCF        _columnCode+0, 1 
	BCF         _columnCode+0, 7 
	RRCF        _columnCode+0, 1 
	BCF         _columnCode+0, 7 
;calculadora7seg.c,160 :: 		for(i = 0, columnCode = 0x0f; (i < 4) && (columnCode==0x0f); i++)
	INCF        keypadHandler_i_L0+0, 1 
;calculadora7seg.c,171 :: 		}
	GOTO        L_keypadHandler8
L_keypadHandler9:
;calculadora7seg.c,172 :: 		result = keyHandler(PORTB, &type);
	MOVF        PORTB+0, 0 
	MOVWF       FARG_keyHandler_key+0 
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
;calculadora7seg.c,173 :: 		PORTB.RB0 = 0; // digital output
	BCF         PORTB+0, 0 
;calculadora7seg.c,174 :: 		PORTB.RB1 = 0;
	BCF         PORTB+0, 1 
;calculadora7seg.c,175 :: 		PORTB.RB2 = 0;
	BCF         PORTB+0, 2 
;calculadora7seg.c,176 :: 		PORTB.RB3 = 0;
	BCF         PORTB+0, 3 
;calculadora7seg.c,178 :: 		if(edge == 1)
	MOVF        _edge+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler17
;calculadora7seg.c,180 :: 		if(type == NUM && operation == EMPTY)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler20
	MOVF        _operation+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler20
L__keypadHandler65:
;calculadora7seg.c,182 :: 		operando1 *= 10;
	MOVF        _operando1+0, 0 
	MOVWF       R0 
	MOVF        _operando1+1, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _operando1+0 
	MOVF        R1, 0 
	MOVWF       _operando1+1 
;calculadora7seg.c,183 :: 		operando1 += result;
	MOVF        keypadHandler_result_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        keypadHandler_result_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _operando1+0 
	MOVF        R1, 0 
	MOVWF       _operando1+1 
;calculadora7seg.c,184 :: 		numberOnDisplay = operando1;
	MOVF        R0, 0 
	MOVWF       _numberOnDisplay+0 
	MOVF        R1, 0 
	MOVWF       _numberOnDisplay+1 
;calculadora7seg.c,185 :: 		}
L_keypadHandler20:
;calculadora7seg.c,186 :: 		if(type != NUM && type != ON_CLEAR && type != EQUALS)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_keypadHandler23
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_keypadHandler23
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_keypadHandler23
L__keypadHandler64:
;calculadora7seg.c,188 :: 		operation = type;
	MOVF        keypadHandler_type_L0+0, 0 
	MOVWF       _operation+0 
;calculadora7seg.c,189 :: 		}
L_keypadHandler23:
;calculadora7seg.c,190 :: 		if(type == NUM && operation != EMPTY)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler26
	MOVF        _operation+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_keypadHandler26
L__keypadHandler63:
;calculadora7seg.c,192 :: 		operando2 *= 10;
	MOVF        _operando2+0, 0 
	MOVWF       R0 
	MOVF        _operando2+1, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _operando2+0 
	MOVF        R1, 0 
	MOVWF       _operando2+1 
;calculadora7seg.c,193 :: 		operando2 += result;
	MOVF        keypadHandler_result_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        keypadHandler_result_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _operando2+0 
	MOVF        R1, 0 
	MOVWF       _operando2+1 
;calculadora7seg.c,194 :: 		numberOnDisplay = operando2;
	MOVF        R0, 0 
	MOVWF       _numberOnDisplay+0 
	MOVF        R1, 0 
	MOVWF       _numberOnDisplay+1 
;calculadora7seg.c,195 :: 		}
L_keypadHandler26:
;calculadora7seg.c,196 :: 		if(type == EQUALS)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler27
;calculadora7seg.c,198 :: 		if(operation == SUM)
	MOVF        _operation+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler28
;calculadora7seg.c,199 :: 		numberOnDisplay = operando1 + operando2;
	MOVF        _operando2+0, 0 
	ADDWF       _operando1+0, 0 
	MOVWF       _numberOnDisplay+0 
	MOVF        _operando2+1, 0 
	ADDWFC      _operando1+1, 0 
	MOVWF       _numberOnDisplay+1 
L_keypadHandler28:
;calculadora7seg.c,201 :: 		if(operation == SUB)
	MOVF        _operation+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler29
;calculadora7seg.c,202 :: 		numberOnDisplay = operando1 - operando2;
	MOVF        _operando2+0, 0 
	SUBWF       _operando1+0, 0 
	MOVWF       _numberOnDisplay+0 
	MOVF        _operando2+1, 0 
	SUBWFB      _operando1+1, 0 
	MOVWF       _numberOnDisplay+1 
L_keypadHandler29:
;calculadora7seg.c,204 :: 		if(operation == MULT)
	MOVF        _operation+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler30
;calculadora7seg.c,205 :: 		numberOnDisplay = operando1 * operando2;
	MOVF        _operando1+0, 0 
	MOVWF       R0 
	MOVF        _operando1+1, 0 
	MOVWF       R1 
	MOVF        _operando2+0, 0 
	MOVWF       R4 
	MOVF        _operando2+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _numberOnDisplay+0 
	MOVF        R1, 0 
	MOVWF       _numberOnDisplay+1 
L_keypadHandler30:
;calculadora7seg.c,207 :: 		if(operation == DIVI)
	MOVF        _operation+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler31
;calculadora7seg.c,208 :: 		numberOnDisplay = operando1 / operando2;
	MOVF        _operando2+0, 0 
	MOVWF       R4 
	MOVF        _operando2+1, 0 
	MOVWF       R5 
	MOVF        _operando1+0, 0 
	MOVWF       R0 
	MOVF        _operando1+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _numberOnDisplay+0 
	MOVF        R1, 0 
	MOVWF       _numberOnDisplay+1 
L_keypadHandler31:
;calculadora7seg.c,210 :: 		operando1 = numberOnDisplay;
	MOVF        _numberOnDisplay+0, 0 
	MOVWF       _operando1+0 
	MOVF        _numberOnDisplay+1, 0 
	MOVWF       _operando1+1 
;calculadora7seg.c,211 :: 		operando2 = 0;
	CLRF        _operando2+0 
	CLRF        _operando2+1 
;calculadora7seg.c,212 :: 		operation = EMPTY;
	MOVLW       7
	MOVWF       _operation+0 
;calculadora7seg.c,213 :: 		}
L_keypadHandler27:
;calculadora7seg.c,214 :: 		if(type == ON_CLEAR)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler32
;calculadora7seg.c,216 :: 		operando1 = 0;
	CLRF        _operando1+0 
	CLRF        _operando1+1 
;calculadora7seg.c,217 :: 		operando2 = 0;
	CLRF        _operando2+0 
	CLRF        _operando2+1 
;calculadora7seg.c,218 :: 		operation = EMPTY;
	MOVLW       7
	MOVWF       _operation+0 
;calculadora7seg.c,219 :: 		numberOnDisplay = 0;
	CLRF        _numberOnDisplay+0 
	CLRF        _numberOnDisplay+1 
;calculadora7seg.c,220 :: 		}
L_keypadHandler32:
;calculadora7seg.c,221 :: 		}
L_keypadHandler17:
;calculadora7seg.c,222 :: 		}
L_end_keypadHandler:
	RETURN      0
; end of _keypadHandler

_keyHandler:

;calculadora7seg.c,225 :: 		int keyHandler (int key, KeyType* type)
;calculadora7seg.c,227 :: 		int result = -1;
	MOVLW       255
	MOVWF       keyHandler_result_L0+0 
	MOVLW       255
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,228 :: 		switch(key)
	GOTO        L_keyHandler33
;calculadora7seg.c,230 :: 		case 231:
L_keyHandler35:
;calculadora7seg.c,231 :: 		*type = ON_CLEAR;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       5
	MOVWF       POSTINC1+0 
;calculadora7seg.c,232 :: 		break;
	GOTO        L_keyHandler34
;calculadora7seg.c,234 :: 		case 215:
L_keyHandler36:
;calculadora7seg.c,235 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,236 :: 		result = 0;
	CLRF        keyHandler_result_L0+0 
	CLRF        keyHandler_result_L0+1 
;calculadora7seg.c,237 :: 		break;
	GOTO        L_keyHandler34
;calculadora7seg.c,239 :: 		case 183:
L_keyHandler37:
;calculadora7seg.c,240 :: 		*type = EQUALS;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	CLRF        POSTINC1+0 
;calculadora7seg.c,241 :: 		break;
	GOTO        L_keyHandler34
;calculadora7seg.c,243 :: 		case 119:
L_keyHandler38:
;calculadora7seg.c,244 :: 		*type = SUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
;calculadora7seg.c,245 :: 		break;
	GOTO        L_keyHandler34
;calculadora7seg.c,247 :: 		case 235:
L_keyHandler39:
;calculadora7seg.c,248 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,249 :: 		result = 7;
	MOVLW       7
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,250 :: 		break;
	GOTO        L_keyHandler34
;calculadora7seg.c,252 :: 		case 219:
L_keyHandler40:
;calculadora7seg.c,253 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,254 :: 		result = 8;
	MOVLW       8
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,255 :: 		break;
	GOTO        L_keyHandler34
;calculadora7seg.c,257 :: 		case 187:
L_keyHandler41:
;calculadora7seg.c,258 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,259 :: 		result = 9;
	MOVLW       9
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,260 :: 		break;
	GOTO        L_keyHandler34
;calculadora7seg.c,262 :: 		case 123:
L_keyHandler42:
;calculadora7seg.c,263 :: 		*type = SUB;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       2
	MOVWF       POSTINC1+0 
;calculadora7seg.c,264 :: 		break;
	GOTO        L_keyHandler34
;calculadora7seg.c,266 :: 		case 237:
L_keyHandler43:
;calculadora7seg.c,267 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,268 :: 		result = 4;
	MOVLW       4
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,269 :: 		break;
	GOTO        L_keyHandler34
;calculadora7seg.c,271 :: 		case 221:
L_keyHandler44:
;calculadora7seg.c,272 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,273 :: 		result = 5;
	MOVLW       5
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,274 :: 		break;
	GOTO        L_keyHandler34
;calculadora7seg.c,276 :: 		case 189:
L_keyHandler45:
;calculadora7seg.c,277 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,278 :: 		result = 6;
	MOVLW       6
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,279 :: 		break;
	GOTO        L_keyHandler34
;calculadora7seg.c,281 :: 		case 125:
L_keyHandler46:
;calculadora7seg.c,282 :: 		*type = MULT;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       3
	MOVWF       POSTINC1+0 
;calculadora7seg.c,283 :: 		break;
	GOTO        L_keyHandler34
;calculadora7seg.c,285 :: 		case 238:
L_keyHandler47:
;calculadora7seg.c,286 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,287 :: 		result = 1;
	MOVLW       1
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,288 :: 		break;
	GOTO        L_keyHandler34
;calculadora7seg.c,290 :: 		case 222:
L_keyHandler48:
;calculadora7seg.c,291 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,292 :: 		result = 2;
	MOVLW       2
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,293 :: 		break;
	GOTO        L_keyHandler34
;calculadora7seg.c,295 :: 		case 190:
L_keyHandler49:
;calculadora7seg.c,296 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,297 :: 		result = 3;
	MOVLW       3
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,298 :: 		break;
	GOTO        L_keyHandler34
;calculadora7seg.c,300 :: 		case 126:
L_keyHandler50:
;calculadora7seg.c,301 :: 		*type = DIVI;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       4
	MOVWF       POSTINC1+0 
;calculadora7seg.c,302 :: 		break;
	GOTO        L_keyHandler34
;calculadora7seg.c,303 :: 		}
L_keyHandler33:
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler76
	MOVLW       231
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler76:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler35
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler77
	MOVLW       215
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler77:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler36
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler78
	MOVLW       183
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler78:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler37
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler79
	MOVLW       119
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler79:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler38
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler80
	MOVLW       235
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler80:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler39
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler81
	MOVLW       219
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler81:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler40
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler82
	MOVLW       187
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler82:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler41
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler83
	MOVLW       123
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler83:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler42
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler84
	MOVLW       237
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler84:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler43
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler85
	MOVLW       221
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler85:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler44
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler86
	MOVLW       189
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler86:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler45
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler87
	MOVLW       125
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler87:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler46
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler88
	MOVLW       238
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler88:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler47
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler89
	MOVLW       222
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler89:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler48
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler90
	MOVLW       190
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler90:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler49
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler91
	MOVLW       126
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler91:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler50
L_keyHandler34:
;calculadora7seg.c,305 :: 		return result;
	MOVF        keyHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keyHandler_result_L0+1, 0 
	MOVWF       R1 
;calculadora7seg.c,306 :: 		}
L_end_keyHandler:
	RETURN      0
; end of _keyHandler

_display:

;calculadora7seg.c,309 :: 		unsigned int display ()
;calculadora7seg.c,311 :: 		int number = (numberOnDisplay/pot) % 10;
	MOVF        _pot+0, 0 
	MOVWF       R4 
	MOVF        _pot+1, 0 
	MOVWF       R5 
	MOVF        _numberOnDisplay+0, 0 
	MOVWF       R0 
	MOVF        _numberOnDisplay+1, 0 
	MOVWF       R1 
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
;calculadora7seg.c,312 :: 		switch(number)
	GOTO        L_display51
;calculadora7seg.c,314 :: 		case 0: return 0x3F;
L_display53:
	MOVLW       63
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,315 :: 		case 1: return 0x06;
L_display54:
	MOVLW       6
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,316 :: 		case 2: return 0x5B;
L_display55:
	MOVLW       91
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,317 :: 		case 3: return 0x4F;
L_display56:
	MOVLW       79
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,318 :: 		case 4: return 0x66;
L_display57:
	MOVLW       102
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,319 :: 		case 5: return 0x6D;
L_display58:
	MOVLW       109
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,320 :: 		case 6: return 0x7D;
L_display59:
	MOVLW       125
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,321 :: 		case 7: return 0x07;
L_display60:
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,322 :: 		case 8: return 0x7F;
L_display61:
	MOVLW       127
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,323 :: 		case 9: return 0x6F;
L_display62:
	MOVLW       111
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,324 :: 		}
L_display51:
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display93
	MOVLW       0
	XORWF       display_number_L0+0, 0 
L__display93:
	BTFSC       STATUS+0, 2 
	GOTO        L_display53
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display94
	MOVLW       1
	XORWF       display_number_L0+0, 0 
L__display94:
	BTFSC       STATUS+0, 2 
	GOTO        L_display54
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display95
	MOVLW       2
	XORWF       display_number_L0+0, 0 
L__display95:
	BTFSC       STATUS+0, 2 
	GOTO        L_display55
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display96
	MOVLW       3
	XORWF       display_number_L0+0, 0 
L__display96:
	BTFSC       STATUS+0, 2 
	GOTO        L_display56
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display97
	MOVLW       4
	XORWF       display_number_L0+0, 0 
L__display97:
	BTFSC       STATUS+0, 2 
	GOTO        L_display57
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display98
	MOVLW       5
	XORWF       display_number_L0+0, 0 
L__display98:
	BTFSC       STATUS+0, 2 
	GOTO        L_display58
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display99
	MOVLW       6
	XORWF       display_number_L0+0, 0 
L__display99:
	BTFSC       STATUS+0, 2 
	GOTO        L_display59
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display100
	MOVLW       7
	XORWF       display_number_L0+0, 0 
L__display100:
	BTFSC       STATUS+0, 2 
	GOTO        L_display60
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display101
	MOVLW       8
	XORWF       display_number_L0+0, 0 
L__display101:
	BTFSC       STATUS+0, 2 
	GOTO        L_display61
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display102
	MOVLW       9
	XORWF       display_number_L0+0, 0 
L__display102:
	BTFSC       STATUS+0, 2 
	GOTO        L_display62
;calculadora7seg.c,325 :: 		}
L_end_display:
	RETURN      0
; end of _display
