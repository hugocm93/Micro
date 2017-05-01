
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
	MOVLW       216
	MOVWF       TMR0H+0 
;Temporizador.c,87 :: 		TMR0L = COUNTER1;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       239
	MOVWF       TMR0L+0 
;Temporizador.c,89 :: 		PORTC.RC0 = ~PORTC.RC0;
	BTG         PORTC+0, 0 
;Temporizador.c,91 :: 		if(!progMode)
	MOVF        _progMode+0, 0 
	IORWF       _progMode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt6
;Temporizador.c,93 :: 		time -= 1.28;
	MOVLW       10
	MOVWF       R4 
	MOVLW       215
	MOVWF       R5 
	MOVLW       35
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
;Temporizador.c,97 :: 		IntToStr( 0xffff  - TMR1L, str);
	MOVF        TMR1L+0, 0 
	SUBLW       255
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       255
	SUBFWB      FARG_IntToStr_input+1, 1 
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
;Temporizador.c,108 :: 		PIR1.TMR1IF=0;
	BCF         PIR1+0, 0 
;Temporizador.c,109 :: 		PIE1.TMR1IE=0;
	BCF         PIE1+0, 0 
;Temporizador.c,110 :: 		T1CON.TMR1ON=0;
	BCF         T1CON+0, 0 
;Temporizador.c,111 :: 		}
	GOTO        L_interrupt9
L_interrupt8:
;Temporizador.c,112 :: 		else if(INTCON.INT0IF)
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt10
;Temporizador.c,114 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Temporizador.c,115 :: 		Lcd_Out(1, 1, "Prog");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Temporizador+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Temporizador+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,117 :: 		progMode = 1;
	MOVLW       1
	MOVWF       _progMode+0 
	MOVLW       0
	MOVWF       _progMode+1 
;Temporizador.c,119 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,122 :: 		INTCON.INT0IE = 0;
	BCF         INTCON+0, 4 
;Temporizador.c,123 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,124 :: 		}
	GOTO        L_interrupt11
L_interrupt10:
;Temporizador.c,125 :: 		else if(INTCON3.INT2IF)
	BTFSS       INTCON3+0, 1 
	GOTO        L_interrupt12
;Temporizador.c,127 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Temporizador.c,128 :: 		Lcd_Out(1, 1, "Disp");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_Temporizador+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_Temporizador+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,130 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,132 :: 		progMode = 0;
	CLRF        _progMode+0 
	CLRF        _progMode+1 
;Temporizador.c,135 :: 		TMR1H = COUNTER3 >> 8;  // RE-Load Timer 1 counter - 1st TMR1H
	MOVLW       113
	MOVWF       R4 
	MOVLW       61
	MOVWF       R5 
	MOVLW       34
	MOVWF       R6 
	MOVLW       130
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
;Temporizador.c,136 :: 		TMR1L = COUNTER3;       // RE-Load Timer 1 counter - 2nd TMR1L
	MOVLW       113
	MOVWF       R4 
	MOVLW       61
	MOVWF       R5 
	MOVLW       34
	MOVWF       R6 
	MOVLW       130
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
;Temporizador.c,137 :: 		PIR1.TMR1IF=0;
	BCF         PIR1+0, 0 
;Temporizador.c,138 :: 		PIE1.TMR1IE=1;
	BSF         PIE1+0, 0 
;Temporizador.c,139 :: 		T1CON.TMR1ON=1;
	BSF         T1CON+0, 0 
;Temporizador.c,142 :: 		INTCON3.INT2IE = 0;
	BCF         INTCON3+0, 4 
;Temporizador.c,143 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,144 :: 		}
L_interrupt12:
L_interrupt11:
L_interrupt9:
L_interrupt7:
L_interrupt4:
L_interrupt2:
;Temporizador.c,146 :: 		}
L_end_interrupt:
L__interrupt37:
	RETFIE      1
; end of _interrupt

_loadTimer2:

;Temporizador.c,148 :: 		void loadTimer2()
;Temporizador.c,151 :: 		TMR2 = COUNTER2;
	MOVLW       127
	MOVWF       TMR2+0 
;Temporizador.c,153 :: 		PIR1.TMR2IF=0;
	BCF         PIR1+0, 1 
;Temporizador.c,154 :: 		PIE1.TMR2IE=1;
	BSF         PIE1+0, 1 
;Temporizador.c,156 :: 		T2CON.TMR2ON = 1;
	BSF         T2CON+0, 2 
;Temporizador.c,157 :: 		}
L_end_loadTimer2:
	RETURN      0
; end of _loadTimer2

_main:

;Temporizador.c,159 :: 		void main()
;Temporizador.c,162 :: 		ADCON1 = 0x04;
	MOVLW       4
	MOVWF       ADCON1+0 
;Temporizador.c,165 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;Temporizador.c,168 :: 		T0CON.T08BIT = 0;       // 16 bits
	BCF         T0CON+0, 6 
;Temporizador.c,169 :: 		T0CON.T0CS = 0;         // Internal clock => Crystal/4
	BCF         T0CON+0, 5 
