
_interrupt:

;calculadoraLCD.c,27 :: 		void interrupt(void){
;calculadoraLCD.c,28 :: 		if(INTCON.RBIF)
	BTFSS       INTCON+0, 0 
	GOTO        L_interrupt0
;calculadoraLCD.c,35 :: 		for(i = 0, xx = 0x0f; (i < 4) && (xx==0x0f); i++)
	CLRF        interrupt_i_L1+0 
	MOVLW       15
	MOVWF       _xx+0 
L_interrupt1:
	MOVLW       4
	SUBWF       interrupt_i_L1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt2
	MOVF        _xx+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt2
L__interrupt30:
;calculadoraLCD.c,37 :: 		PORTB.RB0 = 1; // digital output
	BSF         PORTB+0, 0 
;calculadoraLCD.c,38 :: 		PORTB.RB1 = 1;
	BSF         PORTB+0, 1 
;calculadoraLCD.c,39 :: 		PORTB.RB2 = 1;
	BSF         PORTB+0, 2 
;calculadoraLCD.c,40 :: 		PORTB.RB3 = 1;
	BSF         PORTB+0, 3 
;calculadoraLCD.c,41 :: 		if(i==0)PORTB.RB0 = 0; // digital output
	MOVF        interrupt_i_L1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt6
	BCF         PORTB+0, 0 
L_interrupt6:
;calculadoraLCD.c,42 :: 		if(i==1)PORTB.RB1 = 0;
	MOVF        interrupt_i_L1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
	BCF         PORTB+0, 1 
L_interrupt7:
;calculadoraLCD.c,43 :: 		if(i==2)PORTB.RB2 = 0;
	MOVF        interrupt_i_L1+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
	BCF         PORTB+0, 2 
L_interrupt8:
;calculadoraLCD.c,44 :: 		if(i==3)PORTB.RB3 = 0;
	MOVF        interrupt_i_L1+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt9
	BCF         PORTB+0, 3 
L_interrupt9:
;calculadoraLCD.c,45 :: 		xx = PORTB >> 4;
	MOVF        PORTB+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	MOVWF       _xx+0 
;calculadoraLCD.c,35 :: 		for(i = 0, xx = 0x0f; (i < 4) && (xx==0x0f); i++)
	INCF        interrupt_i_L1+0, 1 
;calculadoraLCD.c,46 :: 		}
	GOTO        L_interrupt1
L_interrupt2:
;calculadoraLCD.c,48 :: 		result = convertTecla(PORTB, &type);
	MOVF        PORTB+0, 0 
	MOVWF       FARG_convertTecla_tecla+0 
	MOVLW       0
	MOVWF       FARG_convertTecla_tecla+1 
	MOVLW       interrupt_type_L1+0
	MOVWF       FARG_convertTecla_type+0 
	MOVLW       hi_addr(interrupt_type_L1+0)
	MOVWF       FARG_convertTecla_type+1 
	CALL        _convertTecla+0, 0
;calculadoraLCD.c,49 :: 		IntToStr(result, text);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       interrupt_text_L1+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(interrupt_text_L1+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;calculadoraLCD.c,52 :: 		PORTB.RB0 = 0; // digital output
	BCF         PORTB+0, 0 
;calculadoraLCD.c,53 :: 		PORTB.RB1 = 0;
	BCF         PORTB+0, 1 
;calculadoraLCD.c,54 :: 		PORTB.RB2 = 0;
	BCF         PORTB+0, 2 
;calculadoraLCD.c,55 :: 		PORTB.RB3 = 0;
	BCF         PORTB+0, 3 
;calculadoraLCD.c,57 :: 		if(edge == 1)
	MOVF        _edge+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt10
;calculadoraLCD.c,59 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;calculadoraLCD.c,60 :: 		Lcd_Out(1,1,text);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       interrupt_text_L1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(interrupt_text_L1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;calculadoraLCD.c,61 :: 		}
	GOTO        L_interrupt11
L_interrupt10:
;calculadoraLCD.c,65 :: 		}
L_interrupt11:
;calculadoraLCD.c,67 :: 		edge = !edge;
	MOVF        _edge+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _edge+0 
