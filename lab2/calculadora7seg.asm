
_interrupt:

;calculadora7seg.c,24 :: 		void interrupt(void)
;calculadora7seg.c,26 :: 		if(INTCON.RBIF)
	BTFSS       INTCON+0, 0 
	GOTO        L_interrupt0
;calculadora7seg.c,28 :: 		keypadHandler();
	CALL        _keypadHandler+0, 0
;calculadora7seg.c,30 :: 		edge = !edge;
	MOVF        _edge+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _edge+0 
;calculadora7seg.c,31 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;calculadora7seg.c,32 :: 		}
L_interrupt0:
;calculadora7seg.c,33 :: 		}
L_end_interrupt:
L__interrupt61:
	RETFIE      1
; end of _interrupt

_main:

;calculadora7seg.c,35 :: 		void main()
;calculadora7seg.c,38 :: 		ADCON1 = 0x6;
	MOVLW       6
	MOVWF       ADCON1+0 
;calculadora7seg.c,41 :: 		segmentInit();
	CALL        _segmentInit+0, 0
;calculadora7seg.c,44 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;calculadora7seg.c,47 :: 		TRISB.RB4 = 1; // digital input
	BSF         TRISB+0, 4 
;calculadora7seg.c,48 :: 		TRISB.RB5 = 1; // digital input
	BSF         TRISB+0, 5 
;calculadora7seg.c,49 :: 		TRISB.RB6 = 1; // digital input
	BSF         TRISB+0, 6 
;calculadora7seg.c,50 :: 		TRISB.RB7 = 1; // digital input
	BSF         TRISB+0, 7 
;calculadora7seg.c,52 :: 		TRISB.RB0 = 0; // digital output
	BCF         TRISB+0, 0 
;calculadora7seg.c,53 :: 		TRISB.RB1 = 0;
	BCF         TRISB+0, 1 
;calculadora7seg.c,54 :: 		TRISB.RB2 = 0;
	BCF         TRISB+0, 2 
;calculadora7seg.c,55 :: 		TRISB.RB3 = 0;
	BCF         TRISB+0, 3 
;calculadora7seg.c,57 :: 		PORTB.RB0 = 0; // digital output
	BCF         PORTB+0, 0 
;calculadora7seg.c,58 :: 		PORTB.RB1 = 0;
	BCF         PORTB+0, 1 
;calculadora7seg.c,59 :: 		PORTB.RB2 = 0;
	BCF         PORTB+0, 2 
;calculadora7seg.c,60 :: 		PORTB.RB3 = 0;
	BCF         PORTB+0, 3 
;calculadora7seg.c,62 :: 		INTCON.RBIE = 1;
	BSF         INTCON+0, 3 
;calculadora7seg.c,63 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;calculadora7seg.c,64 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_keypadHandler:

;calculadora7seg.c,66 :: 		void keypadHandler()
;calculadora7seg.c,72 :: 		for(i = 0, columnCode = 0x0f; (i < 4) && (columnCode==0x0f); i++)
	CLRF        keypadHandler_i_L0+0 
	MOVLW       15
	MOVWF       _columnCode+0 
L_keypadHandler1:
	MOVLW       4
	SUBWF       keypadHandler_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadHandler2
	MOVF        _columnCode+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler2
L__keypadHandler59:
;calculadora7seg.c,74 :: 		PORTB.RB0 = 1; // digital output
	BSF         PORTB+0, 0 
;calculadora7seg.c,75 :: 		PORTB.RB1 = 1;
	BSF         PORTB+0, 1 
;calculadora7seg.c,76 :: 		PORTB.RB2 = 1;
	BSF         PORTB+0, 2 
;calculadora7seg.c,77 :: 		PORTB.RB3 = 1;
	BSF         PORTB+0, 3 
;calculadora7seg.c,78 :: 		if(i==0)PORTB.RB0 = 0; // digital output
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler6
	BCF         PORTB+0, 0 
L_keypadHandler6:
;calculadora7seg.c,79 :: 		if(i==1)PORTB.RB1 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler7
	BCF         PORTB+0, 1 
