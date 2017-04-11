
_interrupt:

;calculadoraLCD.c,30 :: 		void interrupt(void)
;calculadoraLCD.c,32 :: 		if(INTCON.RBIF)
	BTFSS       INTCON+0, 0 
	GOTO        L_interrupt0
;calculadoraLCD.c,34 :: 		keypadHandler();
	CALL        _keypadHandler+0, 0
;calculadoraLCD.c,36 :: 		edge = !edge;
	MOVF        _edge+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _edge+0 
;calculadoraLCD.c,37 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;calculadoraLCD.c,38 :: 		}
L_interrupt0:
;calculadoraLCD.c,39 :: 		}
L_end_interrupt:
L__interrupt50:
	RETFIE      1
; end of _interrupt

_main:

;calculadoraLCD.c,41 :: 		void main()
;calculadoraLCD.c,44 :: 		ADCON1 = 0x6;
	MOVLW       6
	MOVWF       ADCON1+0 
;calculadoraLCD.c,47 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;calculadoraLCD.c,50 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;calculadoraLCD.c,53 :: 		TRISB.RB4 = 1; // digital input
	BSF         TRISB+0, 4 
;calculadoraLCD.c,54 :: 		TRISB.RB5 = 1; // digital input
	BSF         TRISB+0, 5 
;calculadoraLCD.c,55 :: 		TRISB.RB6 = 1; // digital input
	BSF         TRISB+0, 6 
;calculadoraLCD.c,56 :: 		TRISB.RB7 = 1; // digital input
	BSF         TRISB+0, 7 
;calculadoraLCD.c,58 :: 		TRISB.RB0 = 0; // digital output
	BCF         TRISB+0, 0 
;calculadoraLCD.c,59 :: 		TRISB.RB1 = 0;
	BCF         TRISB+0, 1 
;calculadoraLCD.c,60 :: 		TRISB.RB2 = 0;
	BCF         TRISB+0, 2 
;calculadoraLCD.c,61 :: 		TRISB.RB3 = 0;
	BCF         TRISB+0, 3 
;calculadoraLCD.c,63 :: 		PORTB.RB0 = 0; // digital output
	BCF         PORTB+0, 0 
;calculadoraLCD.c,64 :: 		PORTB.RB1 = 0;
	BCF         PORTB+0, 1 
;calculadoraLCD.c,65 :: 		PORTB.RB2 = 0;
	BCF         PORTB+0, 2 
;calculadoraLCD.c,66 :: 		PORTB.RB3 = 0;
	BCF         PORTB+0, 3 
;calculadoraLCD.c,68 :: 		INTCON.RBIE = 1;
	BSF         INTCON+0, 3 
;calculadoraLCD.c,69 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;calculadoraLCD.c,70 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_keypadHandler:

;calculadoraLCD.c,72 :: 		void keypadHandler()
;calculadoraLCD.c,78 :: 		for(i = 0, xx = 0x0f; (i < 4) && (xx==0x0f); i++)
	CLRF        keypadHandler_i_L0+0 
	MOVLW       15
	MOVWF       _xx+0 
L_keypadHandler1:
	MOVLW       4
	SUBWF       keypadHandler_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadHandler2
	MOVF        _xx+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler2
L__keypadHandler48:
;calculadoraLCD.c,80 :: 		PORTB.RB0 = 1; // digital output
	BSF         PORTB+0, 0 
;calculadoraLCD.c,81 :: 		PORTB.RB1 = 1;
	BSF         PORTB+0, 1 
;calculadoraLCD.c,82 :: 		PORTB.RB2 = 1;
	BSF         PORTB+0, 2 
;calculadoraLCD.c,83 :: 		PORTB.RB3 = 1;
	BSF         PORTB+0, 3 
;calculadoraLCD.c,84 :: 		if(i==0)PORTB.RB0 = 0; // digital output
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler6
	BCF         PORTB+0, 0 
L_keypadHandler6:
;calculadoraLCD.c,85 :: 		if(i==1)PORTB.RB1 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler7
	BCF         PORTB+0, 1 
