
_interrupt:

;calculadora7seg.c,25 :: 		void interrupt(void)
;calculadora7seg.c,27 :: 		if(INTCON.TMR0IF)
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;calculadora7seg.c,29 :: 		TMR0H = COUNTER >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       255
	MOVWF       TMR0H+0 
;calculadora7seg.c,30 :: 		TMR0L = COUNTER;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       155
	MOVWF       TMR0L+0 
;calculadora7seg.c,32 :: 		if(nDigit == 4)
	MOVLW       0
	XORWF       _nDigit+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt68
	MOVLW       4
	XORWF       _nDigit+0, 0 
L__interrupt68:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;calculadora7seg.c,34 :: 		nDigit = 0;
	CLRF        _nDigit+0 
	CLRF        _nDigit+1 
;calculadora7seg.c,35 :: 		}
L_interrupt1:
;calculadora7seg.c,37 :: 		PORTA.RA2 = 0;
	BCF         PORTA+0, 2 
;calculadora7seg.c,38 :: 		PORTA.RA3 = 0;
	BCF         PORTA+0, 3 
;calculadora7seg.c,39 :: 		PORTA.RA4 = 0;
	BCF         PORTA+0, 4 
;calculadora7seg.c,40 :: 		PORTA.RA5 = 0;
	BCF         PORTA+0, 5 
;calculadora7seg.c,42 :: 		if(nDigit==0)PORTA.RA2 = 1;
	MOVLW       0
	XORWF       _nDigit+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt69
	MOVLW       0
	XORWF       _nDigit+0, 0 
L__interrupt69:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt2
	BSF         PORTA+0, 2 
L_interrupt2:
;calculadora7seg.c,43 :: 		if(nDigit==1)PORTA.RA3 = 1;
	MOVLW       0
	XORWF       _nDigit+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt70
	MOVLW       1
	XORWF       _nDigit+0, 0 
L__interrupt70:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
	BSF         PORTA+0, 3 
L_interrupt3:
;calculadora7seg.c,44 :: 		if(nDigit==2)PORTA.RA4 = 1;
	MOVLW       0
	XORWF       _nDigit+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt71
	MOVLW       2
	XORWF       _nDigit+0, 0 
L__interrupt71:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt4
	BSF         PORTA+0, 4 
L_interrupt4:
;calculadora7seg.c,45 :: 		if(nDigit==3)PORTA.RA5 = 1;
	MOVLW       0
	XORWF       _nDigit+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt72
	MOVLW       3
	XORWF       _nDigit+0, 0 
L__interrupt72:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt5
	BSF         PORTA+0, 5 
L_interrupt5:
;calculadora7seg.c,47 :: 		PORTD = display();
	CALL        _display+0, 0
	MOVF        R0, 0 
	MOVWF       PORTD+0 
;calculadora7seg.c,49 :: 		nDigit++;
	INFSNZ      _nDigit+0, 1 
	INCF        _nDigit+1, 1 
;calculadora7seg.c,50 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;calculadora7seg.c,51 :: 		}
L_interrupt0:
;calculadora7seg.c,53 :: 		if(INTCON.RBIF)
	BTFSS       INTCON+0, 0 
	GOTO        L_interrupt6
;calculadora7seg.c,55 :: 		keypadHandler();
	CALL        _keypadHandler+0, 0
;calculadora7seg.c,57 :: 		edge = !edge;
	MOVF        _edge+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _edge+0 
;calculadora7seg.c,58 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;calculadora7seg.c,59 :: 		}
L_interrupt6:
;calculadora7seg.c,60 :: 		}
L_end_interrupt:
L__interrupt67:
	RETFIE      1
; end of _interrupt

_main:

;calculadora7seg.c,62 :: 		void main()
;calculadora7seg.c,65 :: 		T0CON.T08BIT = 0;       // 16 bits
	BCF         T0CON+0, 6 