;Temporizador.c,170 :: 		T0CON.PSA = 0;          // Prescaler ON
	BCF         T0CON+0, 3 
;Temporizador.c,172 :: 		T0CON.T0PS2 = 1;
	BSF         T0CON+0, 2 
;Temporizador.c,173 :: 		T0CON.T0PS1 = 1;
	BSF         T0CON+0, 1 
;Temporizador.c,174 :: 		T0CON.T0PS0 = 1;
	BSF         T0CON+0, 0 
;Temporizador.c,176 :: 		TMR0H = COUNTER1 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       216
	MOVWF       TMR0H+0 
;Temporizador.c,177 :: 		TMR0L = COUNTER1;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       239
	MOVWF       TMR0L+0 
;Temporizador.c,178 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;Temporizador.c,179 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;Temporizador.c,180 :: 		T0CON.TMR0ON=1;
	BSF         T0CON+0, 7 
;Temporizador.c,183 :: 		TRISC.RC0 = 0;
	BCF         TRISC+0, 0 
;Temporizador.c,184 :: 		PORTC.RC0 = 0;
	BCF         PORTC+0, 0 
;Temporizador.c,185 :: 		T1CON.RD16 = 8;        // Read/Write in two 8 bits oper
	BCF         T1CON+0, 7 
;Temporizador.c,186 :: 		T1CON.T1OSCEN = 0;     // Disable internal Oscilator
	BCF         T1CON+0, 3 
;Temporizador.c,187 :: 		T1CON.TMR1CS = 1;      // External clock from RC0
	BSF         T1CON+0, 1 
;Temporizador.c,188 :: 		T1CON.T1SYNC = 1;      // Do not synchronize ext clock
	BSF         T1CON+0, 2 
;Temporizador.c,190 :: 		T1CON.T1CKPS1 = 1;
	BSF         T1CON+0, 5 
;Temporizador.c,191 :: 		T1CON.T1CKPS0 = 1;
	BSF         T1CON+0, 4 
;Temporizador.c,195 :: 		T2CON.T2CKPS1 = 1;
	BSF         T2CON+0, 1 
;Temporizador.c,196 :: 		T2CON.T2CKPS0 = 1;
	BSF         T2CON+0, 0 
;Temporizador.c,199 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;Temporizador.c,200 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;Temporizador.c,201 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Temporizador.c,204 :: 		TRISB.RB1 = 1;
	BSF         TRISB+0, 1 
;Temporizador.c,208 :: 		TRISB.RB4 = 0;
	BCF         TRISB+0, 4 
;Temporizador.c,209 :: 		TRISB.RB5 = 0;
	BCF         TRISB+0, 5 
;Temporizador.c,210 :: 		TRISB.RB6 = 0;
	BCF         TRISB+0, 6 
;Temporizador.c,211 :: 		TRISB.RB7 = 0;
	BCF         TRISB+0, 7 
;Temporizador.c,213 :: 		PORTB.RB4 = 0;
	BCF         PORTB+0, 4 
;Temporizador.c,214 :: 		PORTB.RB5 = 0;
	BCF         PORTB+0, 5 
;Temporizador.c,215 :: 		PORTB.RB6 = 0;
	BCF         PORTB+0, 6 
;Temporizador.c,216 :: 		PORTB.RB7 = 0;
	BCF         PORTB+0, 7 
;Temporizador.c,220 :: 		TRISA.RA2 = 1;
	BSF         TRISA+0, 2 
;Temporizador.c,221 :: 		TRISA.RA4 = 1;
	BSF         TRISA+0, 4 
;Temporizador.c,222 :: 		TRISA.RA5 = 1;
	BSF         TRISA+0, 5 
;Temporizador.c,223 :: 		TRISB.RB3 = 1;
	BSF         TRISB+0, 3 
;Temporizador.c,226 :: 		TRISC.RC1 = 0;
	BCF         TRISC+0, 1 
;Temporizador.c,227 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;Temporizador.c,230 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;Temporizador.c,231 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,232 :: 		TRISB.RB0 = 1;
	BSF         TRISB+0, 0 
;Temporizador.c,233 :: 		INTCON3.INT2IE = 1;
	BSF         INTCON3+0, 4 
;Temporizador.c,234 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,235 :: 		TRISB.RB2 = 1;
	BSF         TRISB+0, 2 
;Temporizador.c,236 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_keypadHandler:

;Temporizador.c,239 :: 		void keypadHandler()
;Temporizador.c,244 :: 		char rowCode = 0;
;Temporizador.c,245 :: 		char realCode = 0;
;Temporizador.c,246 :: 		char columnCode = 0;
	CLRF        keypadHandler_columnCode_L0+0 
;Temporizador.c,248 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	CLRF        keypadHandler_i_L0+0 
	MOVLW       15
	MOVWF       keypadHandler_columnCode_L0+0 
L_keypadHandler13:
	MOVF        keypadHandler_columnCode_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler14