L_keypadHandler7:
;calculadora7seg.c,80 :: 		if(i==2)PORTB.RB2 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler8
	BCF         PORTB+0, 2 
L_keypadHandler8:
;calculadora7seg.c,81 :: 		if(i==3)PORTB.RB3 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler9
	BCF         PORTB+0, 3 
L_keypadHandler9:
;calculadora7seg.c,82 :: 		columnCode = PORTB >> 4;
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
;calculadora7seg.c,72 :: 		for(i = 0, columnCode = 0x0f; (i < 4) && (columnCode==0x0f); i++)
	INCF        keypadHandler_i_L0+0, 1 
;calculadora7seg.c,83 :: 		}
	GOTO        L_keypadHandler1
L_keypadHandler2:
;calculadora7seg.c,84 :: 		result = keyHandler(PORTB, &type);
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
;calculadora7seg.c,85 :: 		PORTB.RB0 = 0; // digital output
	BCF         PORTB+0, 0 
;calculadora7seg.c,86 :: 		PORTB.RB1 = 0;
	BCF         PORTB+0, 1 
;calculadora7seg.c,87 :: 		PORTB.RB2 = 0;
	BCF         PORTB+0, 2 
;calculadora7seg.c,88 :: 		PORTB.RB3 = 0;
	BCF         PORTB+0, 3 
;calculadora7seg.c,90 :: 		if(edge == 1)
	MOVF        _edge+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler10
;calculadora7seg.c,92 :: 		segmentClear();
	CALL        _segmentClear+0, 0
;calculadora7seg.c,94 :: 		if(type == NUM && operation == EMPTY)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler13
	MOVF        _operation+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler13
L__keypadHandler58:
;calculadora7seg.c,96 :: 		operando1 *= 10;
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
;calculadora7seg.c,97 :: 		operando1 += result;
	MOVF        keypadHandler_result_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        keypadHandler_result_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _operando1+0 
	MOVF        R1, 0 
	MOVWF       _operando1+1 
;calculadora7seg.c,98 :: 		numberOnDisplay = operando1;
	MOVF        R0, 0 
	MOVWF       _numberOnDisplay+0 
	MOVF        R1, 0 
	MOVWF       _numberOnDisplay+1 
;calculadora7seg.c,99 :: 		}
L_keypadHandler13:
;calculadora7seg.c,100 :: 		if(type != NUM && type != ON_CLEAR && type != EQUALS)
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
L__keypadHandler57:
;calculadora7seg.c,102 :: 		operation = type;
	MOVF        keypadHandler_type_L0+0, 0 
	MOVWF       _operation+0 
;calculadora7seg.c,103 :: 		}
L_keypadHandler16:
;calculadora7seg.c,104 :: 		if(type == NUM && operation != EMPTY)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler19
	MOVF        _operation+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_keypadHandler19
L__keypadHandler56:
;calculadora7seg.c,106 :: 		operando2 *= 10;
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
;calculadora7seg.c,107 :: 		operando2 += result;
	MOVF        keypadHandler_result_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        keypadHandler_result_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _operando2+0 
	MOVF        R1, 0 
	MOVWF       _operando2+1 
;calculadora7seg.c,108 :: 		numberOnDisplay = operando2;
	MOVF        R0, 0 
	MOVWF       _numberOnDisplay+0 
	MOVF        R1, 0 
	MOVWF       _numberOnDisplay+1 
;calculadora7seg.c,109 :: 		}
L_keypadHandler19:
;calculadora7seg.c,110 :: 		if(type == EQUALS)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler20
;calculadora7seg.c,112 :: 		if(operation == SUM)
	MOVF        _operation+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler21
;calculadora7seg.c,113 :: 		numberOnDisplay = operando1 + operando2;
	MOVF        _operando2+0, 0 
	ADDWF       _operando1+0, 0 
	MOVWF       _numberOnDisplay+0 
	MOVF        _operando2+1, 0 
	ADDWFC      _operando1+1, 0 
	MOVWF       _numberOnDisplay+1 