;calculadora7seg.c,66 :: 		T0CON.T0CS = 0;         // Internal clock => Crystal/4
	BCF         T0CON+0, 5 
;calculadora7seg.c,67 :: 		T0CON.PSA = 0;          // Prescaler ON
	BCF         T0CON+0, 3 
;calculadora7seg.c,70 :: 		T0CON.T0PS2 = 1;
	BSF         T0CON+0, 2 
;calculadora7seg.c,71 :: 		T0CON.T0PS1 = 1;
	BSF         T0CON+0, 1 
;calculadora7seg.c,72 :: 		T0CON.T0PS0 = 1;
	BSF         T0CON+0, 0 
;calculadora7seg.c,75 :: 		TMR0H = COUNTER >> 8;  // Load Timer 0 counter - 1st TMR0H
	MOVLW       255
	MOVWF       TMR0H+0 
;calculadora7seg.c,76 :: 		TMR0L = COUNTER;       // Load Timer 0 counter - 2nd TMR0L
	MOVLW       155
	MOVWF       TMR0L+0 
;calculadora7seg.c,79 :: 		INTCON.TMR0IP = 1;
	BSF         INTCON+0, 2 
;calculadora7seg.c,80 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;calculadora7seg.c,81 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;calculadora7seg.c,82 :: 		INTCON.PEIE=0;
	BCF         INTCON+0, 6 
;calculadora7seg.c,83 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;calculadora7seg.c,86 :: 		T0CON.TMR0ON=1;
	BSF         T0CON+0, 7 
;calculadora7seg.c,89 :: 		ADCON1 = 0x6;
	MOVLW       6
	MOVWF       ADCON1+0 
;calculadora7seg.c,92 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;calculadora7seg.c,95 :: 		TRISB.RB4 = 1; // digital input
	BSF         TRISB+0, 4 
;calculadora7seg.c,96 :: 		TRISB.RB5 = 1; // digital input
	BSF         TRISB+0, 5 
;calculadora7seg.c,97 :: 		TRISB.RB6 = 1; // digital input
	BSF         TRISB+0, 6 
;calculadora7seg.c,98 :: 		TRISB.RB7 = 1; // digital input
	BSF         TRISB+0, 7 
;calculadora7seg.c,100 :: 		TRISB.RB0 = 0; // digital output
	BCF         TRISB+0, 0 
;calculadora7seg.c,101 :: 		TRISB.RB1 = 0;
	BCF         TRISB+0, 1 
;calculadora7seg.c,102 :: 		TRISB.RB2 = 0;
	BCF         TRISB+0, 2 
;calculadora7seg.c,103 :: 		TRISB.RB3 = 0;
	BCF         TRISB+0, 3 
;calculadora7seg.c,105 :: 		PORTB.RB0 = 0; // digital output
	BCF         PORTB+0, 0 
;calculadora7seg.c,106 :: 		PORTB.RB1 = 0;
	BCF         PORTB+0, 1 
;calculadora7seg.c,107 :: 		PORTB.RB2 = 0;
	BCF         PORTB+0, 2 
;calculadora7seg.c,108 :: 		PORTB.RB3 = 0;
	BCF         PORTB+0, 3 
;calculadora7seg.c,111 :: 		TRISD.RD0 = 0; // digital output
	BCF         TRISD+0, 0 
;calculadora7seg.c,112 :: 		TRISD.RD1 = 0;
	BCF         TRISD+0, 1 
;calculadora7seg.c,113 :: 		TRISD.RD2 = 0;
	BCF         TRISD+0, 2 
;calculadora7seg.c,114 :: 		TRISD.RD3 = 0;
	BCF         TRISD+0, 3 
;calculadora7seg.c,115 :: 		TRISD.RD4 = 0;
	BCF         TRISD+0, 4 
;calculadora7seg.c,116 :: 		TRISD.RD5 = 0;
	BCF         TRISD+0, 5 
;calculadora7seg.c,117 :: 		TRISD.RD6 = 0;
	BCF         TRISD+0, 6 