L_keypadHandler7:
;calculadoraLCD.c,86 :: 		if(i==2)PORTB.RB2 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler8
	BCF         PORTB+0, 2 
L_keypadHandler8:
;calculadoraLCD.c,87 :: 		if(i==3)PORTB.RB3 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler9
	BCF         PORTB+0, 3 
L_keypadHandler9:
;calculadoraLCD.c,88 :: 		xx = PORTB >> 4;
	MOVF        PORTB+0, 0 
	MOVWF       _xx+0 
	RRCF        _xx+0, 1 
	BCF         _xx+0, 7 
	RRCF        _xx+0, 1 
	BCF         _xx+0, 7 
	RRCF        _xx+0, 1 
	BCF         _xx+0, 7 
	RRCF        _xx+0, 1 
	BCF         _xx+0, 7 
;calculadoraLCD.c,78 :: 		for(i = 0, xx = 0x0f; (i < 4) && (xx==0x0f); i++)
	INCF        keypadHandler_i_L0+0, 1 
;calculadoraLCD.c,89 :: 		}
	GOTO        L_keypadHandler1
L_keypadHandler2:
;calculadoraLCD.c,90 :: 		result = keyHandler(PORTB, &type);
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
;calculadoraLCD.c,91 :: 		PORTB.RB0 = 0; // digital output
	BCF         PORTB+0, 0 
;calculadoraLCD.c,92 :: 		PORTB.RB1 = 0;
	BCF         PORTB+0, 1 
;calculadoraLCD.c,93 :: 		PORTB.RB2 = 0;
	BCF         PORTB+0, 2 
;calculadoraLCD.c,94 :: 		PORTB.RB3 = 0;
	BCF         PORTB+0, 3 
;calculadoraLCD.c,96 :: 		if(edge == 1)
	MOVF        _edge+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler10
;calculadoraLCD.c,98 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;calculadoraLCD.c,100 :: 		if(type == NUM && operation == EMPTY)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler13
	MOVF        _operation+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler13
L__keypadHandler47:
;calculadoraLCD.c,102 :: 		operando1 *= 10;
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
;calculadoraLCD.c,103 :: 		operando1 += result;
	MOVF        keypadHandler_result_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        keypadHandler_result_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _operando1+0 
	MOVF        R1, 0 
	MOVWF       _operando1+1 
;calculadoraLCD.c,104 :: 		IntToStr(operando1, text);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _text+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;calculadoraLCD.c,105 :: 		}
L_keypadHandler13:
;calculadoraLCD.c,106 :: 		if(type != NUM && type != ON_CLEAR && type != EQUALS)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_keypadHandler16
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_keypadHandler16
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_keypadHandler16
L__keypadHandler46:
;calculadoraLCD.c,108 :: 		operation = type;
	MOVF        keypadHandler_type_L0+0, 0 
	MOVWF       _operation+0 
;calculadoraLCD.c,109 :: 		}
L_keypadHandler16:
;calculadoraLCD.c,110 :: 		if(type == NUM && operation != EMPTY)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler19
	MOVF        _operation+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_keypadHandler19
L__keypadHandler45:
;calculadoraLCD.c,112 :: 		operando2 *= 10;
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
;calculadoraLCD.c,113 :: 		operando2 += result;
	MOVF        keypadHandler_result_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        keypadHandler_result_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _operando2+0 
	MOVF        R1, 0 
	MOVWF       _operando2+1 
;calculadoraLCD.c,114 :: 		IntToStr(operando2, text);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _text+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;calculadoraLCD.c,115 :: 		}
L_keypadHandler19:
;calculadoraLCD.c,116 :: 		if(type == EQUALS)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler20
;calculadoraLCD.c,118 :: 		if(operation == SUM)
	MOVF        _operation+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler21
;calculadoraLCD.c,119 :: 		IntToStr(operando1 + operando2, text);
	MOVF        _operando2+0, 0 
	ADDWF       _operando1+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _operando2+1, 0 
	ADDWFC      _operando1+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _text+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
