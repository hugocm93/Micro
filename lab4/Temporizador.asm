
_interrupt:

;Temporizador.c,44 :: 		void interrupt(void)
;Temporizador.c,46 :: 		if(INTCON3.INT1IF)
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt0
;Temporizador.c,48 :: 		keypadHandler();
	CALL        _keypadHandler+0, 0
;Temporizador.c,50 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,53 :: 		INTCON3.INT1IE = 0;
	BCF         INTCON3+0, 3 
;Temporizador.c,54 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Temporizador.c,55 :: 		}
	GOTO        L_interrupt1
L_interrupt0:
;Temporizador.c,56 :: 		else if(PIR1.TMR2IF) // Related to bouncing
	BTFSS       PIR1+0, 1 
	GOTO        L_interrupt2
;Temporizador.c,59 :: 		PIR1.TMR2IF=0;
	BCF         PIR1+0, 1 
;Temporizador.c,60 :: 		PIE1.TMR2IE=0;
	BCF         PIE1+0, 1 
;Temporizador.c,61 :: 		T2CON.TMR2ON=0;
	BCF         T2CON+0, 2 
;Temporizador.c,64 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;Temporizador.c,65 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Temporizador.c,68 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;Temporizador.c,69 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,72 :: 		INTCON3.INT2IE = 1;
	BSF         INTCON3+0, 4 
;Temporizador.c,73 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,74 :: 		}
	GOTO        L_interrupt3
L_interrupt2:
;Temporizador.c,75 :: 		else if(INTCON.TMR0IF)
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt4
;Temporizador.c,78 :: 		TMR0H = COUNTER1 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       216
	MOVWF       TMR0H+0 
;Temporizador.c,79 :: 		TMR0L = COUNTER1;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       239
	MOVWF       TMR0L+0 
;Temporizador.c,81 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;Temporizador.c,82 :: 		}
	GOTO        L_interrupt5
L_interrupt4:
;Temporizador.c,83 :: 		else if(INTCON.INT0IF)
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt6
;Temporizador.c,85 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Temporizador.c,86 :: 		Lcd_Out(1, 1, "Prog");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Temporizador+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Temporizador+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,88 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,91 :: 		INTCON.INT0IE = 0;
	BCF         INTCON+0, 4 
;Temporizador.c,92 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,93 :: 		}
	GOTO        L_interrupt7
L_interrupt6:
;Temporizador.c,94 :: 		else if(INTCON3.INT2IF)
	BTFSS       INTCON3+0, 1 
	GOTO        L_interrupt8
;Temporizador.c,96 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Temporizador.c,97 :: 		Lcd_Out(1, 1, "Disp");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Temporizador+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Temporizador+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,99 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,102 :: 		INTCON3.INT2IE = 0;
	BCF         INTCON3+0, 4 
;Temporizador.c,103 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,104 :: 		}
L_interrupt8:
L_interrupt7:
L_interrupt5:
L_interrupt3:
L_interrupt1:
;Temporizador.c,106 :: 		}
L_end_interrupt:
L__interrupt46:
	RETFIE      1
; end of _interrupt

_loadTimer2:

;Temporizador.c,108 :: 		void loadTimer2()
;Temporizador.c,111 :: 		TMR2 = COUNTER2;
	MOVLW       127
	MOVWF       TMR2+0 
;Temporizador.c,113 :: 		PIR1.TMR2IF=0;
	BCF         PIR1+0, 1 
;Temporizador.c,114 :: 		PIE1.TMR2IE=1;
	BSF         PIE1+0, 1 
;Temporizador.c,116 :: 		T2CON.TMR2ON = 1;
	BSF         T2CON+0, 2 
;Temporizador.c,117 :: 		}
L_end_loadTimer2:
	RETURN      0
; end of _loadTimer2

_main:

;Temporizador.c,119 :: 		void main()
;Temporizador.c,122 :: 		ADCON1 = 0x04;
	MOVLW       4
	MOVWF       ADCON1+0 