L_keypadHandler21:
;calculadora7seg.c,115 :: 		if(operation == SUB)
	MOVF        _operation+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler22
;calculadora7seg.c,116 :: 		numberOnDisplay = operando1 - operando2;
	MOVF        _operando2+0, 0 
	SUBWF       _operando1+0, 0 
	MOVWF       _numberOnDisplay+0 
	MOVF        _operando2+1, 0 
	SUBWFB      _operando1+1, 0 
	MOVWF       _numberOnDisplay+1 
L_keypadHandler22:
;calculadora7seg.c,118 :: 		if(operation == MULT)
	MOVF        _operation+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler23
;calculadora7seg.c,119 :: 		numberOnDisplay = operando1 * operando2;
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
L_keypadHandler23:
;calculadora7seg.c,121 :: 		if(operation == DIVI)
	MOVF        _operation+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler24
;calculadora7seg.c,122 :: 		numberOnDisplay = operando1 / operando2;
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
L_keypadHandler24:
;calculadora7seg.c,123 :: 		}
L_keypadHandler20:
;calculadora7seg.c,124 :: 		if(type == ON_CLEAR)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler25
;calculadora7seg.c,126 :: 		operando1 = 0;
	CLRF        _operando1+0 
	CLRF        _operando1+1 
;calculadora7seg.c,127 :: 		operando2 = 0;
	CLRF        _operando2+0 
	CLRF        _operando2+1 
;calculadora7seg.c,128 :: 		operation = EMPTY;
	MOVLW       7
	MOVWF       _operation+0 
;calculadora7seg.c,129 :: 		numberOnDisplay = 0;
	CLRF        _numberOnDisplay+0 
	CLRF        _numberOnDisplay+1 
;calculadora7seg.c,130 :: 		}
L_keypadHandler25:
;calculadora7seg.c,132 :: 		segmentOut(numberOnDisplay);
	MOVF        _numberOnDisplay+0, 0 
	MOVWF       FARG_segmentOut_number+0 
	MOVF        _numberOnDisplay+1, 0 
	MOVWF       FARG_segmentOut_number+1 
	CALL        _segmentOut+0, 0
;calculadora7seg.c,133 :: 		}
L_keypadHandler10:
;calculadora7seg.c,134 :: 		}
L_end_keypadHandler:
	RETURN      0
; end of _keypadHandler

_keyHandler:

;calculadora7seg.c,137 :: 		int keyHandler (int key, KeyType* type)
;calculadora7seg.c,139 :: 		int result = -1;
	MOVLW       255
	MOVWF       keyHandler_result_L0+0 
	MOVLW       255
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,140 :: 		switch(key)
	GOTO        L_keyHandler26
;calculadora7seg.c,142 :: 		case 231:
L_keyHandler28:
;calculadora7seg.c,143 :: 		*type = ON_CLEAR;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       5
	MOVWF       POSTINC1+0 
;calculadora7seg.c,144 :: 		break;
	GOTO        L_keyHandler27
;calculadora7seg.c,146 :: 		case 215:
L_keyHandler29:
;calculadora7seg.c,147 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,148 :: 		result = 0;
	CLRF        keyHandler_result_L0+0 
	CLRF        keyHandler_result_L0+1 
;calculadora7seg.c,149 :: 		break;
	GOTO        L_keyHandler27
;calculadora7seg.c,151 :: 		case 183:
L_keyHandler30:
;calculadora7seg.c,152 :: 		*type = EQUALS;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	CLRF        POSTINC1+0 
;calculadora7seg.c,153 :: 		break;
	GOTO        L_keyHandler27
;calculadora7seg.c,155 :: 		case 119:
L_keyHandler31:
;calculadora7seg.c,156 :: 		*type = SUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
;calculadora7seg.c,157 :: 		break;
	GOTO        L_keyHandler27
;calculadora7seg.c,159 :: 		case 235:
L_keyHandler32:
;calculadora7seg.c,160 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,161 :: 		result = 1;
	MOVLW       1
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,162 :: 		break;
	GOTO        L_keyHandler27
