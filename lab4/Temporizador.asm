
_interrupt:

;Temporizador.c,49 :: 		void interrupt(void)
;Temporizador.c,51 :: 		if(INTCON3.INT1IF)
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt0
;Temporizador.c,53 :: 		if(progMode)
	MOVF        _progMode+0, 0 
	IORWF       _progMode+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt1
;Temporizador.c,55 :: 		keypadHandler();
	CALL        _keypadHandler+0, 0
;Temporizador.c,56 :: 		}
L_interrupt1:
;Temporizador.c,58 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,61 :: 		INTCON3.INT1IE = 0;
	BCF         INTCON3+0, 3 
;Temporizador.c,62 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Temporizador.c,63 :: 		}
	GOTO        L_interrupt2
L_interrupt0:
;Temporizador.c,64 :: 		else if(PIR1.TMR2IF) // Related to bouncing
	BTFSS       PIR1+0, 1 
	GOTO        L_interrupt3
;Temporizador.c,67 :: 		PIR1.TMR2IF=0;
	BCF         PIR1+0, 1 
;Temporizador.c,68 :: 		PIE1.TMR2IE=0;
	BCF         PIE1+0, 1 
;Temporizador.c,69 :: 		T2CON.TMR2ON=0;
	BCF         T2CON+0, 2 
;Temporizador.c,72 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;Temporizador.c,73 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Temporizador.c,76 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;Temporizador.c,77 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,80 :: 		INTCON3.INT2IE = 1;
	BSF         INTCON3+0, 4 
;Temporizador.c,81 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,82 :: 		}
	GOTO        L_interrupt4
L_interrupt3:
;Temporizador.c,83 :: 		else if(INTCON.TMR0IF) //Display 7seg and timer increment
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt5
;Temporizador.c,86 :: 		TMR0H = COUNTER1 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       252
	MOVWF       TMR0H+0 
;Temporizador.c,87 :: 		TMR0L = COUNTER1;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       241
	MOVWF       TMR0L+0 
;Temporizador.c,89 :: 		PORTC.RC0 = ~PORTC.RC0;
	BTG         PORTC+0, 0 
;Temporizador.c,91 :: 		if(!progMode)
	MOVF        _progMode+0, 0 
	IORWF       _progMode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt6
;Temporizador.c,93 :: 		time -= 0.1;
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       123
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
	MOVF        R0, 0 
	MOVWF       _time+0 
	MOVF        R1, 0 
	MOVWF       _time+1 
	MOVF        R2, 0 
	MOVWF       _time+2 
	MOVF        R3, 0 
	MOVWF       _time+3 
;Temporizador.c,94 :: 		FloatToStr(time, str);
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
;Temporizador.c,95 :: 		Lcd_Out(1, 1, str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _str+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,97 :: 		IntToStr(TMR1L, str);
	MOVF        TMR1L+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _str+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Temporizador.c,98 :: 		Lcd_Out(2, 1, str);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _str+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,99 :: 		}
L_interrupt6:
;Temporizador.c,101 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;Temporizador.c,102 :: 		}
	GOTO        L_interrupt7
L_interrupt5:
;Temporizador.c,103 :: 		else if(PIR1.TMR1IF) //Total timer
	BTFSS       PIR1+0, 0 
	GOTO        L_interrupt8
;Temporizador.c,105 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Temporizador.c,106 :: 		Lcd_Out(1, 1, "Time's up");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Temporizador+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Temporizador+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,108 :: 		progMode = 1;
	MOVLW       1
	MOVWF       _progMode+0 
	MOVLW       0
	MOVWF       _progMode+1 
;Temporizador.c,110 :: 		PIR1.TMR1IF=0;
	BCF         PIR1+0, 0 
;Temporizador.c,111 :: 		PIE1.TMR1IE=0;
	BCF         PIE1+0, 0 
;Temporizador.c,112 :: 		T1CON.TMR1ON=0;
	BCF         T1CON+0, 0 