;calculadoraLCD.c,68 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;calculadoraLCD.c,69 :: 		}
L_interrupt0:
;calculadoraLCD.c,70 :: 		}
L_end_interrupt:
L__interrupt32:
	RETFIE      1
; end of _interrupt

_main:

;calculadoraLCD.c,72 :: 		void main()
;calculadoraLCD.c,75 :: 		ADCON1 = 0x6;
	MOVLW       6
	MOVWF       ADCON1+0 
;calculadoraLCD.c,78 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;calculadoraLCD.c,81 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;calculadoraLCD.c,84 :: 		TRISB.RB4 = 1; // digital input
	BSF         TRISB+0, 4 
;calculadoraLCD.c,85 :: 		TRISB.RB5 = 1; // digital input
	BSF         TRISB+0, 5 
;calculadoraLCD.c,86 :: 		TRISB.RB6 = 1; // digital input
	BSF         TRISB+0, 6 
;calculadoraLCD.c,87 :: 		TRISB.RB7 = 1; // digital input
	BSF         TRISB+0, 7 
;calculadoraLCD.c,89 :: 		TRISB.RB0 = 0; // digital output
	BCF         TRISB+0, 0 
;calculadoraLCD.c,90 :: 		TRISB.RB1 = 0;
	BCF         TRISB+0, 1 
;calculadoraLCD.c,91 :: 		TRISB.RB2 = 0;
	BCF         TRISB+0, 2 
;calculadoraLCD.c,92 :: 		TRISB.RB3 = 0;
	BCF         TRISB+0, 3 
;calculadoraLCD.c,94 :: 		PORTB.RB0 = 0; // digital output
	BCF         PORTB+0, 0 
;calculadoraLCD.c,95 :: 		PORTB.RB1 = 0;
	BCF         PORTB+0, 1 
;calculadoraLCD.c,96 :: 		PORTB.RB2 = 0;
	BCF         PORTB+0, 2 
;calculadoraLCD.c,97 :: 		PORTB.RB3 = 0;
	BCF         PORTB+0, 3 
;calculadoraLCD.c,99 :: 		INTCON.RBIE = 1;
	BSF         INTCON+0, 3 
;calculadoraLCD.c,100 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;calculadoraLCD.c,101 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_convertTecla:

;calculadoraLCD.c,103 :: 		int convertTecla (int tecla, KeyType* type)
;calculadoraLCD.c,105 :: 		int result = -1;
	MOVLW       255
	MOVWF       convertTecla_result_L0+0 
	MOVLW       255
	MOVWF       convertTecla_result_L0+1 
;calculadoraLCD.c,106 :: 		switch(tecla)
	GOTO        L_convertTecla12
;calculadoraLCD.c,108 :: 		case 231:
L_convertTecla14:
;calculadoraLCD.c,109 :: 		*type = ON_CLEAR;
	MOVFF       FARG_convertTecla_type+0, FSR1
	MOVFF       FARG_convertTecla_type+1, FSR1H
	MOVLW       5
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,110 :: 		break;
	GOTO        L_convertTecla13
;calculadoraLCD.c,112 :: 		case 215:
L_convertTecla15:
;calculadoraLCD.c,113 :: 		*type = NUM;
	MOVFF       FARG_convertTecla_type+0, FSR1
	MOVFF       FARG_convertTecla_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,114 :: 		result = 0;
	CLRF        convertTecla_result_L0+0 
	CLRF        convertTecla_result_L0+1 
;calculadoraLCD.c,115 :: 		break;
	GOTO        L_convertTecla13