;Temporizador.c,125 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;Temporizador.c,128 :: 		T0CON.T08BIT = 0;       // 16 bits
	BCF         T0CON+0, 6 
;Temporizador.c,129 :: 		T0CON.T0CS = 0;         // Internal clock => Crystal/4
	BCF         T0CON+0, 5 
;Temporizador.c,130 :: 		T0CON.PSA = 0;          // Prescaler ON
	BCF         T0CON+0, 3 
;Temporizador.c,132 :: 		T0CON.T0PS2 = 1;
	BSF         T0CON+0, 2 
;Temporizador.c,133 :: 		T0CON.T0PS1 = 1;
	BSF         T0CON+0, 1 
;Temporizador.c,134 :: 		T0CON.T0PS0 = 1;
	BSF         T0CON+0, 0 
;Temporizador.c,136 :: 		TMR0H = COUNTER1 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       216
	MOVWF       TMR0H+0 
;Temporizador.c,137 :: 		TMR0L = COUNTER1;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       239
	MOVWF       TMR0L+0 
;Temporizador.c,138 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;Temporizador.c,139 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;Temporizador.c,140 :: 		T0CON.TMR0ON=1;
	BSF         T0CON+0, 7 
;Temporizador.c,144 :: 		T2CON.T2CKPS1 = 1;
	BSF         T2CON+0, 1 
;Temporizador.c,145 :: 		T2CON.T2CKPS0 = 1;
	BSF         T2CON+0, 0 
;Temporizador.c,148 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;Temporizador.c,149 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;Temporizador.c,150 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Temporizador.c,153 :: 		TRISB.RB1 = 1;
	BSF         TRISB+0, 1 
;Temporizador.c,157 :: 		TRISB.RB4 = 0;
	BCF         TRISB+0, 4 
;Temporizador.c,158 :: 		TRISB.RB5 = 0;
	BCF         TRISB+0, 5 
;Temporizador.c,159 :: 		TRISB.RB6 = 0;
	BCF         TRISB+0, 6 
;Temporizador.c,160 :: 		TRISB.RB7 = 0;
	BCF         TRISB+0, 7 
;Temporizador.c,162 :: 		PORTB.RB4 = 0;
	BCF         PORTB+0, 4 
;Temporizador.c,163 :: 		PORTB.RB5 = 0;
	BCF         PORTB+0, 5 
;Temporizador.c,164 :: 		PORTB.RB6 = 0;
	BCF         PORTB+0, 6 
;Temporizador.c,165 :: 		PORTB.RB7 = 0;
	BCF         PORTB+0, 7 
;Temporizador.c,169 :: 		TRISA.RA2 = 1;
	BSF         TRISA+0, 2 
;Temporizador.c,170 :: 		TRISA.RA4 = 1;
	BSF         TRISA+0, 4 
;Temporizador.c,171 :: 		TRISA.RA5 = 1;
	BSF         TRISA+0, 5 
;Temporizador.c,172 :: 		TRISB.RB3 = 1;
	BSF         TRISB+0, 3 
;Temporizador.c,175 :: 		TRISC.RC0 = 0;
	BCF         TRISC+0, 0 
;Temporizador.c,176 :: 		PORTC.RC0 = 0;
	BCF         PORTC+0, 0 
;Temporizador.c,179 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;Temporizador.c,180 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,181 :: 		TRISB.RB0 = 1;
	BSF         TRISB+0, 0 
;Temporizador.c,182 :: 		INTCON3.INT2IE = 1;
	BSF         INTCON3+0, 4 
;Temporizador.c,183 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,184 :: 		TRISB.RB2 = 1;
	BSF         TRISB+0, 2 
;Temporizador.c,185 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_keypadHandler:

;Temporizador.c,188 :: 		void keypadHandler()
;Temporizador.c,194 :: 		char rowCode = 0;
;Temporizador.c,195 :: 		char realCode = 0;
;Temporizador.c,196 :: 		char columnCode = 0;
	CLRF        keypadHandler_columnCode_L0+0 