;Temporizador.c,113 :: 		}
	GOTO        L_interrupt9
L_interrupt8:
;Temporizador.c,114 :: 		else if(INTCON.INT0IF)
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt10
;Temporizador.c,116 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Temporizador.c,117 :: 		Lcd_Out(1, 1, "Prog");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Temporizador+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Temporizador+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,119 :: 		progMode = 1;
	MOVLW       1
	MOVWF       _progMode+0 
	MOVLW       0
	MOVWF       _progMode+1 
;Temporizador.c,121 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,124 :: 		INTCON.INT0IE = 0;
	BCF         INTCON+0, 4 
;Temporizador.c,125 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,126 :: 		}
	GOTO        L_interrupt11
L_interrupt10:
;Temporizador.c,127 :: 		else if(INTCON3.INT2IF)
	BTFSS       INTCON3+0, 1 
	GOTO        L_interrupt12
;Temporizador.c,129 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Temporizador.c,130 :: 		Lcd_Out(1, 1, "Disp");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_Temporizador+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_Temporizador+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,132 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,134 :: 		progMode = 0;
	CLRF        _progMode+0 
	CLRF        _progMode+1 
;Temporizador.c,137 :: 		TMR1H = COUNTER3 >> 8;  // RE-Load Timer 1 counter - 1st TMR1H
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       127
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
	CALL        _double2word+0, 0
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
;Temporizador.c,138 :: 		TMR1L = COUNTER3;       // RE-Load Timer 1 counter - 2nd TMR1L
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       127
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
	CALL        _double2word+0, 0
	MOVF        R0, 0 
	SUBLW       255
	MOVWF       TMR1L+0 
;Temporizador.c,139 :: 		PIR1.TMR1IF=0;
	BCF         PIR1+0, 0 
;Temporizador.c,140 :: 		PIE1.TMR1IE=1;
	BSF         PIE1+0, 0 
;Temporizador.c,141 :: 		T1CON.TMR1ON=1;
	BSF         T1CON+0, 0 
;Temporizador.c,144 :: 		INTCON3.INT2IE = 0;
	BCF         INTCON3+0, 4 
;Temporizador.c,145 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,146 :: 		}
L_interrupt12:
L_interrupt11:
L_interrupt9:
L_interrupt7:
L_interrupt4:
L_interrupt2:
;Temporizador.c,148 :: 		}
L_end_interrupt:
L__interrupt37:
	RETFIE      1
; end of _interrupt

_loadTimer2:

;Temporizador.c,150 :: 		void loadTimer2()
;Temporizador.c,153 :: 		TMR2 = COUNTER2;
	MOVLW       127
	MOVWF       TMR2+0 
;Temporizador.c,155 :: 		PIR1.TMR2IF=0;
	BCF         PIR1+0, 1 
;Temporizador.c,156 :: 		PIE1.TMR2IE=1;
	BSF         PIE1+0, 1 
;Temporizador.c,158 :: 		T2CON.TMR2ON = 1;
	BSF         T2CON+0, 2 
;Temporizador.c,159 :: 		}
L_end_loadTimer2:
	RETURN      0
; end of _loadTimer2

_main:

;Temporizador.c,161 :: 		void main()
;Temporizador.c,164 :: 		ADCON1 = 0x04;
	MOVLW       4
	MOVWF       ADCON1+0 
;Temporizador.c,167 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;Temporizador.c,170 :: 		T0CON.T08BIT = 0;       // 16 bits
	BCF         T0CON+0, 6 
;Temporizador.c,171 :: 		T0CON.T0CS = 0;         // Internal clock => Crystal/4
	BCF         T0CON+0, 5 
;Temporizador.c,172 :: 		T0CON.PSA = 0;          // Prescaler ON
	BCF         T0CON+0, 3 
;Temporizador.c,174 :: 		T0CON.T0PS2 = 1;
	BSF         T0CON+0, 2 
;Temporizador.c,175 :: 		T0CON.T0PS1 = 1;
	BSF         T0CON+0, 1 