;calculadoraLCD.c,117 :: 		case 183:
L_convertTecla16:
;calculadoraLCD.c,118 :: 		*type = IGUAL;
	MOVFF       FARG_convertTecla_type+0, FSR1
	MOVFF       FARG_convertTecla_type+1, FSR1H
	CLRF        POSTINC1+0 
;calculadoraLCD.c,119 :: 		break;
	GOTO        L_convertTecla13
;calculadoraLCD.c,121 :: 		case 119:
L_convertTecla17:
;calculadoraLCD.c,122 :: 		*type = SOMA;
	MOVFF       FARG_convertTecla_type+0, FSR1
	MOVFF       FARG_convertTecla_type+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,123 :: 		break;
	GOTO        L_convertTecla13
;calculadoraLCD.c,125 :: 		case 235:
L_convertTecla18:
;calculadoraLCD.c,126 :: 		*type = NUM;
	MOVFF       FARG_convertTecla_type+0, FSR1
	MOVFF       FARG_convertTecla_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,127 :: 		result = 1;
	MOVLW       1
	MOVWF       convertTecla_result_L0+0 
	MOVLW       0
	MOVWF       convertTecla_result_L0+1 
;calculadoraLCD.c,128 :: 		break;
	GOTO        L_convertTecla13
;calculadoraLCD.c,130 :: 		case 219:
L_convertTecla19:
;calculadoraLCD.c,131 :: 		*type = NUM;
	MOVFF       FARG_convertTecla_type+0, FSR1
	MOVFF       FARG_convertTecla_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,132 :: 		result = 2;
	MOVLW       2
	MOVWF       convertTecla_result_L0+0 
	MOVLW       0
	MOVWF       convertTecla_result_L0+1 
;calculadoraLCD.c,133 :: 		break;
	GOTO        L_convertTecla13
;calculadoraLCD.c,135 :: 		case 187:
L_convertTecla20:
;calculadoraLCD.c,136 :: 		*type = NUM;
	MOVFF       FARG_convertTecla_type+0, FSR1
	MOVFF       FARG_convertTecla_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,137 :: 		result = 3;
	MOVLW       3
	MOVWF       convertTecla_result_L0+0 
	MOVLW       0
	MOVWF       convertTecla_result_L0+1 
;calculadoraLCD.c,138 :: 		break;
	GOTO        L_convertTecla13
;calculadoraLCD.c,140 :: 		case 123:
L_convertTecla21:
;calculadoraLCD.c,141 :: 		*type = SUB;
	MOVFF       FARG_convertTecla_type+0, FSR1
	MOVFF       FARG_convertTecla_type+1, FSR1H
	MOVLW       2
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,142 :: 		break;
	GOTO        L_convertTecla13
;calculadoraLCD.c,144 :: 		case 237:
L_convertTecla22:
;calculadoraLCD.c,145 :: 		*type = NUM;
	MOVFF       FARG_convertTecla_type+0, FSR1
	MOVFF       FARG_convertTecla_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,146 :: 		result = 4;
	MOVLW       4
	MOVWF       convertTecla_result_L0+0 
	MOVLW       0
	MOVWF       convertTecla_result_L0+1 
;calculadoraLCD.c,147 :: 		break;
	GOTO        L_convertTecla13
;calculadoraLCD.c,149 :: 		case 221:
L_convertTecla23:
;calculadoraLCD.c,150 :: 		*type = NUM;
	MOVFF       FARG_convertTecla_type+0, FSR1
	MOVFF       FARG_convertTecla_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,151 :: 		result = 5;
	MOVLW       5
	MOVWF       convertTecla_result_L0+0 
	MOVLW       0
	MOVWF       convertTecla_result_L0+1 
;calculadoraLCD.c,152 :: 		break;
	GOTO        L_convertTecla13
;calculadoraLCD.c,154 :: 		case 189:
L_convertTecla24:
;calculadoraLCD.c,155 :: 		*type = NUM;
	MOVFF       FARG_convertTecla_type+0, FSR1
	MOVFF       FARG_convertTecla_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,156 :: 		result = 6;
	MOVLW       6
	MOVWF       convertTecla_result_L0+0 
	MOVLW       0
	MOVWF       convertTecla_result_L0+1 
