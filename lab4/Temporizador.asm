
_interrupt:

;Temporizador.c,48 :: 		void interrupt(void)
;Temporizador.c,50 :: 		if(INTCON3.INT1IF)
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt0
;Temporizador.c,52 :: 		keypadHandler();
	CALL        _keypadHandler+0, 0
;Temporizador.c,54 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,57 :: 		INTCON3.INT1IE = 0;
	BCF         INTCON3+0, 3 
;Temporizador.c,58 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Temporizador.c,59 :: 		}
	GOTO        L_interrupt1
L_interrupt0:
;Temporizador.c,60 :: 		else if(PIR1.TMR2IF) // Related to bouncing
	BTFSS       PIR1+0, 1 
	GOTO        L_interrupt2
;Temporizador.c,63 :: 		PIR1.TMR2IF=0;
	BCF         PIR1+0, 1 
;Temporizador.c,64 :: 		PIE1.TMR2IE=0;
	BCF         PIE1+0, 1 
;Temporizador.c,65 :: 		T2CON.TMR2ON=0;
	BCF         T2CON+0, 2 
;Temporizador.c,68 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;Temporizador.c,69 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Temporizador.c,72 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;Temporizador.c,73 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,76 :: 		INTCON3.INT2IE = 1;
	BSF         INTCON3+0, 4 
;Temporizador.c,77 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,78 :: 		}
	GOTO        L_interrupt3
L_interrupt2:
;Temporizador.c,79 :: 		else if(INTCON.TMR0IF)
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt4
;Temporizador.c,82 :: 		TMR0H = COUNTER1 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       216
	MOVWF       TMR0H+0 
;Temporizador.c,83 :: 		TMR0L = COUNTER1;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       239
	MOVWF       TMR0L+0 
;Temporizador.c,85 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;Temporizador.c,86 :: 		}
	GOTO        L_interrupt5
L_interrupt4:
;Temporizador.c,87 :: 		else if(PIR1.TMR1IF)
	BTFSS       PIR1+0, 0 
	GOTO        L_interrupt6
;Temporizador.c,90 :: 		PIR1.TMR1IF=0;
	BCF         PIR1+0, 0 
;Temporizador.c,91 :: 		}
	GOTO        L_interrupt7
L_interrupt6:
;Temporizador.c,92 :: 		else if(INTCON.INT0IF)
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt8
;Temporizador.c,94 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Temporizador.c,95 :: 		Lcd_Out(1, 1, "Prog");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Temporizador+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Temporizador+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,97 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,100 :: 		INTCON.INT0IE = 0;
	BCF         INTCON+0, 4 
;Temporizador.c,101 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,102 :: 		}
	GOTO        L_interrupt9
L_interrupt8:
;Temporizador.c,103 :: 		else if(INTCON3.INT2IF)
	BTFSS       INTCON3+0, 1 
	GOTO        L_interrupt10
;Temporizador.c,105 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Temporizador.c,106 :: 		Lcd_Out(1, 1, "Disp");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Temporizador+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Temporizador+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,108 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,111 :: 		INTCON3.INT2IE = 0;
	BCF         INTCON3+0, 4 
;Temporizador.c,112 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,113 :: 		}
L_interrupt10:
L_interrupt9:
L_interrupt7:
L_interrupt5:
L_interrupt3:
L_interrupt1:
;Temporizador.c,115 :: 		}
L_end_interrupt:
L__interrupt50:
	RETFIE      1
; end of _interrupt

_loadTimer2:

;Temporizador.c,117 :: 		void loadTimer2()
;Temporizador.c,120 :: 		TMR2 = COUNTER2;
	MOVLW       127
	MOVWF       TMR2+0 
;Temporizador.c,122 :: 		PIR1.TMR2IF=0;
	BCF         PIR1+0, 1 
;Temporizador.c,123 :: 		PIE1.TMR2IE=1;
	BSF         PIE1+0, 1 
;Temporizador.c,125 :: 		T2CON.TMR2ON = 1;
	BSF         T2CON+0, 2 
;Temporizador.c,126 :: 		}
L_end_loadTimer2:
	RETURN      0
; end of _loadTimer2

_main:

;Temporizador.c,128 :: 		void main()
;Temporizador.c,131 :: 		ADCON1 = 0x04;
	MOVLW       4
	MOVWF       ADCON1+0 