;calculadora7seg.c,164 :: 		case 219:
L_keyHandler33:
;calculadora7seg.c,165 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,166 :: 		result = 2;
	MOVLW       2
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,167 :: 		break;
	GOTO        L_keyHandler27
;calculadora7seg.c,169 :: 		case 187:
L_keyHandler34:
;calculadora7seg.c,170 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,171 :: 		result = 3;
	MOVLW       3
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,172 :: 		break;
	GOTO        L_keyHandler27
;calculadora7seg.c,174 :: 		case 123:
L_keyHandler35:
;calculadora7seg.c,175 :: 		*type = SUB;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       2
	MOVWF       POSTINC1+0 
;calculadora7seg.c,176 :: 		break;
	GOTO        L_keyHandler27
;calculadora7seg.c,178 :: 		case 237:
L_keyHandler36:
;calculadora7seg.c,179 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,180 :: 		result = 4;
	MOVLW       4
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,181 :: 		break;
	GOTO        L_keyHandler27
;calculadora7seg.c,183 :: 		case 221:
L_keyHandler37:
;calculadora7seg.c,184 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,185 :: 		result = 5;
	MOVLW       5
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,186 :: 		break;
	GOTO        L_keyHandler27
;calculadora7seg.c,188 :: 		case 189:
L_keyHandler38:
;calculadora7seg.c,189 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,190 :: 		result = 6;
	MOVLW       6
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,191 :: 		break;
	GOTO        L_keyHandler27
;calculadora7seg.c,193 :: 		case 125:
L_keyHandler39:
;calculadora7seg.c,194 :: 		*type = MULT;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       3
	MOVWF       POSTINC1+0 
;calculadora7seg.c,195 :: 		break;
	GOTO        L_keyHandler27
;calculadora7seg.c,197 :: 		case 238:
L_keyHandler40:
;calculadora7seg.c,198 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,199 :: 		result = 7;
	MOVLW       7
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,200 :: 		break;
	GOTO        L_keyHandler27
;calculadora7seg.c,202 :: 		case 222:
L_keyHandler41:
;calculadora7seg.c,203 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,204 :: 		result = 8;
	MOVLW       8
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,205 :: 		break;
	GOTO        L_keyHandler27
;calculadora7seg.c,207 :: 		case 190:
L_keyHandler42:
;calculadora7seg.c,208 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadora7seg.c,209 :: 		result = 9;
	MOVLW       9
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;calculadora7seg.c,210 :: 		break;
	GOTO        L_keyHandler27
;calculadora7seg.c,212 :: 		case 126:
L_keyHandler43:
;calculadora7seg.c,213 :: 		*type = DIVI;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       4
	MOVWF       POSTINC1+0 
;calculadora7seg.c,214 :: 		break;
	GOTO        L_keyHandler27
;calculadora7seg.c,215 :: 		}
L_keyHandler26:
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler65
	MOVLW       231
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler65:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler28
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler66
	MOVLW       215
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler66:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler29
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler67
	MOVLW       183
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler67:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler30
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler68
	MOVLW       119
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler68:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler31
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler69
	MOVLW       235
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler69:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler32
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler70
	MOVLW       219
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler70:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler33
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler71
	MOVLW       187
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler71:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler34
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler72
	MOVLW       123
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler72:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler35
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler73
	MOVLW       237
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler73:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler36
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler74
	MOVLW       221
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler74:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler37
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler75
	MOVLW       189
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler75:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler38
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler76
	MOVLW       125
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler76:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler39
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler77
	MOVLW       238
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler77:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler40
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler78
	MOVLW       222
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler78:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler41
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler79
	MOVLW       190
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler79:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler42
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler80
	MOVLW       126
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler80:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler43
L_keyHandler27:
;calculadora7seg.c,217 :: 		return result;
	MOVF        keyHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keyHandler_result_L0+1, 0 
	MOVWF       R1 
;calculadora7seg.c,218 :: 		}
L_end_keyHandler:
	RETURN      0
; end of _keyHandler

_segmentInit:

;calculadora7seg.c,220 :: 		void segmentInit()
;calculadora7seg.c,222 :: 		}
L_end_segmentInit:
	RETURN      0
; end of _segmentInit

_segmentClear:

;calculadora7seg.c,224 :: 		void segmentClear()
;calculadora7seg.c,226 :: 		}
L_end_segmentClear:
	RETURN      0
; end of _segmentClear

_segmentOut:

;calculadora7seg.c,228 :: 		void segmentOut(int number)
;calculadora7seg.c,230 :: 		}
L_end_segmentOut:
	RETURN      0
; end of _segmentOut

_display:

;calculadora7seg.c,232 :: 		unsigned int display (int number)
;calculadora7seg.c,234 :: 		switch(number)
	GOTO        L_display44
;calculadora7seg.c,236 :: 		case 0: return 0x3F ;
L_display46:
	MOVLW       63
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,237 :: 		case 1: return 0x06;
L_display47:
	MOVLW       6
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,238 :: 		case 2: return 0x5B;
L_display48:
	MOVLW       91
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,239 :: 		case 3: return 0x4F;
L_display49:
	MOVLW       79
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,240 :: 		case 4: return 0x66;
L_display50:
	MOVLW       102
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,241 :: 		case 5: return 0x6D;
L_display51:
	MOVLW       109
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,242 :: 		case 6: return 0x7D;
L_display52:
	MOVLW       125
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,243 :: 		case 7: return 0x07;
L_display53:
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,244 :: 		case 8: return 0x7F;
L_display54:
	MOVLW       127
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,245 :: 		case 9: return 0x67;
L_display55:
	MOVLW       103
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_display
;calculadora7seg.c,246 :: 		}
L_display44:
	MOVLW       0
	XORWF       FARG_display_number+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display85
	MOVLW       0
	XORWF       FARG_display_number+0, 0 
L__display85:
	BTFSC       STATUS+0, 2 
	GOTO        L_display46
	MOVLW       0
	XORWF       FARG_display_number+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display86
	MOVLW       1
	XORWF       FARG_display_number+0, 0 
L__display86:
	BTFSC       STATUS+0, 2 
	GOTO        L_display47
	MOVLW       0
	XORWF       FARG_display_number+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display87
	MOVLW       2
	XORWF       FARG_display_number+0, 0 
L__display87:
	BTFSC       STATUS+0, 2 
	GOTO        L_display48
	MOVLW       0
	XORWF       FARG_display_number+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display88
	MOVLW       3
	XORWF       FARG_display_number+0, 0 
L__display88:
	BTFSC       STATUS+0, 2 
	GOTO        L_display49
	MOVLW       0
	XORWF       FARG_display_number+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display89
	MOVLW       4
	XORWF       FARG_display_number+0, 0 
L__display89:
	BTFSC       STATUS+0, 2 
	GOTO        L_display50
	MOVLW       0
	XORWF       FARG_display_number+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display90
	MOVLW       5
	XORWF       FARG_display_number+0, 0 
L__display90:
	BTFSC       STATUS+0, 2 
	GOTO        L_display51
	MOVLW       0
	XORWF       FARG_display_number+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display91
	MOVLW       6
	XORWF       FARG_display_number+0, 0 
L__display91:
	BTFSC       STATUS+0, 2 
	GOTO        L_display52
	MOVLW       0
	XORWF       FARG_display_number+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display92
	MOVLW       7
	XORWF       FARG_display_number+0, 0 
L__display92:
	BTFSC       STATUS+0, 2 
	GOTO        L_display53
	MOVLW       0
	XORWF       FARG_display_number+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display93
	MOVLW       8
	XORWF       FARG_display_number+0, 0 
L__display93:
	BTFSC       STATUS+0, 2 
	GOTO        L_display54
	MOVLW       0
	XORWF       FARG_display_number+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__display94
	MOVLW       9
	XORWF       FARG_display_number+0, 0 
L__display94:
	BTFSC       STATUS+0, 2 
	GOTO        L_display55
;calculadora7seg.c,247 :: 		}
L_end_display:
	RETURN      0
; end of _display