;calculadoraLCD.c,157 :: 		break;
	GOTO        L_convertTecla13
;calculadoraLCD.c,159 :: 		case 125:
L_convertTecla25:
;calculadoraLCD.c,160 :: 		*type = MULT;
	MOVFF       FARG_convertTecla_type+0, FSR1
	MOVFF       FARG_convertTecla_type+1, FSR1H
	MOVLW       3
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,161 :: 		break;
	GOTO        L_convertTecla13
;calculadoraLCD.c,163 :: 		case 238:
L_convertTecla26:
;calculadoraLCD.c,164 :: 		*type = NUM;
	MOVFF       FARG_convertTecla_type+0, FSR1
	MOVFF       FARG_convertTecla_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,165 :: 		result = 7;
	MOVLW       7
	MOVWF       convertTecla_result_L0+0 
	MOVLW       0
	MOVWF       convertTecla_result_L0+1 
;calculadoraLCD.c,166 :: 		break;
	GOTO        L_convertTecla13
;calculadoraLCD.c,168 :: 		case 222:
L_convertTecla27:
;calculadoraLCD.c,169 :: 		*type = NUM;
	MOVFF       FARG_convertTecla_type+0, FSR1
	MOVFF       FARG_convertTecla_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,170 :: 		result = 8;
	MOVLW       8
	MOVWF       convertTecla_result_L0+0 
	MOVLW       0
	MOVWF       convertTecla_result_L0+1 
;calculadoraLCD.c,171 :: 		break;
	GOTO        L_convertTecla13
;calculadoraLCD.c,173 :: 		case 190:
L_convertTecla28:
;calculadoraLCD.c,174 :: 		*type = NUM;
	MOVFF       FARG_convertTecla_type+0, FSR1
	MOVFF       FARG_convertTecla_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,175 :: 		result = 9;
	MOVLW       9
	MOVWF       convertTecla_result_L0+0 
	MOVLW       0
	MOVWF       convertTecla_result_L0+1 
;calculadoraLCD.c,176 :: 		break;
	GOTO        L_convertTecla13
;calculadoraLCD.c,178 :: 		case 126:
L_convertTecla29:
;calculadoraLCD.c,179 :: 		*type = DIVI;
	MOVFF       FARG_convertTecla_type+0, FSR1
	MOVFF       FARG_convertTecla_type+1, FSR1H
	MOVLW       4
	MOVWF       POSTINC1+0 
;calculadoraLCD.c,180 :: 		break;
	GOTO        L_convertTecla13
;calculadoraLCD.c,181 :: 		}
L_convertTecla12:
	MOVLW       0
	XORWF       FARG_convertTecla_tecla+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convertTecla35
	MOVLW       231
	XORWF       FARG_convertTecla_tecla+0, 0 
L__convertTecla35:
	BTFSC       STATUS+0, 2 
	GOTO        L_convertTecla14
	MOVLW       0
	XORWF       FARG_convertTecla_tecla+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convertTecla36
	MOVLW       215
	XORWF       FARG_convertTecla_tecla+0, 0 
L__convertTecla36:
	BTFSC       STATUS+0, 2 
	GOTO        L_convertTecla15
	MOVLW       0
	XORWF       FARG_convertTecla_tecla+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convertTecla37
	MOVLW       183
	XORWF       FARG_convertTecla_tecla+0, 0 
L__convertTecla37:
	BTFSC       STATUS+0, 2 
	GOTO        L_convertTecla16
	MOVLW       0
	XORWF       FARG_convertTecla_tecla+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convertTecla38
	MOVLW       119
	XORWF       FARG_convertTecla_tecla+0, 0 