;Temporizador.c,176 :: 		T0CON.T0PS0 = 1;
	BSF         T0CON+0, 0 
;Temporizador.c,178 :: 		TMR0H = COUNTER1 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       252
	MOVWF       TMR0H+0 
;Temporizador.c,179 :: 		TMR0L = COUNTER1;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       241
	MOVWF       TMR0L+0 
;Temporizador.c,180 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;Temporizador.c,181 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;Temporizador.c,182 :: 		T0CON.TMR0ON=1;
	BSF         T0CON+0, 7 
;Temporizador.c,185 :: 		TRISC.RC0 = 0;
	BCF         TRISC+0, 0 
;Temporizador.c,186 :: 		PORTC.RC0 = 0;
	BCF         PORTC+0, 0 
;Temporizador.c,187 :: 		T1CON.RD16 = 1;        // Read/Write in two 8 bits oper
	BSF         T1CON+0, 7 
;Temporizador.c,188 :: 		T1CON.T1OSCEN = 0;     // Disable internal Oscilator
	BCF         T1CON+0, 3 
;Temporizador.c,189 :: 		T1CON.TMR1CS = 1;      // External clock from RC0
	BSF         T1CON+0, 1 
;Temporizador.c,190 :: 		T1CON.T1SYNC = 1;      // Do not synchronize ext clock
	BSF         T1CON+0, 2 
;Temporizador.c,192 :: 		T1CON.T1CKPS1 = 1;
	BSF         T1CON+0, 5 
;Temporizador.c,193 :: 		T1CON.T1CKPS0 = 1;
	BSF         T1CON+0, 4 
;Temporizador.c,197 :: 		T2CON.T2CKPS1 = 1;
	BSF         T2CON+0, 1 
;Temporizador.c,198 :: 		T2CON.T2CKPS0 = 1;
	BSF         T2CON+0, 0 
;Temporizador.c,201 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;Temporizador.c,202 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;Temporizador.c,203 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Temporizador.c,206 :: 		TRISB.RB1 = 1;
	BSF         TRISB+0, 1 
;Temporizador.c,210 :: 		TRISB.RB4 = 0;
	BCF         TRISB+0, 4 
;Temporizador.c,211 :: 		TRISB.RB5 = 0;
	BCF         TRISB+0, 5 
;Temporizador.c,212 :: 		TRISB.RB6 = 0;
	BCF         TRISB+0, 6 
;Temporizador.c,213 :: 		TRISB.RB7 = 0;
	BCF         TRISB+0, 7 
;Temporizador.c,215 :: 		PORTB.RB4 = 0;
	BCF         PORTB+0, 4 
;Temporizador.c,216 :: 		PORTB.RB5 = 0;
	BCF         PORTB+0, 5 
;Temporizador.c,217 :: 		PORTB.RB6 = 0;
	BCF         PORTB+0, 6 
;Temporizador.c,218 :: 		PORTB.RB7 = 0;
	BCF         PORTB+0, 7 
;Temporizador.c,222 :: 		TRISA.RA2 = 1;
	BSF         TRISA+0, 2 
;Temporizador.c,223 :: 		TRISA.RA4 = 1;
	BSF         TRISA+0, 4 
;Temporizador.c,224 :: 		TRISA.RA5 = 1;
	BSF         TRISA+0, 5 
;Temporizador.c,225 :: 		TRISB.RB3 = 1;
	BSF         TRISB+0, 3 
;Temporizador.c,228 :: 		TRISC.RC1 = 0;
	BCF         TRISC+0, 1 
;Temporizador.c,229 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;Temporizador.c,232 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;Temporizador.c,233 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,234 :: 		TRISB.RB0 = 1;
	BSF         TRISB+0, 0 
;Temporizador.c,235 :: 		INTCON3.INT2IE = 1;
	BSF         INTCON3+0, 4 
;Temporizador.c,236 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,237 :: 		TRISB.RB2 = 1;
	BSF         TRISB+0, 2 