;Temporizador.c,134 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;Temporizador.c,137 :: 		T0CON.T08BIT = 0;       // 16 bits
	BCF         T0CON+0, 6 
;Temporizador.c,138 :: 		T0CON.T0CS = 0;         // Internal clock => Crystal/4
	BCF         T0CON+0, 5 
;Temporizador.c,139 :: 		T0CON.PSA = 0;          // Prescaler ON
	BCF         T0CON+0, 3 
;Temporizador.c,141 :: 		T0CON.T0PS2 = 1;
	BSF         T0CON+0, 2 
;Temporizador.c,142 :: 		T0CON.T0PS1 = 1;
	BSF         T0CON+0, 1 
;Temporizador.c,143 :: 		T0CON.T0PS0 = 1;
	BSF         T0CON+0, 0 
;Temporizador.c,145 :: 		TMR0H = COUNTER1 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       216
	MOVWF       TMR0H+0 
;Temporizador.c,146 :: 		TMR0L = COUNTER1;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       239
	MOVWF       TMR0L+0 
;Temporizador.c,147 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;Temporizador.c,148 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;Temporizador.c,149 :: 		T0CON.TMR0ON=1;
	BSF         T0CON+0, 7 
;Temporizador.c,152 :: 		T1CON.RD16 = 8;        // Read/Write in two 8 bits oper
	BCF         T1CON+0, 7 
;Temporizador.c,153 :: 		T1CON.T1OSCEN = 0;     // Disable internal Oscilator
	BCF         T1CON+0, 3 
;Temporizador.c,154 :: 		T1CON.TMR1CS = 1;      // External clock from RC0
	BSF         T1CON+0, 1 
;Temporizador.c,155 :: 		T1CON.T1SYNC = 1;      // Do not synchronize ext clock
	BSF         T1CON+0, 2 
;Temporizador.c,157 :: 		T1CON.T1CKPS1 = 1;
	BSF         T1CON+0, 5 
;Temporizador.c,158 :: 		T1CON.T1CKPS0 = 1;
	BSF         T1CON+0, 4 
;Temporizador.c,160 :: 		TMR1H = COUNTER3 >> 8;  // RE-Load Timer 1 counter - 1st TMR1H
	MOVLW       243
	MOVWF       TMR1H+0 
;Temporizador.c,161 :: 		TMR1L = COUNTER3;       // RE-Load Timer 1 counter - 2nd TMR1L
	MOVLW       127
	MOVWF       TMR1L+0 
;Temporizador.c,162 :: 		PIR1.TMR1IF=0;
	BCF         PIR1+0, 0 
;Temporizador.c,163 :: 		PIE1.TMR1IE=1;
	BSF         PIE1+0, 0 
;Temporizador.c,164 :: 		T1CON.TMR1ON=1;
	BSF         T1CON+0, 0 
;Temporizador.c,168 :: 		T2CON.T2CKPS1 = 1;
	BSF         T2CON+0, 1 
;Temporizador.c,169 :: 		T2CON.T2CKPS0 = 1;
	BSF         T2CON+0, 0 
;Temporizador.c,172 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;Temporizador.c,173 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;Temporizador.c,174 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Temporizador.c,177 :: 		TRISB.RB1 = 1;
	BSF         TRISB+0, 1 
;Temporizador.c,181 :: 		TRISB.RB4 = 0;
	BCF         TRISB+0, 4 
;Temporizador.c,182 :: 		TRISB.RB5 = 0;
	BCF         TRISB+0, 5 
;Temporizador.c,183 :: 		TRISB.RB6 = 0;
	BCF         TRISB+0, 6 
;Temporizador.c,184 :: 		TRISB.RB7 = 0;
	BCF         TRISB+0, 7 
;Temporizador.c,186 :: 		PORTB.RB4 = 0;
	BCF         PORTB+0, 4 
;Temporizador.c,187 :: 		PORTB.RB5 = 0;
	BCF         PORTB+0, 5 
;Temporizador.c,188 :: 		PORTB.RB6 = 0;
	BCF         PORTB+0, 6 
;Temporizador.c,189 :: 		PORTB.RB7 = 0;
	BCF         PORTB+0, 7 
;Temporizador.c,193 :: 		TRISA.RA2 = 1;
	BSF         TRISA+0, 2 
;Temporizador.c,194 :: 		TRISA.RA4 = 1;
	BSF         TRISA+0, 4 