;calculadora7seg.c,118 :: 		TRISD.RD7 = 0;
	BCF         TRISD+0, 7 
;calculadora7seg.c,120 :: 		PORTD.RD0 = 0;
	BCF         PORTD+0, 0 
;calculadora7seg.c,121 :: 		PORTD.RD1 = 0;
	BCF         PORTD+0, 1 
;calculadora7seg.c,122 :: 		PORTD.RD2 = 0;
	BCF         PORTD+0, 2 
;calculadora7seg.c,123 :: 		PORTD.RD3 = 0;
	BCF         PORTD+0, 3 
;calculadora7seg.c,124 :: 		PORTD.RD4 = 0;
	BCF         PORTD+0, 4 
;calculadora7seg.c,125 :: 		PORTD.RD5 = 0;
	BCF         PORTD+0, 5 
;calculadora7seg.c,126 :: 		PORTD.RD6 = 0;
	BCF         PORTD+0, 6 
;calculadora7seg.c,127 :: 		PORTD.RD7 = 0;
	BCF         PORTD+0, 7 
;calculadora7seg.c,130 :: 		TRISA.RA2 = 0; // digital output
	BCF         TRISA+0, 2 
;calculadora7seg.c,131 :: 		TRISA.RA3 = 0;
	BCF         TRISA+0, 3 
;calculadora7seg.c,132 :: 		TRISA.RA4 = 0;
	BCF         TRISA+0, 4 
;calculadora7seg.c,133 :: 		TRISA.RA5 = 0;
	BCF         TRISA+0, 5 
;calculadora7seg.c,135 :: 		PORTA.RA2 = 0;
	BCF         PORTA+0, 2 
;calculadora7seg.c,136 :: 		PORTA.RA3 = 0;
	BCF         PORTA+0, 3 
;calculadora7seg.c,137 :: 		PORTA.RA4 = 0;
	BCF         PORTA+0, 4 
;calculadora7seg.c,138 :: 		PORTA.RA5 = 0;
	BCF         PORTA+0, 5 
;calculadora7seg.c,140 :: 		INTCON.RBIE = 1;
	BSF         INTCON+0, 3 
;calculadora7seg.c,141 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;calculadora7seg.c,142 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_keypadHandler:

;calculadora7seg.c,144 :: 		void keypadHandler()
;calculadora7seg.c,150 :: 		for(i = 0, columnCode = 0x0f; (i < 4) && (columnCode==0x0f); i++)
	CLRF        keypadHandler_i_L0+0 
	MOVLW       15
	MOVWF       _columnCode+0 
L_keypadHandler7:
	MOVLW       4
	SUBWF       keypadHandler_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadHandler8
	MOVF        _columnCode+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler8
L__keypadHandler65:
;calculadora7seg.c,152 :: 		PORTB.RB0 = 1; // digital output
	BSF         PORTB+0, 0 
;calculadora7seg.c,153 :: 		PORTB.RB1 = 1;
	BSF         PORTB+0, 1 
;calculadora7seg.c,154 :: 		PORTB.RB2 = 1;
	BSF         PORTB+0, 2 
;calculadora7seg.c,155 :: 		PORTB.RB3 = 1;
	BSF         PORTB+0, 3 
;calculadora7seg.c,156 :: 		if(i==0)PORTB.RB0 = 0; // digital output
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler12
	BCF         PORTB+0, 0 
L_keypadHandler12:
;calculadora7seg.c,157 :: 		if(i==1)PORTB.RB1 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler13
	BCF         PORTB+0, 1 
L_keypadHandler13:
;calculadora7seg.c,158 :: 		if(i==2)PORTB.RB2 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler14
	BCF         PORTB+0, 2 
L_keypadHandler14:
;calculadora7seg.c,159 :: 		if(i==3)PORTB.RB3 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler15
	BCF         PORTB+0, 3 