;Temporizador.c,238 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_keypadHandler:

;Temporizador.c,241 :: 		void keypadHandler()
;Temporizador.c,246 :: 		char rowCode = 0;
;Temporizador.c,247 :: 		char realCode = 0;
;Temporizador.c,248 :: 		char columnCode = 0;
	CLRF        keypadHandler_columnCode_L0+0 
;Temporizador.c,250 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	CLRF        keypadHandler_i_L0+0 
	MOVLW       15
	MOVWF       keypadHandler_columnCode_L0+0 
L_keypadHandler13:
	MOVF        keypadHandler_columnCode_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler14
;Temporizador.c,253 :: 		PORTB = ~(1 << i) << 4;
	MOVF        keypadHandler_i_L0+0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__keypadHandler41:
	BZ          L__keypadHandler42
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__keypadHandler41
L__keypadHandler42:
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
;Temporizador.c,254 :: 		columnCode = PORTA.RA2 | (PORTA.RA4 << 1) |
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
;Temporizador.c,255 :: 		(PORTA.RA5 << 2) | (PORTB.RB3) << 3;
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
L__keypadHandler43:
	BZ          L__keypadHandler44
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__keypadHandler43
L__keypadHandler44:
	MOVF        R0, 0 
	IORWF       keypadHandler_columnCode_L0+0, 1 
;Temporizador.c,250 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	INCF        keypadHandler_i_L0+0, 1 
;Temporizador.c,257 :: 		}
	GOTO        L_keypadHandler13
L_keypadHandler14:
;Temporizador.c,258 :: 		rowCode = PORTB >> 4;
	MOVLW       4
	MOVWF       R0 
	MOVF        PORTB+0, 0 
	MOVWF       FARG_keyHandler_key+0 
	MOVLW       0
	MOVWF       FARG_keyHandler_key+1 
	MOVF        R0, 0 
L__keypadHandler45:
	BZ          L__keypadHandler46
	RRCF        FARG_keyHandler_key+0, 1 
	BCF         FARG_keyHandler_key+0, 7 
	ADDLW       255
	GOTO        L__keypadHandler45
L__keypadHandler46:
;Temporizador.c,259 :: 		PORTB = 0;
	CLRF        PORTB+0 
;Temporizador.c,261 :: 		realCode = rowCode | (columnCode << 4);
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
;Temporizador.c,262 :: 		result = keyHandler(realCode, &type);
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
;Temporizador.c,264 :: 		nPressed += 1;
	INFSNZ      _nPressed+0, 1 
	INCF        _nPressed+1, 1 
;Temporizador.c,266 :: 		if(nPressed < 3)
	MOVLW       128
	XORWF       _nPressed+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler47
	MOVLW       3
	SUBWF       _nPressed+0, 0 
L__keypadHandler47:
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadHandler16
;Temporizador.c,268 :: 		time *= 10;
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
;Temporizador.c,269 :: 		time += result;
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
;Temporizador.c,270 :: 		}
	GOTO        L_keypadHandler17
L_keypadHandler16:
;Temporizador.c,273 :: 		time += result/10.0;
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
;Temporizador.c,274 :: 		}
L_keypadHandler17:
;Temporizador.c,276 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Temporizador.c,277 :: 		FloatToStr(time, str);
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
;Temporizador.c,278 :: 		Lcd_Out(1, 1, str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _str+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,279 :: 		}
L_end_keypadHandler:
	RETURN      0
; end of _keypadHandler

_keyHandler:

;Temporizador.c,282 :: 		int keyHandler (int key, KeyType* type)
;Temporizador.c,284 :: 		int result = -1;
	MOVLW       255
	MOVWF       keyHandler_result_L0+0 
	MOVLW       255
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,285 :: 		switch(key)
	GOTO        L_keyHandler18
;Temporizador.c,287 :: 		case 231:
L_keyHandler20:
;Temporizador.c,288 :: 		*type = ON_CLEAR;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       5
	MOVWF       POSTINC1+0 