;Temporizador.c,195 :: 		TRISA.RA5 = 1;
	BSF         TRISA+0, 5 
;Temporizador.c,196 :: 		TRISB.RB3 = 1;
	BSF         TRISB+0, 3 
;Temporizador.c,199 :: 		TRISC.RC1 = 0;
	BCF         TRISC+0, 1 
;Temporizador.c,200 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;Temporizador.c,203 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;Temporizador.c,204 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,205 :: 		TRISB.RB0 = 1;
	BSF         TRISB+0, 0 
;Temporizador.c,206 :: 		INTCON3.INT2IE = 1;
	BSF         INTCON3+0, 4 
;Temporizador.c,207 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,208 :: 		TRISB.RB2 = 1;
	BSF         TRISB+0, 2 
;Temporizador.c,209 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_keypadHandler:

;Temporizador.c,212 :: 		void keypadHandler()
;Temporizador.c,218 :: 		char rowCode = 0;
;Temporizador.c,219 :: 		char realCode = 0;
;Temporizador.c,220 :: 		char columnCode = 0;
	CLRF        keypadHandler_columnCode_L0+0 
;Temporizador.c,222 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	CLRF        keypadHandler_i_L0+0 
	MOVLW       15
	MOVWF       keypadHandler_columnCode_L0+0 
L_keypadHandler11:
	MOVF        keypadHandler_columnCode_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler12
;Temporizador.c,225 :: 		PORTB = ~(1 << i) << 4;
	MOVF        keypadHandler_i_L0+0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__keypadHandler54:
	BZ          L__keypadHandler55
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__keypadHandler54
L__keypadHandler55:
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
;Temporizador.c,226 :: 		columnCode = PORTA.RA2 | (PORTA.RA4 << 1) |
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
;Temporizador.c,227 :: 		(PORTA.RA5 << 2) | (PORTB.RB3) << 3;
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
L__keypadHandler56:
	BZ          L__keypadHandler57
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__keypadHandler56
L__keypadHandler57:
	MOVF        R0, 0 
	IORWF       keypadHandler_columnCode_L0+0, 1 
;Temporizador.c,222 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	INCF        keypadHandler_i_L0+0, 1 
;Temporizador.c,229 :: 		}
	GOTO        L_keypadHandler11
L_keypadHandler12:
;Temporizador.c,230 :: 		rowCode = PORTB >> 4;
	MOVLW       4
	MOVWF       R0 
	MOVF        PORTB+0, 0 
	MOVWF       FARG_keyHandler_key+0 
	MOVLW       0
	MOVWF       FARG_keyHandler_key+1 
	MOVF        R0, 0 
L__keypadHandler58:
	BZ          L__keypadHandler59
	RRCF        FARG_keyHandler_key+0, 1 
	BCF         FARG_keyHandler_key+0, 7 
	ADDLW       255
	GOTO        L__keypadHandler58
L__keypadHandler59:
;Temporizador.c,231 :: 		PORTB = 0;
	CLRF        PORTB+0 