L_keypadHandler15:
;calculadora7seg.c,160 :: 		columnCode = PORTB >> 4;
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
;calculadora7seg.c,150 :: 		for(i = 0, columnCode = 0x0f; (i < 4) && (columnCode==0x0f); i++)
	INCF        keypadHandler_i_L0+0, 1 
;calculadora7seg.c,161 :: 		}
	GOTO        L_keypadHandler7
L_keypadHandler8:
;calculadora7seg.c,162 :: 		result = keyHandler(PORTB, &type);
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
;calculadora7seg.c,163 :: 		PORTB.RB0 = 0; // digital output
	BCF         PORTB+0, 0 
;calculadora7seg.c,164 :: 		PORTB.RB1 = 0;
	BCF         PORTB+0, 1 
;calculadora7seg.c,165 :: 		PORTB.RB2 = 0;
	BCF         PORTB+0, 2 
;calculadora7seg.c,166 :: 		PORTB.RB3 = 0;
	BCF         PORTB+0, 3 
;calculadora7seg.c,168 :: 		if(edge == 1)
	MOVF        _edge+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler16
;calculadora7seg.c,171 :: 		if(type == NUM && operation == EMPTY)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler19
	MOVF        _operation+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler19
L__keypadHandler64:
;calculadora7seg.c,173 :: 		operando1 *= 10;
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
;calculadora7seg.c,174 :: 		operando1 += result;
	MOVF        keypadHandler_result_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        keypadHandler_result_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _operando1+0 
	MOVF        R1, 0 
	MOVWF       _operando1+1 
;calculadora7seg.c,175 :: 		numberOnDisplay = operando1;
	MOVF        R0, 0 
	MOVWF       _numberOnDisplay+0 
	MOVF        R1, 0 
	MOVWF       _numberOnDisplay+1 
;calculadora7seg.c,176 :: 		}
L_keypadHandler19:
;calculadora7seg.c,177 :: 		if(type != NUM && type != ON_CLEAR && type != EQUALS)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_keypadHandler22
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_keypadHandler22
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_keypadHandler22
L__keypadHandler63:
;calculadora7seg.c,179 :: 		operation = type;
	MOVF        keypadHandler_type_L0+0, 0 
	MOVWF       _operation+0 
;calculadora7seg.c,180 :: 		}
L_keypadHandler22:
;calculadora7seg.c,181 :: 		if(type == NUM && operation != EMPTY)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler25
	MOVF        _operation+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_keypadHandler25
L__keypadHandler62:
;calculadora7seg.c,183 :: 		operando2 *= 10;
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
;calculadora7seg.c,184 :: 		operando2 += result;
	MOVF        keypadHandler_result_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        keypadHandler_result_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _operando2+0 
	MOVF        R1, 0 
	MOVWF       _operando2+1 
;calculadora7seg.c,185 :: 		numberOnDisplay = operando2;
	MOVF        R0, 0 
	MOVWF       _numberOnDisplay+0 
	MOVF        R1, 0 
	MOVWF       _numberOnDisplay+1 
;calculadora7seg.c,186 :: 		}
L_keypadHandler25:
;calculadora7seg.c,187 :: 		if(type == EQUALS)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler26
;calculadora7seg.c,189 :: 		if(operation == SUM)
	MOVF        _operation+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler27
;calculadora7seg.c,190 :: 		numberOnDisplay = operando1 + operando2;
	MOVF        _operando2+0, 0 
	ADDWF       _operando1+0, 0 
	MOVWF       _numberOnDisplay+0 
	MOVF        _operando2+1, 0 
	ADDWFC      _operando1+1, 0 
	MOVWF       _numberOnDisplay+1 
L_keypadHandler27:
;calculadora7seg.c,192 :: 		if(operation == SUB)
	MOVF        _operation+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler28
;calculadora7seg.c,193 :: 		numberOnDisplay = operando1 - operando2;
	MOVF        _operando2+0, 0 
	SUBWF       _operando1+0, 0 
	MOVWF       _numberOnDisplay+0 
	MOVF        _operando2+1, 0 
	SUBWFB      _operando1+1, 0 
	MOVWF       _numberOnDisplay+1 