L_keypadHandler21:
;calculadoraLCD.c,121 :: 		if(operation == SUB)
	MOVF        _operation+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler22
;calculadoraLCD.c,122 :: 		IntToStr(operando1 - operando2, text);
	MOVF        _operando2+0, 0 
	SUBWF       _operando1+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _operando2+1, 0 
	SUBWFB      _operando1+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _text+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
L_keypadHandler22:
;calculadoraLCD.c,124 :: 		if(operation == MULT)
	MOVF        _operation+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler23
;calculadoraLCD.c,125 :: 		IntToStr(operando1 * operando2, text);
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
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _text+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
L_keypadHandler23:
;calculadoraLCD.c,127 :: 		if(operation == DIVI)
	MOVF        _operation+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler24
;calculadoraLCD.c,128 :: 		IntToStr(operando1 / operando2, text);
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
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _text+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
L_keypadHandler24:
;calculadoraLCD.c,129 :: 		}
L_keypadHandler20:
;calculadoraLCD.c,130 :: 		if(type == ON_CLEAR)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler25
;calculadoraLCD.c,132 :: 		operando1 = 0;
	CLRF        _operando1+0 
	CLRF        _operando1+1 
;calculadoraLCD.c,133 :: 		operando2 = 0;
	CLRF        _operando2+0 
	CLRF        _operando2+1 
;calculadoraLCD.c,134 :: 		operation = EMPTY;
	MOVLW       7
	MOVWF       _operation+0 
;calculadoraLCD.c,135 :: 		IntToStr(0, text);
	CLRF        FARG_IntToStr_input+0 
	CLRF        FARG_IntToStr_input+1 
	MOVLW       _text+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;calculadoraLCD.c,136 :: 		}
L_keypadHandler25:
;calculadoraLCD.c,139 :: 		Lcd_Out(1,1,text);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _text+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;calculadoraLCD.c,140 :: 		}
	GOTO        L_keypadHandler26
L_keypadHandler10:
;calculadoraLCD.c,144 :: 		}
L_keypadHandler26:
;calculadoraLCD.c,145 :: 		}
L_end_keypadHandler:
	RETURN      0
; end of _keypadHandler

_keyHandler:

;calculadoraLCD.c,148 :: 		int keyHandler (int key, KeyType* type)
;calculadoraLCD.c,150 :: 		int result = -1;
	MOVLW       255
	MOVWF       keyHandler_result_L0+0 
	MOVLW       255
	MOVWF       keyHandler_result_L0+1 
;calculadoraLCD.c,151 :: 		switch(key)
	GOTO        L_keyHandler27
;calculadoraLCD.c,153 :: 		case 231:
L_keyHandler29:
;calculadoraLCD.c,154 :: 		*type = ON_CLEAR;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       5
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,155 :: 		break;
	GOTO        L_keyHandler28
;calculadoraLCD.c,157 :: 		case 215:
L_keyHandler30:
;calculadoraLCD.c,158 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,159 :: 		result = 0;
	CLRF        keyHandler_result_L0+0 
	CLRF        keyHandler_result_L0+1 
;calculadoraLCD.c,160 :: 		break;
	GOTO        L_keyHandler28
;calculadoraLCD.c,162 :: 		case 183:
L_keyHandler31:
;calculadoraLCD.c,163 :: 		*type = EQUALS;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	CLRF        POSTINC1+0 
;calculadoraLCD.c,164 :: 		break;
	GOTO        L_keyHandler28
;calculadoraLCD.c,166 :: 		case 119:
L_keyHandler32:
;calculadoraLCD.c,167 :: 		*type = SUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,168 :: 		break;
	GOTO        L_keyHandler28
;calculadoraLCD.c,170 :: 		case 235:
L_keyHandler33:
;calculadoraLCD.c,171 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,172 :: 		result = 1;
	MOVLW       1
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadoraLCD.c,173 :: 		break;
	GOTO        L_keyHandler28