;Temporizador.c,233 :: 		realCode = rowCode | (columnCode << 4);
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
;Temporizador.c,234 :: 		result = keyHandler(realCode, &type);
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
;Temporizador.c,236 :: 		if(type == NUM)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler14
;Temporizador.c,238 :: 		if(result == 0)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler60
	MOVLW       0
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler60:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler15
;Temporizador.c,239 :: 		keyPressed[0] = '0';
	MOVLW       48
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler15:
;Temporizador.c,241 :: 		if(result == 1)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler61
	MOVLW       1
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler61:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler16
;Temporizador.c,242 :: 		keyPressed[0] = '1';
	MOVLW       49
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler16:
;Temporizador.c,244 :: 		if(result == 2)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler62
	MOVLW       2
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler62:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler17
;Temporizador.c,245 :: 		keyPressed[0] = '2';
	MOVLW       50
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler17:
;Temporizador.c,247 :: 		if(result == 3)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler63
	MOVLW       3
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler63:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler18
;Temporizador.c,248 :: 		keyPressed[0] = '3';
	MOVLW       51
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler18:
;Temporizador.c,250 :: 		if(result == 4)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler64
	MOVLW       4
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler64:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler19
;Temporizador.c,251 :: 		keyPressed[0] = '4';
	MOVLW       52
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler19:
;Temporizador.c,253 :: 		if(result == 5)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler65
	MOVLW       5
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler65:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler20
;Temporizador.c,254 :: 		keyPressed[0] = '5';
	MOVLW       53
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler20:
;Temporizador.c,256 :: 		if(result == 6)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler66
	MOVLW       6
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler66:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler21
;Temporizador.c,257 :: 		keyPressed[0] = '6';
	MOVLW       54
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler21:
;Temporizador.c,259 :: 		if(result == 7)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler67
	MOVLW       7
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler67:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler22
;Temporizador.c,260 :: 		keyPressed[0] = '7';
	MOVLW       55
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler22:
;Temporizador.c,262 :: 		if(result == 8)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler68
	MOVLW       8
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler68:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler23
;Temporizador.c,263 :: 		keyPressed[0] = '8';
	MOVLW       56
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler23:
;Temporizador.c,265 :: 		if(result == 9)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler69
	MOVLW       9
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler69:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler24
;Temporizador.c,266 :: 		keyPressed[0] = '9';
	MOVLW       57
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler24:
;Temporizador.c,267 :: 		}
L_keypadHandler14:
;Temporizador.c,269 :: 		if(type == SUM)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler25
;Temporizador.c,270 :: 		keyPressed[0] = '+';
	MOVLW       43
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler25:
;Temporizador.c,272 :: 		if(type == SUB)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler26
;Temporizador.c,273 :: 		keyPressed[0] = '-';
	MOVLW       45
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler26:
;Temporizador.c,275 :: 		if(type == MULT)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler27
;Temporizador.c,276 :: 		keyPressed[0] = '*';
	MOVLW       42
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler27:
;Temporizador.c,278 :: 		if(type == DIVI)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler28
;Temporizador.c,279 :: 		keyPressed[0] = '/';
	MOVLW       47
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler28:
;Temporizador.c,281 :: 		keyPressed[1] = '\0';
	CLRF        keypadHandler_keyPressed_L0+1 
;Temporizador.c,283 :: 		nPressed += 1;
	INFSNZ      _nPressed+0, 1 
	INCF        _nPressed+1, 1 
;Temporizador.c,285 :: 		if(nPressed < 3)
	MOVLW       128
	XORWF       _nPressed+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler70
	MOVLW       3
	SUBWF       _nPressed+0, 0 
L__keypadHandler70:
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadHandler29
;Temporizador.c,287 :: 		time *= 10;
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
;Temporizador.c,288 :: 		time += result;
	MOVF        keypadHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keypadHandler_result_L0+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
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
;Temporizador.c,289 :: 		}
	GOTO        L_keypadHandler30
L_keypadHandler29:
;Temporizador.c,292 :: 		time += result/10.0;
	MOVF        keypadHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keypadHandler_result_L0+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
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
;Temporizador.c,293 :: 		}
L_keypadHandler30:
;Temporizador.c,295 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Temporizador.c,296 :: 		FloatToStr(time, str);
	MOVF        _time+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _time+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _time+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _time+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _str+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Temporizador.c,297 :: 		Lcd_Out(1, 1, str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _str+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,298 :: 		}
L_end_keypadHandler:
	RETURN      0
; end of _keypadHandler

_keyHandler:

;Temporizador.c,301 :: 		int keyHandler (int key, KeyType* type)
;Temporizador.c,303 :: 		int result = -1;
	MOVLW       255
	MOVWF       keyHandler_result_L0+0 
	MOVLW       255
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,304 :: 		switch(key)
	GOTO        L_keyHandler31
;Temporizador.c,306 :: 		case 231:
L_keyHandler33:
;Temporizador.c,307 :: 		*type = ON_CLEAR;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       5
	MOVWF       POSTINC1+0 
;Temporizador.c,308 :: 		break;
	GOTO        L_keyHandler32
;Temporizador.c,310 :: 		case 215:
L_keyHandler34:
;Temporizador.c,311 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,312 :: 		result = 0;
	CLRF        keyHandler_result_L0+0 
	CLRF        keyHandler_result_L0+1 
;Temporizador.c,313 :: 		break;
	GOTO        L_keyHandler32
;Temporizador.c,315 :: 		case 183:
L_keyHandler35:
;Temporizador.c,316 :: 		*type = EQUALS;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	CLRF        POSTINC1+0 
;Temporizador.c,317 :: 		break;
	GOTO        L_keyHandler32