;Temporizador.c,251 :: 		PORTB = ~(1 << i) << 4;
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
;Temporizador.c,252 :: 		columnCode = PORTA.RA2 | (PORTA.RA4 << 1) |
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
;Temporizador.c,253 :: 		(PORTA.RA5 << 2) | (PORTB.RB3) << 3;
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
;Temporizador.c,248 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	INCF        keypadHandler_i_L0+0, 1 
;Temporizador.c,255 :: 		}
	GOTO        L_keypadHandler13
L_keypadHandler14:
;Temporizador.c,256 :: 		rowCode = PORTB >> 4;
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
;Temporizador.c,257 :: 		PORTB = 0;
	CLRF        PORTB+0 
;Temporizador.c,259 :: 		realCode = rowCode | (columnCode << 4);
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
;Temporizador.c,260 :: 		result = keyHandler(realCode, &type);
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
;Temporizador.c,262 :: 		nPressed += 1;
	INFSNZ      _nPressed+0, 1 
	INCF        _nPressed+1, 1 
;Temporizador.c,264 :: 		if(nPressed < 3)
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
;Temporizador.c,266 :: 		time *= 10;
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
;Temporizador.c,267 :: 		time += result;
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
;Temporizador.c,268 :: 		}
	GOTO        L_keypadHandler17
L_keypadHandler16:
;Temporizador.c,271 :: 		time += result/10.0;
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
;Temporizador.c,272 :: 		}
L_keypadHandler17:
;Temporizador.c,274 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Temporizador.c,275 :: 		FloatToStr(time, str);
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
;Temporizador.c,276 :: 		Lcd_Out(1, 1, str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _str+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,277 :: 		}
L_end_keypadHandler:
	RETURN      0
; end of _keypadHandler

_keyHandler:

;Temporizador.c,280 :: 		int keyHandler (int key, KeyType* type)
;Temporizador.c,282 :: 		int result = -1;
	MOVLW       255
	MOVWF       keyHandler_result_L0+0 
	MOVLW       255
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,283 :: 		switch(key)
	GOTO        L_keyHandler18
;Temporizador.c,285 :: 		case 231:
L_keyHandler20:
;Temporizador.c,286 :: 		*type = ON_CLEAR;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       5
	MOVWF       POSTINC1+0 
;Temporizador.c,287 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,289 :: 		case 215:
L_keyHandler21:
;Temporizador.c,290 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,291 :: 		result = 0;
	CLRF        keyHandler_result_L0+0 
	CLRF        keyHandler_result_L0+1 
;Temporizador.c,292 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,294 :: 		case 183:
L_keyHandler22:
;Temporizador.c,295 :: 		*type = EQUALS;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	CLRF        POSTINC1+0 
;Temporizador.c,296 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,298 :: 		case 119:
L_keyHandler23:
;Temporizador.c,299 :: 		*type = SUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
;Temporizador.c,300 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,302 :: 		case 235:
L_keyHandler24:
;Temporizador.c,303 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,304 :: 		result = 1;
	MOVLW       1
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,305 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,307 :: 		case 219:
L_keyHandler25:
;Temporizador.c,308 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,309 :: 		result = 2;
	MOVLW       2
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,310 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,312 :: 		case 187:
L_keyHandler26:
;Temporizador.c,313 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,314 :: 		result = 3;
	MOVLW       3
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,315 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,317 :: 		case 123:
L_keyHandler27:
;Temporizador.c,318 :: 		*type = SUB;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       2
	MOVWF       POSTINC1+0 
;Temporizador.c,319 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,321 :: 		case 237:
L_keyHandler28:
;Temporizador.c,322 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,323 :: 		result = 4;
	MOVLW       4
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,324 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,326 :: 		case 221:
L_keyHandler29:
;Temporizador.c,327 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,328 :: 		result = 5;
	MOVLW       5
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,329 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,331 :: 		case 189:
L_keyHandler30:
;Temporizador.c,332 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,333 :: 		result = 6;
	MOVLW       6
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,334 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,336 :: 		case 125:
L_keyHandler31:
;Temporizador.c,337 :: 		*type = MULT;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       3
	MOVWF       POSTINC1+0 
;Temporizador.c,338 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,340 :: 		case 238:
L_keyHandler32:
;Temporizador.c,341 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,342 :: 		result = 7;
	MOVLW       7
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,343 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,345 :: 		case 222:
L_keyHandler33:
;Temporizador.c,346 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,347 :: 		result = 8;
	MOVLW       8
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,348 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,350 :: 		case 190:
L_keyHandler34:
;Temporizador.c,351 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,352 :: 		result = 9;
	MOVLW       9
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,353 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,355 :: 		case 126:
L_keyHandler35:
;Temporizador.c,356 :: 		*type = DIVI;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       4
	MOVWF       POSTINC1+0 
;Temporizador.c,357 :: 		break;
	GOTO        L_keyHandler19
;Temporizador.c,358 :: 		}
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
;Temporizador.c,360 :: 		return result;
	MOVF        keyHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keyHandler_result_L0+1, 0 
	MOVWF       R1 
;Temporizador.c,361 :: 		}
L_end_keyHandler:
	RETURN      0
; end of _keyHandler