L__convertTecla38:
	BTFSC       STATUS+0, 2 
	GOTO        L_convertTecla17
	MOVLW       0
	XORWF       FARG_convertTecla_tecla+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convertTecla39
	MOVLW       235
	XORWF       FARG_convertTecla_tecla+0, 0 
L__convertTecla39:
	BTFSC       STATUS+0, 2 
	GOTO        L_convertTecla18
	MOVLW       0
	XORWF       FARG_convertTecla_tecla+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convertTecla40
	MOVLW       219
	XORWF       FARG_convertTecla_tecla+0, 0 
L__convertTecla40:
	BTFSC       STATUS+0, 2 
	GOTO        L_convertTecla19
	MOVLW       0
	XORWF       FARG_convertTecla_tecla+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convertTecla41
	MOVLW       187
	XORWF       FARG_convertTecla_tecla+0, 0 
L__convertTecla41:
	BTFSC       STATUS+0, 2 
	GOTO        L_convertTecla20
	MOVLW       0
	XORWF       FARG_convertTecla_tecla+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convertTecla42
	MOVLW       123
	XORWF       FARG_convertTecla_tecla+0, 0 
L__convertTecla42:
	BTFSC       STATUS+0, 2 
	GOTO        L_convertTecla21
	MOVLW       0
	XORWF       FARG_convertTecla_tecla+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convertTecla43
	MOVLW       237
	XORWF       FARG_convertTecla_tecla+0, 0 
L__convertTecla43:
	BTFSC       STATUS+0, 2 
	GOTO        L_convertTecla22
	MOVLW       0
	XORWF       FARG_convertTecla_tecla+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convertTecla44
	MOVLW       221
	XORWF       FARG_convertTecla_tecla+0, 0 
L__convertTecla44:
	BTFSC       STATUS+0, 2 
	GOTO        L_convertTecla23
	MOVLW       0
	XORWF       FARG_convertTecla_tecla+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convertTecla45
	MOVLW       189
	XORWF       FARG_convertTecla_tecla+0, 0 
L__convertTecla45:
	BTFSC       STATUS+0, 2 
	GOTO        L_convertTecla24
	MOVLW       0
	XORWF       FARG_convertTecla_tecla+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convertTecla46
	MOVLW       125
	XORWF       FARG_convertTecla_tecla+0, 0 
L__convertTecla46:
	BTFSC       STATUS+0, 2 
	GOTO        L_convertTecla25
	MOVLW       0
	XORWF       FARG_convertTecla_tecla+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convertTecla47
	MOVLW       238
	XORWF       FARG_convertTecla_tecla+0, 0 
L__convertTecla47:
	BTFSC       STATUS+0, 2 
	GOTO        L_convertTecla26
	MOVLW       0
	XORWF       FARG_convertTecla_tecla+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convertTecla48
	MOVLW       222
	XORWF       FARG_convertTecla_tecla+0, 0 
L__convertTecla48:
	BTFSC       STATUS+0, 2 
	GOTO        L_convertTecla27
	MOVLW       0
	XORWF       FARG_convertTecla_tecla+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convertTecla49
	MOVLW       190
	XORWF       FARG_convertTecla_tecla+0, 0 
L__convertTecla49:
	BTFSC       STATUS+0, 2 
	GOTO        L_convertTecla28
	MOVLW       0
	XORWF       FARG_convertTecla_tecla+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convertTecla50
	MOVLW       126
	XORWF       FARG_convertTecla_tecla+0, 0 
L__convertTecla50:
	BTFSC       STATUS+0, 2 
	GOTO        L_convertTecla29
L_convertTecla13:
;calculadoraLCD.c,183 :: 		return result;
	MOVF        convertTecla_result_L0+0, 0 
	MOVWF       R0 
	MOVF        convertTecla_result_L0+1, 0 
	MOVWF       R1 
;calculadoraLCD.c,184 :: 		}
L_end_convertTecla:
	RETURN      0
; end of _convertTecla