L_keypadHandler28:
;calculadora7seg.c,195 :: 		if(operation == MULT)
	MOVF        _operation+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler29
;calculadora7seg.c,196 :: 		numberOnDisplay = operando1 * operando2;
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
L_keypadHandler29:
;calculadora7seg.c,198 :: 		if(operation == DIVI)
	MOVF        _operation+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler30
;calculadora7seg.c,199 :: 		numberOnDisplay = operando1 / operando2;
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
L_keypadHandler30:
;calculadora7seg.c,200 :: 		}
L_keypadHandler26:
;calculadora7seg.c,201 :: 		if(type == ON_CLEAR)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler31
;calculadora7seg.c,203 :: 		operando1 = 0;
	CLRF        _operando1+0 
	CLRF        _operando1+1 
;calculadora7seg.c,204 :: 		operando2 = 0;
	CLRF        _operando2+0 
	CLRF        _operando2+1 
;calculadora7seg.c,205 :: 		operation = EMPTY;
	MOVLW       7
	MOVWF       _operation+0 
;calculadora7seg.c,206 :: 		numberOnDisplay = 0;
	CLRF        _numberOnDisplay+0 
	CLRF        _numberOnDisplay+1 
;calculadora7seg.c,207 :: 		}
L_keypadHandler31:
;calculadora7seg.c,208 :: 		}
L_keypadHandler16:
;calculadora7seg.c,209 :: 		}
L_end_keypadHandler:
	RETURN      0
; end of _keypadHandler

_keyHandler:

;calculadora7seg.c,212 :: 		int keyHandler (int key, KeyType* type)
;calculadora7seg.c,214 :: 		int result = -1;
	MOVLW       255
	MOVWF       keyHandler_result_L0+0 
	MOVLW       255
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,215 :: 		switch(key)
	GOTO        L_keyHandler32
;calculadora7seg.c,217 :: 		case 231:
L_keyHandler34:
;calculadora7seg.c,218 :: 		*type = ON_CLEAR;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       5
	MOVWF       POSTINC1+0 
;calculadora7seg.c,219 :: 		break;
	GOTO        L_keyHandler33
;calculadora7seg.c,221 :: 		case 215:
L_keyHandler35:
;calculadora7seg.c,222 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,223 :: 		result = 0;
	CLRF        keyHandler_result_L0+0 
	CLRF        keyHandler_result_L0+1 
;calculadora7seg.c,224 :: 		break;
	GOTO        L_keyHandler33
;calculadora7seg.c,226 :: 		case 183:
L_keyHandler36:
;calculadora7seg.c,227 :: 		*type = EQUALS;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	CLRF        POSTINC1+0 
;calculadora7seg.c,228 :: 		break;
	GOTO        L_keyHandler33
;calculadora7seg.c,230 :: 		case 119:
L_keyHandler37:
;calculadora7seg.c,231 :: 		*type = SUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
;calculadora7seg.c,232 :: 		break;
	GOTO        L_keyHandler33
;calculadora7seg.c,234 :: 		case 235:
L_keyHandler38:
;calculadora7seg.c,235 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,236 :: 		result = 1;
	MOVLW       1
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,237 :: 		break;
	GOTO        L_keyHandler33
;calculadora7seg.c,239 :: 		case 219:
L_keyHandler39:
;calculadora7seg.c,240 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,241 :: 		result = 2;
	MOVLW       2
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,242 :: 		break;
	GOTO        L_keyHandler33
;calculadora7seg.c,244 :: 		case 187:
L_keyHandler40:
;calculadora7seg.c,245 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,246 :: 		result = 3;
	MOVLW       3
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,247 :: 		break;
	GOTO        L_keyHandler33
;calculadora7seg.c,249 :: 		case 123:
L_keyHandler41:
;calculadora7seg.c,250 :: 		*type = SUB;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       2
	MOVWF       POSTINC1+0 