;Temporizador.c,319 :: 		case 119:
L_keyHandler36:
;Temporizador.c,320 :: 		*type = SUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
;Temporizador.c,321 :: 		break;
	GOTO        L_keyHandler32
;Temporizador.c,323 :: 		case 235:
L_keyHandler37:
;Temporizador.c,324 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,325 :: 		result = 1;
	MOVLW       1
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,326 :: 		break;
	GOTO        L_keyHandler32
;Temporizador.c,328 :: 		case 219:
L_keyHandler38:
;Temporizador.c,329 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,330 :: 		result = 2;
	MOVLW       2
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,331 :: 		break;
	GOTO        L_keyHandler32
;Temporizador.c,333 :: 		case 187:
L_keyHandler39:
;Temporizador.c,334 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,335 :: 		result = 3;
	MOVLW       3
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,336 :: 		break;
	GOTO        L_keyHandler32
;Temporizador.c,338 :: 		case 123:
L_keyHandler40:
;Temporizador.c,339 :: 		*type = SUB;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       2
	MOVWF       POSTINC1+0 
;Temporizador.c,340 :: 		break;
	GOTO        L_keyHandler32
;Temporizador.c,342 :: 		case 237:
L_keyHandler41:
;Temporizador.c,343 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,344 :: 		result = 4;
	MOVLW       4
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,345 :: 		break;
	GOTO        L_keyHandler32
;Temporizador.c,347 :: 		case 221:
L_keyHandler42:
;Temporizador.c,348 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,349 :: 		result = 5;
	MOVLW       5
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,350 :: 		break;
	GOTO        L_keyHandler32
;Temporizador.c,352 :: 		case 189:
L_keyHandler43:
;Temporizador.c,353 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,354 :: 		result = 6;
	MOVLW       6
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,355 :: 		break;
	GOTO        L_keyHandler32
;Temporizador.c,357 :: 		case 125:
L_keyHandler44:
;Temporizador.c,358 :: 		*type = MULT;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       3
	MOVWF       POSTINC1+0 
;Temporizador.c,359 :: 		break;
	GOTO        L_keyHandler32
;Temporizador.c,361 :: 		case 238:
L_keyHandler45:
;Temporizador.c,362 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,363 :: 		result = 7;
	MOVLW       7
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,364 :: 		break;
	GOTO        L_keyHandler32
;Temporizador.c,366 :: 		case 222:
L_keyHandler46:
;Temporizador.c,367 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,368 :: 		result = 8;
	MOVLW       8
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,369 :: 		break;
	GOTO        L_keyHandler32
;Temporizador.c,371 :: 		case 190:
L_keyHandler47:
;Temporizador.c,372 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,373 :: 		result = 9;
	MOVLW       9
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,374 :: 		break;
	GOTO        L_keyHandler32
;Temporizador.c,376 :: 		case 126:
L_keyHandler48:
;Temporizador.c,377 :: 		*type = DIVI;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       4
	MOVWF       POSTINC1+0 
;Temporizador.c,378 :: 		break;
	GOTO        L_keyHandler32
;Temporizador.c,379 :: 		}
L_keyHandler31:
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler72
	MOVLW       231
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler72:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler33
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler73
	MOVLW       215
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler73:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler34
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler74
	MOVLW       183
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler74:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler35
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler75
	MOVLW       119
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler75:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler36
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler76
	MOVLW       235
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler76:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler37
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler77
	MOVLW       219
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler77:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler38
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler78
	MOVLW       187
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler78:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler39
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler79
	MOVLW       123
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler79:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler40
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler80
	MOVLW       237
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler80:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler41
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler81
	MOVLW       221
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler81:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler42
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler82
	MOVLW       189
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler82:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler43
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler83
	MOVLW       125
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler83:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler44
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler84
	MOVLW       238
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler84:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler45
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler85
	MOVLW       222
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler85:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler46
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler86
	MOVLW       190
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler86:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler47
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler87
	MOVLW       126
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler87:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler48
L_keyHandler32:
;Temporizador.c,381 :: 		return result;
	MOVF        keyHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keyHandler_result_L0+1, 0 
	MOVWF       R1 
;Temporizador.c,382 :: 		}
L_end_keyHandler:
	RETURN      0
; end of _keyHandler