;Temporizador.c,198 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	CLRF        keypadHandler_i_L0+0 
	MOVLW       15
	MOVWF       keypadHandler_columnCode_L0+0 
L_keypadHandler9:
	MOVF        keypadHandler_columnCode_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler10
;Temporizador.c,201 :: 		PORTB = ~(1 << i) << 4;
	MOVF        keypadHandler_i_L0+0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__keypadHandler50:
	BZ          L__keypadHandler51
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__keypadHandler50
L__keypadHandler51:
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
;Temporizador.c,202 :: 		columnCode = PORTA.RA2 | (PORTA.RA4 << 1) |
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
;Temporizador.c,203 :: 		(PORTA.RA5 << 2) | (PORTB.RB3) << 3;
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
L__keypadHandler52:
	BZ          L__keypadHandler53
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__keypadHandler52
L__keypadHandler53:
	MOVF        R0, 0 
	IORWF       keypadHandler_columnCode_L0+0, 1 
;Temporizador.c,198 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	INCF        keypadHandler_i_L0+0, 1 
;Temporizador.c,205 :: 		}
	GOTO        L_keypadHandler9
L_keypadHandler10:
;Temporizador.c,206 :: 		rowCode = PORTB >> 4;
	MOVLW       4
	MOVWF       R0 
	MOVF        PORTB+0, 0 
	MOVWF       FARG_keyHandler_key+0 
	MOVLW       0
	MOVWF       FARG_keyHandler_key+1 
	MOVF        R0, 0 
L__keypadHandler54:
	BZ          L__keypadHandler55
	RRCF        FARG_keyHandler_key+0, 1 
	BCF         FARG_keyHandler_key+0, 7 
	ADDLW       255
	GOTO        L__keypadHandler54
L__keypadHandler55:
;Temporizador.c,207 :: 		PORTB = 0;
	CLRF        PORTB+0 
;Temporizador.c,209 :: 		realCode = rowCode | (columnCode << 4);
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
;Temporizador.c,210 :: 		result = keyHandler(realCode, &type);
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
;Temporizador.c,212 :: 		if(type == NUM)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler12
;Temporizador.c,214 :: 		if(result == 0)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler56
	MOVLW       0
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler56:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler13
;Temporizador.c,215 :: 		keyPressed[0] = '0';
	MOVLW       48
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler13:
;Temporizador.c,217 :: 		if(result == 1)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler57
	MOVLW       1
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler57:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler14
;Temporizador.c,218 :: 		keyPressed[0] = '1';
	MOVLW       49
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler14:
;Temporizador.c,220 :: 		if(result == 2)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler58
	MOVLW       2
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler58:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler15
;Temporizador.c,221 :: 		keyPressed[0] = '2';
	MOVLW       50
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler15:
;Temporizador.c,223 :: 		if(result == 3)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler59
	MOVLW       3
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler59:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler16
;Temporizador.c,224 :: 		keyPressed[0] = '3';
	MOVLW       51
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler16:
;Temporizador.c,226 :: 		if(result == 4)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler60
	MOVLW       4
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler60:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler17
;Temporizador.c,227 :: 		keyPressed[0] = '4';
	MOVLW       52
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler17:
;Temporizador.c,229 :: 		if(result == 5)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler61
	MOVLW       5
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler61:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler18
;Temporizador.c,230 :: 		keyPressed[0] = '5';
	MOVLW       53
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler18:
;Temporizador.c,232 :: 		if(result == 6)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler62
	MOVLW       6
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler62:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler19
;Temporizador.c,233 :: 		keyPressed[0] = '6';
	MOVLW       54
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler19:
;Temporizador.c,235 :: 		if(result == 7)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler63
	MOVLW       7
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler63:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler20
;Temporizador.c,236 :: 		keyPressed[0] = '7';
	MOVLW       55
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler20:
;Temporizador.c,238 :: 		if(result == 8)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler64
	MOVLW       8
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler64:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler21
;Temporizador.c,239 :: 		keyPressed[0] = '8';
	MOVLW       56
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler21:
;Temporizador.c,241 :: 		if(result == 9)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler65
	MOVLW       9
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler65:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler22
;Temporizador.c,242 :: 		keyPressed[0] = '9';
	MOVLW       57
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler22:
;Temporizador.c,243 :: 		}
L_keypadHandler12:
;Temporizador.c,245 :: 		if(type == SUM)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler23
;Temporizador.c,246 :: 		keyPressed[0] = '+';
	MOVLW       43
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler23:
;Temporizador.c,248 :: 		if(type == SUB)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler24
;Temporizador.c,249 :: 		keyPressed[0] = '-';
	MOVLW       45
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler24:
;Temporizador.c,251 :: 		if(type == MULT)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler25
;Temporizador.c,252 :: 		keyPressed[0] = '*';
	MOVLW       42
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler25:
;Temporizador.c,254 :: 		if(type == DIVI)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler26
;Temporizador.c,255 :: 		keyPressed[0] = '/';
	MOVLW       47
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler26:
;Temporizador.c,257 :: 		keyPressed[1] = '\0';
	CLRF        keypadHandler_keyPressed_L0+1 