;Temporizador.c,289 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,291 :: 		case 215:
L_keyHandler21:
;Temporizador.c,292 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,293 :: 		result = 0;
	CLRF        keyHandler_result_L0+0 
	CLRF        keyHandler_result_L0+1 
;Temporizador.c,294 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,296 :: 		case 183:
L_keyHandler22:
;Temporizador.c,297 :: 		*type = EQUALS;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	CLRF        POSTINC1+0 
;Temporizador.c,298 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,300 :: 		case 119:
L_keyHandler23:
;Temporizador.c,301 :: 		*type = SUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
;Temporizador.c,302 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,304 :: 		case 235:
L_keyHandler24:
;Temporizador.c,305 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,306 :: 		result = 1;
	MOVLW       1
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,307 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,309 :: 		case 219:
L_keyHandler25:
;Temporizador.c,310 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,311 :: 		result = 2;
	MOVLW       2
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,312 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,314 :: 		case 187:
L_keyHandler26:
;Temporizador.c,315 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,316 :: 		result = 3;
	MOVLW       3
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,317 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,319 :: 		case 123:
L_keyHandler27:
;Temporizador.c,320 :: 		*type = SUB;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       2
	MOVWF       POSTINC1+0 
;Temporizador.c,321 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,323 :: 		case 237:
L_keyHandler28:
;Temporizador.c,324 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,325 :: 		result = 4;
	MOVLW       4
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,326 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,328 :: 		case 221:
L_keyHandler29:
;Temporizador.c,329 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,330 :: 		result = 5;
	MOVLW       5
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,331 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,333 :: 		case 189:
L_keyHandler30:
;Temporizador.c,334 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,335 :: 		result = 6;
	MOVLW       6
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,336 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,338 :: 		case 125:
L_keyHandler31:
;Temporizador.c,339 :: 		*type = MULT;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       3
	MOVWF       POSTINC1+0 
;Temporizador.c,340 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,342 :: 		case 238:
L_keyHandler32:
;Temporizador.c,343 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,344 :: 		result = 7;
	MOVLW       7
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,345 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,347 :: 		case 222:
L_keyHandler33:
;Temporizador.c,348 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,349 :: 		result = 8;
	MOVLW       8
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,350 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,352 :: 		case 190:
L_keyHandler34:
;Temporizador.c,353 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,354 :: 		result = 9;
	MOVLW       9
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,355 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,357 :: 		case 126:
L_keyHandler35:
;Temporizador.c,358 :: 		*type = DIVI;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       4
	MOVWF       POSTINC1+0 
;Temporizador.c,359 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,360 :: 		}
L_keyHandler18:
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler49
	MOVLW       231
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler49:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler20
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler50
	MOVLW       215
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler50:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler21
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler51
	MOVLW       183
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler51:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler22
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler52
	MOVLW       119
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler52:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler23
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler53
	MOVLW       235
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler53:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler24
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler54
	MOVLW       219
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler54:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler25
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler55
	MOVLW       187
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler55:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler26
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler56
	MOVLW       123
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler56:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler27
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler57
	MOVLW       237
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler57:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler28
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler58
	MOVLW       221
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler58:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler29
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler59
	MOVLW       189
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler59:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler30
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler60
	MOVLW       125
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler60:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler31
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler61
	MOVLW       238
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler61:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler32
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler62
	MOVLW       222
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler62:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler33
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler63
	MOVLW       190
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler63:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler34
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler64
	MOVLW       126
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler64:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler35
L_keyHandler19:
;Temporizador.c,362 :: 		return result;
	MOVF        keyHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keyHandler_result_L0+1, 0 
	MOVWF       R1 
;Temporizador.c,363 :: 		}
L_end_keyHandler:
	RETURN      0
; end of _keyHandler