;calculadora7seg.c,251 :: 		break;
	GOTO        L_keyHandler33
;calculadora7seg.c,253 :: 		case 237:
L_keyHandler42:
;calculadora7seg.c,254 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,255 :: 		result = 4;
	MOVLW       4
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,256 :: 		break;
	GOTO        L_keyHandler33
;calculadora7seg.c,258 :: 		case 221:
L_keyHandler43:
;calculadora7seg.c,259 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,260 :: 		result = 5;
	MOVLW       5
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,261 :: 		break;
	GOTO        L_keyHandler33
;calculadora7seg.c,263 :: 		case 189:
L_keyHandler44:
;calculadora7seg.c,264 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,265 :: 		result = 6;
	MOVLW       6
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,266 :: 		break;
	GOTO        L_keyHandler33
;calculadora7seg.c,268 :: 		case 125:
L_keyHandler45:
;calculadora7seg.c,269 :: 		*type = MULT;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       3
	MOVWF       POSTINC1+0 
;calculadora7seg.c,270 :: 		break;
	GOTO        L_keyHandler33
;calculadora7seg.c,272 :: 		case 238:
L_keyHandler46:
;calculadora7seg.c,273 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,274 :: 		result = 7;
	MOVLW       7
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,275 :: 		break;
	GOTO        L_keyHandler33
;calculadora7seg.c,277 :: 		case 222:
L_keyHandler47:
;calculadora7seg.c,278 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,279 :: 		result = 8;
	MOVLW       8
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,280 :: 		break;
	GOTO        L_keyHandler33
;calculadora7seg.c,282 :: 		case 190:
L_keyHandler48:
;calculadora7seg.c,283 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,284 :: 		result = 9;
	MOVLW       9
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,285 :: 		break;
	GOTO        L_keyHandler33
;calculadora7seg.c,287 :: 		case 126:
L_keyHandler49:
;calculadora7seg.c,288 :: 		*type = DIVI;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       4
	MOVWF       POSTINC1+0 
;calculadora7seg.c,289 :: 		break;
	GOTO        L_keyHandler33
;calculadora7seg.c,290 :: 		}
L_keyHandler32:
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler76
	MOVLW       231
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler76:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler34
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler77
	MOVLW       215
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler77:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler35
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler78
	MOVLW       183
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler78:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler36
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler79
	MOVLW       119
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler79:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler37
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler80
	MOVLW       235
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler80:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler38
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler81
	MOVLW       219
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler81:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler39
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler82
	MOVLW       187
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler82:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler40
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler83
	MOVLW       123
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler83:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler41
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler84
	MOVLW       237
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler84:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler42
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler85
	MOVLW       221
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler85:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler43
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler86
	MOVLW       189
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler86:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler44
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler87
	MOVLW       125
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler87:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler45
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler88
	MOVLW       238
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler88:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler46
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler89
	MOVLW       222
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler89:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler47
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler90
	MOVLW       190
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler90:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler48
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler91
	MOVLW       126
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler91:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler49
L_keyHandler33:
;calculadora7seg.c,292 :: 		return result;
	MOVF        keyHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keyHandler_result_L0+1, 0 
	MOVWF       R1 
;calculadora7seg.c,293 :: 		}
L_end_keyHandler:
	RETURN      0
; end of _keyHandler

_display:

;calculadora7seg.c,296 :: 		unsigned int display ()
;calculadora7seg.c,298 :: 		int number = (int)(numberOnDisplay/pow(10, nDigit)) % 10;
	MOVLW       0
	MOVWF       FARG_pow_x+0 
	MOVLW       0
	MOVWF       FARG_pow_x+1 
	MOVLW       32
	MOVWF       FARG_pow_x+2 
	MOVLW       130
	MOVWF       FARG_pow_x+3 
	MOVF        _nDigit+0, 0 
	MOVWF       R0 
	MOVF        _nDigit+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_pow_y+0 
	MOVF        R1, 0 
	MOVWF       FARG_pow_y+1 
	MOVF        R2, 0 
	MOVWF       FARG_pow_y+2 
	MOVF        R3, 0 
	MOVWF       FARG_pow_y+3 
	CALL        _pow+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__display+0 
	MOVF        R1, 0 
	MOVWF       FLOC__display+1 
	MOVF        R2, 0 
	MOVWF       FLOC__display+2 
	MOVF        R3, 0 
	MOVWF       FLOC__display+3 
	MOVF        _numberOnDisplay+0, 0 
	MOVWF       R0 
	MOVF        _numberOnDisplay+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        FLOC__display+0, 0 
	MOVWF       R4 
	MOVF        FLOC__display+1, 0 
	MOVWF       R5 
	MOVF        FLOC__display+2, 0 
	MOVWF       R6 
	MOVF        FLOC__display+3, 0 
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	CALL        _Double2Int+0, 0
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
;calculadora7seg.c,299 :: 		switch(number)
	GOTO        L_display50
;calculadora7seg.c,301 :: 		case 0: return 0x3F;
L_display52:
	MOVLW       63
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,302 :: 		case 1: return 0x06;
L_display53:
	MOVLW       6
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,303 :: 		case 2: return 0x5B;
L_display54:
	MOVLW       91
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,304 :: 		case 3: return 0x4F;
L_display55:
	MOVLW       79
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,305 :: 		case 4: return 0x66;
L_display56:
	MOVLW       102
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,306 :: 		case 5: return 0x6D;
L_display57:
	MOVLW       109
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,307 :: 		case 6: return 0x7D;
L_display58:
	MOVLW       125
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,308 :: 		case 7: return 0x07;
L_display59:
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,309 :: 		case 8: return 0x7F;
L_display60:
	MOVLW       127
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,310 :: 		case 9: return 0x6F;
L_display61:
	MOVLW       111
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,311 :: 		}
L_display50:
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display93
	MOVLW       0
	XORWF       display_number_L0+0, 0 
L__display93:
	BTFSC       STATUS+0, 2 
	GOTO        L_display52
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display94
	MOVLW       1
	XORWF       display_number_L0+0, 0 
L__display94:
	BTFSC       STATUS+0, 2 
	GOTO        L_display53
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display95
	MOVLW       2
	XORWF       display_number_L0+0, 0 
L__display95:
	BTFSC       STATUS+0, 2 
	GOTO        L_display54
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display96
	MOVLW       3
	XORWF       display_number_L0+0, 0 
L__display96:
	BTFSC       STATUS+0, 2 
	GOTO        L_display55
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display97
	MOVLW       4
	XORWF       display_number_L0+0, 0 
L__display97:
	BTFSC       STATUS+0, 2 
	GOTO        L_display56
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display98
	MOVLW       5
	XORWF       display_number_L0+0, 0 
L__display98:
	BTFSC       STATUS+0, 2 
	GOTO        L_display57
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display99
	MOVLW       6
	XORWF       display_number_L0+0, 0 
L__display99:
	BTFSC       STATUS+0, 2 
	GOTO        L_display58
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display100
	MOVLW       7
	XORWF       display_number_L0+0, 0 
L__display100:
	BTFSC       STATUS+0, 2 
	GOTO        L_display59
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display101
	MOVLW       8
	XORWF       display_number_L0+0, 0 
L__display101:
	BTFSC       STATUS+0, 2 
	GOTO        L_display60
	MOVLW       0
	XORWF       display_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display102
	MOVLW       9
	XORWF       display_number_L0+0, 0 
L__display102:
	BTFSC       STATUS+0, 2 
	GOTO        L_display61
;calculadora7seg.c,312 :: 		}
L_end_display:
	RETURN      0
; end of _display