;Temporizador.c,259 :: 		time *= 10;
	MOVF        _time+0, 0 
	MOVWF       R0 
	MOVF        _time+1, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _time+0 
	MOVF        R1, 0 
	MOVWF       _time+1 
;Temporizador.c,260 :: 		time += result;
	MOVF        keypadHandler_result_L0+0, 0 
	ADDWF       _time+0, 1 
	MOVF        keypadHandler_result_L0+1, 0 
	ADDWFC      _time+1, 1 
;Temporizador.c,262 :: 		IntToStr(time, str);
	MOVF        _time+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _time+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _str+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Temporizador.c,263 :: 		Lcd_Out(1, 1, str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _str+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,264 :: 		}
L_end_keypadHandler:
	RETURN      0
; end of _keypadHandler

_keyHandler:

;Temporizador.c,267 :: 		int keyHandler (int key, KeyType* type)
;Temporizador.c,269 :: 		int result = -1;
	MOVLW       255
	MOVWF       keyHandler_result_L0+0 
	MOVLW       255
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,270 :: 		switch(key)
	GOTO        L_keyHandler27
;Temporizador.c,272 :: 		case 231:
L_keyHandler29:
;Temporizador.c,273 :: 		*type = ON_CLEAR;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       5
	MOVWF       POSTINC1+0 
;Temporizador.c,274 :: 		break;
	GOTO        L_keyHandler28
;Temporizador.c,276 :: 		case 215:
L_keyHandler30:
;Temporizador.c,277 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,278 :: 		result = 0;
	CLRF        keyHandler_result_L0+0 
	CLRF        keyHandler_result_L0+1 
;Temporizador.c,279 :: 		break;
	GOTO        L_keyHandler28
;Temporizador.c,281 :: 		case 183:
L_keyHandler31:
;Temporizador.c,282 :: 		*type = EQUALS;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	CLRF        POSTINC1+0 
;Temporizador.c,283 :: 		break;
	GOTO        L_keyHandler28
;Temporizador.c,285 :: 		case 119:
L_keyHandler32:
;Temporizador.c,286 :: 		*type = SUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
;Temporizador.c,287 :: 		break;
	GOTO        L_keyHandler28
;Temporizador.c,289 :: 		case 235:
L_keyHandler33:
;Temporizador.c,290 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,291 :: 		result = 1;
	MOVLW       1
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,292 :: 		break;
	GOTO        L_keyHandler28