;calculadoraLCD.c,175 :: 		case 219:
L_keyHandler34:
;calculadoraLCD.c,176 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,177 :: 		result = 2;
	MOVLW       2
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadoraLCD.c,178 :: 		break;
	GOTO        L_keyHandler28
;calculadoraLCD.c,180 :: 		case 187:
L_keyHandler35:
;calculadoraLCD.c,181 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,182 :: 		result = 3;
	MOVLW       3
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadoraLCD.c,183 :: 		break;
	GOTO        L_keyHandler28
;calculadoraLCD.c,185 :: 		case 123:
L_keyHandler36:
;calculadoraLCD.c,186 :: 		*type = SUB;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       2
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,187 :: 		break;
	GOTO        L_keyHandler28
;calculadoraLCD.c,189 :: 		case 237:
L_keyHandler37:
;calculadoraLCD.c,190 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,191 :: 		result = 4;
	MOVLW       4
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadoraLCD.c,192 :: 		break;
	GOTO        L_keyHandler28
;calculadoraLCD.c,194 :: 		case 221:
L_keyHandler38:
;calculadoraLCD.c,195 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,196 :: 		result = 5;
	MOVLW       5
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadoraLCD.c,197 :: 		break;
	GOTO        L_keyHandler28
;calculadoraLCD.c,199 :: 		case 189:
L_keyHandler39:
;calculadoraLCD.c,200 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,201 :: 		result = 6;
	MOVLW       6
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadoraLCD.c,202 :: 		break;
	GOTO        L_keyHandler28
;calculadoraLCD.c,204 :: 		case 125:
L_keyHandler40:
;calculadoraLCD.c,205 :: 		*type = MULT;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       3
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,206 :: 		break;
	GOTO        L_keyHandler28
;calculadoraLCD.c,208 :: 		case 238:
L_keyHandler41:
;calculadoraLCD.c,209 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,210 :: 		result = 7;
	MOVLW       7
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadoraLCD.c,211 :: 		break;
	GOTO        L_keyHandler28
;calculadoraLCD.c,213 :: 		case 222:
L_keyHandler42:
;calculadoraLCD.c,214 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,215 :: 		result = 8;
	MOVLW       8
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadoraLCD.c,216 :: 		break;
	GOTO        L_keyHandler28
;calculadoraLCD.c,218 :: 		case 190:
L_keyHandler43:
;calculadoraLCD.c,219 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,220 :: 		result = 9;
	MOVLW       9
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadoraLCD.c,221 :: 		break;
	GOTO        L_keyHandler28
;calculadoraLCD.c,223 :: 		case 126:
L_keyHandler44:
;calculadoraLCD.c,224 :: 		*type = DIVI;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       4
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,225 :: 		break;
	GOTO        L_keyHandler28
;calculadoraLCD.c,226 :: 		}
L_keyHandler27:
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler54
	MOVLW       231
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler54:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler29
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler55
	MOVLW       215
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler55:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler30
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler56
	MOVLW       183
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler56:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler31
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler57
	MOVLW       119
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler57:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler32
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler58
	MOVLW       235
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler58:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler33
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler59
	MOVLW       219
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler59:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler34
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler60
	MOVLW       187
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler60:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler35
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler61
	MOVLW       123
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler61:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler36
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler62
	MOVLW       237
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler62:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler37
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler63
	MOVLW       221
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler63:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler38
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler64
	MOVLW       189
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler64:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler39
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler65
	MOVLW       125
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler65:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler40
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler66
	MOVLW       238
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler66:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler41
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler67
	MOVLW       222
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler67:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler42
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler68
	MOVLW       190
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler68:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler43
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler69
	MOVLW       126
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler69:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler44
L_keyHandler28:
;calculadoraLCD.c,228 :: 		return result;
	MOVF        keyHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keyHandler_result_L0+1, 0 
	MOVWF       R1 
;calculadoraLCD.c,229 :: 		}
L_end_keyHandler:
	RETURN      0
; end of _keyHandler