;Temporizador.c,294 :: 		case 219:
L_keyHandler34:
;Temporizador.c,295 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,296 :: 		result = 2;
	MOVLW       2
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,297 :: 		break;
	GOTO        L_keyHandler28
;Temporizador.c,299 :: 		case 187:
L_keyHandler35:
;Temporizador.c,300 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,301 :: 		result = 3;
	MOVLW       3
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,302 :: 		break;
	GOTO        L_keyHandler28
;Temporizador.c,304 :: 		case 123:
L_keyHandler36:
;Temporizador.c,305 :: 		*type = SUB;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       2
	MOVWF       POSTINC1+0 
;Temporizador.c,306 :: 		break;
	GOTO        L_keyHandler28
;Temporizador.c,308 :: 		case 237:
L_keyHandler37:
;Temporizador.c,309 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,310 :: 		result = 4;
	MOVLW       4
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,311 :: 		break;
	GOTO        L_keyHandler28
;Temporizador.c,313 :: 		case 221:
L_keyHandler38:
;Temporizador.c,314 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,315 :: 		result = 5;
	MOVLW       5
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,316 :: 		break;
	GOTO        L_keyHandler28
;Temporizador.c,318 :: 		case 189:
L_keyHandler39:
;Temporizador.c,319 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,320 :: 		result = 6;
	MOVLW       6
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,321 :: 		break;
	GOTO        L_keyHandler28
;Temporizador.c,323 :: 		case 125:
L_keyHandler40:
;Temporizador.c,324 :: 		*type = MULT;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       3
	MOVWF       POSTINC1+0 
;Temporizador.c,325 :: 		break;
	GOTO        L_keyHandler28
;Temporizador.c,327 :: 		case 238:
L_keyHandler41:
;Temporizador.c,328 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,329 :: 		result = 7;
	MOVLW       7
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,330 :: 		break;
	GOTO        L_keyHandler28
;Temporizador.c,332 :: 		case 222:
L_keyHandler42:
;Temporizador.c,333 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,334 :: 		result = 8;
	MOVLW       8
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,335 :: 		break;
	GOTO        L_keyHandler28
;Temporizador.c,337 :: 		case 190:
L_keyHandler43:
;Temporizador.c,338 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,339 :: 		result = 9;
	MOVLW       9
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,340 :: 		break;
	GOTO        L_keyHandler28
;Temporizador.c,342 :: 		case 126:
L_keyHandler44:
;Temporizador.c,343 :: 		*type = DIVI;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       4
	MOVWF       POSTINC1+0 
;Temporizador.c,344 :: 		break;
	GOTO        L_keyHandler28
;Temporizador.c,345 :: 		}
L_keyHandler27:
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler67
	MOVLW       231
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler67:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler29
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler68
	MOVLW       215
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler68:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler30
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler69
	MOVLW       183
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler69:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler31
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler70
	MOVLW       119
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler70:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler32
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler71
	MOVLW       235
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler71:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler33
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler72
	MOVLW       219
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler72:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler34
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler73
	MOVLW       187
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler73:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler35
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler74
	MOVLW       123
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler74:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler36
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler75
	MOVLW       237
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler75:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler37
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler76
	MOVLW       221
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler76:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler38
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler77
	MOVLW       189
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler77:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler39
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler78
	MOVLW       125
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler78:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler40
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler79
	MOVLW       238
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler79:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler41
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler80
	MOVLW       222
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler80:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler42
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler81
	MOVLW       190
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler81:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler43
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler82
	MOVLW       126
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler82:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler44
L_keyHandler28:
;Temporizador.c,347 :: 		return result;
	MOVF        keyHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keyHandler_result_L0+1, 0 
	MOVWF       R1 
;Temporizador.c,348 :: 		}
L_end_keyHandler:
	RETURN      0
; end of _keyHandler
