
_interrupt:

;Temporizador.c,50 :: 		void interrupt(void)
;Temporizador.c,52 :: 		if(INTCON3.INT1IF)
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt0
;Temporizador.c,54 :: 		if(progMode)
	MOVF        _progMode+0, 0 
	IORWF       _progMode+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt1
;Temporizador.c,56 :: 		keypadHandler();
	CALL        _keypadHandler+0, 0
;Temporizador.c,57 :: 		}
L_interrupt1:
;Temporizador.c,59 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,62 :: 		INTCON3.INT1IE = 0;
	BCF         INTCON3+0, 3 
;Temporizador.c,63 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Temporizador.c,64 :: 		}
L_interrupt0:
;Temporizador.c,65 :: 		if(PIR1.TMR2IF) // Related to bouncing
	BTFSS       PIR1+0, 1 
	GOTO        L_interrupt2
;Temporizador.c,68 :: 		PIR1.TMR2IF=0;
	BCF         PIR1+0, 1 
;Temporizador.c,69 :: 		PIE1.TMR2IE=0;
	BCF         PIE1+0, 1 
;Temporizador.c,70 :: 		T2CON.TMR2ON=0;
	BCF         T2CON+0, 2 
;Temporizador.c,73 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;Temporizador.c,74 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Temporizador.c,77 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;Temporizador.c,78 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,81 :: 		INTCON3.INT2IE = 1;
	BSF         INTCON3+0, 4 
;Temporizador.c,82 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,83 :: 		}
L_interrupt2:
;Temporizador.c,84 :: 		if(INTCON.TMR0IF) //Display 7seg and timer increment
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt3
;Temporizador.c,87 :: 		TMR0H = COUNTER0 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       252
	MOVWF       TMR0H+0 
;Temporizador.c,88 :: 		TMR0L = COUNTER0;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       23
	MOVWF       TMR0L+0 
;Temporizador.c,90 :: 		PORTC.RC0 = ~PORTC.RC0;
	BTG         PORTC+0, 0 
;Temporizador.c,102 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;Temporizador.c,103 :: 		}
L_interrupt3:
;Temporizador.c,104 :: 		if(PIR1.TMR1IF) //Total timer
	BTFSS       PIR1+0, 0 
	GOTO        L_interrupt4
;Temporizador.c,106 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Temporizador.c,107 :: 		Lcd_Out(1, 1, "Time's up");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Temporizador+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Temporizador+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,109 :: 		progMode = 1;
	MOVLW       1
	MOVWF       _progMode+0 
	MOVLW       0
	MOVWF       _progMode+1 
;Temporizador.c,111 :: 		PIR1.TMR1IF=0;
	BCF         PIR1+0, 0 
;Temporizador.c,112 :: 		PIE1.TMR1IE=0;
	BCF         PIE1+0, 0 
;Temporizador.c,113 :: 		T1CON.TMR1ON=0;
	BCF         T1CON+0, 0 
;Temporizador.c,114 :: 		}
L_interrupt4:
;Temporizador.c,115 :: 		if(INTCON.INT0IF)
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt5
;Temporizador.c,117 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Temporizador.c,118 :: 		Lcd_Out(1, 1, "Prog");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Temporizador+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Temporizador+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,120 :: 		progMode = 1;
	MOVLW       1
	MOVWF       _progMode+0 
	MOVLW       0
	MOVWF       _progMode+1 
;Temporizador.c,122 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,125 :: 		INTCON.INT0IE = 0;
	BCF         INTCON+0, 4 
;Temporizador.c,126 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,127 :: 		}
L_interrupt5:
;Temporizador.c,128 :: 		if(INTCON3.INT2IF)
	BTFSS       INTCON3+0, 1 
	GOTO        L_interrupt6
;Temporizador.c,130 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Temporizador.c,131 :: 		Lcd_Out(1, 1, "Disp");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_Temporizador+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_Temporizador+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,133 :: 		loadTimer2();
	CALL        _loadTimer2+0, 0
;Temporizador.c,135 :: 		progMode = 0;
	CLRF        _progMode+0 
	CLRF        _progMode+1 
;Temporizador.c,138 :: 		TMR1H = COUNTER1 >> 8;  // RE-Load Timer 1 counter - 1st TMR1H
	MOVLW       111
	MOVWF       R4 
	MOVLW       18
	MOVWF       R5 
	MOVLW       3
	MOVWF       R6 
	MOVLW       121
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
;Temporizador.c,139 :: 		TMR1L = COUNTER1;       // RE-Load Timer 1 counter - 2nd TMR1L
	MOVLW       111
	MOVWF       R4 
	MOVLW       18
	MOVWF       R5 
	MOVLW       3
	MOVWF       R6 
	MOVLW       121
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
;Temporizador.c,140 :: 		PIR1.TMR1IF=0;
	BCF         PIR1+0, 0 
;Temporizador.c,141 :: 		PIE1.TMR1IE=1;
	BSF         PIE1+0, 0 
;Temporizador.c,142 :: 		T1CON.TMR1ON=1;
	BSF         T1CON+0, 0 
;Temporizador.c,145 :: 		INTCON3.INT2IE = 0;
	BCF         INTCON3+0, 4 
;Temporizador.c,146 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,147 :: 		}
L_interrupt6:
;Temporizador.c,149 :: 		}
L_end_interrupt:
L__interrupt31:
	RETFIE      1
; end of _interrupt

_loadTimer2:

;Temporizador.c,151 :: 		void loadTimer2()
;Temporizador.c,154 :: 		TMR2 = COUNTER2;
	MOVLW       127
	MOVWF       TMR2+0 
;Temporizador.c,156 :: 		PIR1.TMR2IF=0;
	BCF         PIR1+0, 1 
;Temporizador.c,157 :: 		PIE1.TMR2IE=1;
	BSF         PIE1+0, 1 
;Temporizador.c,159 :: 		T2CON.TMR2ON = 1;
	BSF         T2CON+0, 2 
;Temporizador.c,160 :: 		}
L_end_loadTimer2:
	RETURN      0
; end of _loadTimer2

_main:

;Temporizador.c,162 :: 		void main()
;Temporizador.c,165 :: 		ADCON1 = 0x04;
	MOVLW       4
	MOVWF       ADCON1+0 
;Temporizador.c,168 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;Temporizador.c,171 :: 		T0CON.T08BIT = 0;       // 16 bits
	BCF         T0CON+0, 6 
;Temporizador.c,172 :: 		T0CON.T0CS = 0;         // Internal clock => Crystal/4
	BCF         T0CON+0, 5 
;Temporizador.c,173 :: 		T0CON.PSA = 0;          // Prescaler ON
	BCF         T0CON+0, 3 
;Temporizador.c,175 :: 		T0CON.T0PS2 = 0;
	BCF         T0CON+0, 2 
;Temporizador.c,176 :: 		T0CON.T0PS1 = 0;
	BCF         T0CON+0, 1 
;Temporizador.c,177 :: 		T0CON.T0PS0 = 0;
	BCF         T0CON+0, 0 
;Temporizador.c,179 :: 		TMR0H = COUNTER0 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       252
	MOVWF       TMR0H+0 
;Temporizador.c,180 :: 		TMR0L = COUNTER0;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       23
	MOVWF       TMR0L+0 
;Temporizador.c,181 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;Temporizador.c,182 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;Temporizador.c,183 :: 		T0CON.TMR0ON=1;
	BSF         T0CON+0, 7 
;Temporizador.c,186 :: 		TRISC.RC0 = 0;
	BCF         TRISC+0, 0 
;Temporizador.c,187 :: 		PORTC.RC0 = 0;
	BCF         PORTC+0, 0 
;Temporizador.c,188 :: 		T1CON.RD16 = 1;        // Read/Write in two 8 bits oper
	BSF         T1CON+0, 7 
;Temporizador.c,189 :: 		T1CON.T1OSCEN = 0;     // Disable internal Oscilator
	BCF         T1CON+0, 3 
;Temporizador.c,190 :: 		T1CON.TMR1CS = 1;      // External clock from RC0
	BSF         T1CON+0, 1 
;Temporizador.c,191 :: 		T1CON.T1SYNC = 1;      // Do not synchronize ext clock
	BSF         T1CON+0, 2 
;Temporizador.c,193 :: 		T1CON.T1CKPS1 = 1;
	BSF         T1CON+0, 5 
;Temporizador.c,194 :: 		T1CON.T1CKPS0 = 1;
	BSF         T1CON+0, 4 
;Temporizador.c,198 :: 		T2CON.T2CKPS1 = 1;
	BSF         T2CON+0, 1 
;Temporizador.c,199 :: 		T2CON.T2CKPS0 = 1;
	BSF         T2CON+0, 0 
;Temporizador.c,202 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;Temporizador.c,203 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;Temporizador.c,204 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Temporizador.c,207 :: 		TRISB.RB1 = 1;
	BSF         TRISB+0, 1 
;Temporizador.c,211 :: 		TRISB.RB4 = 0;
	BCF         TRISB+0, 4 
;Temporizador.c,212 :: 		TRISB.RB5 = 0;
	BCF         TRISB+0, 5 
;Temporizador.c,213 :: 		TRISB.RB6 = 0;
	BCF         TRISB+0, 6 
;Temporizador.c,214 :: 		TRISB.RB7 = 0;
	BCF         TRISB+0, 7 
;Temporizador.c,216 :: 		PORTB.RB4 = 0;
	BCF         PORTB+0, 4 
;Temporizador.c,217 :: 		PORTB.RB5 = 0;
	BCF         PORTB+0, 5 
;Temporizador.c,218 :: 		PORTB.RB6 = 0;
	BCF         PORTB+0, 6 
;Temporizador.c,219 :: 		PORTB.RB7 = 0;
	BCF         PORTB+0, 7 
;Temporizador.c,223 :: 		TRISA.RA2 = 1;
	BSF         TRISA+0, 2 
;Temporizador.c,224 :: 		TRISA.RA4 = 1;
	BSF         TRISA+0, 4 
;Temporizador.c,225 :: 		TRISA.RA5 = 1;
	BSF         TRISA+0, 5 
;Temporizador.c,226 :: 		TRISB.RB3 = 1;
	BSF         TRISB+0, 3 
;Temporizador.c,229 :: 		TRISC.RC1 = 0;
	BCF         TRISC+0, 1 
;Temporizador.c,230 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;Temporizador.c,233 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;Temporizador.c,234 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Temporizador.c,235 :: 		TRISB.RB0 = 1;
	BSF         TRISB+0, 0 
;Temporizador.c,236 :: 		INTCON3.INT2IE = 1;
	BSF         INTCON3+0, 4 
;Temporizador.c,237 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Temporizador.c,238 :: 		TRISB.RB2 = 1;
	BSF         TRISB+0, 2 
;Temporizador.c,239 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_keypadHandler:

;Temporizador.c,242 :: 		void keypadHandler()
;Temporizador.c,247 :: 		char rowCode = 0;
;Temporizador.c,248 :: 		char realCode = 0;
;Temporizador.c,249 :: 		char columnCode = 0;
	CLRF        keypadHandler_columnCode_L0+0 
;Temporizador.c,251 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	CLRF        keypadHandler_i_L0+0 
	MOVLW       15
	MOVWF       keypadHandler_columnCode_L0+0 
L_keypadHandler7:
	MOVF        keypadHandler_columnCode_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler8
;Temporizador.c,254 :: 		PORTB = ~(1 << i) << 4;
	MOVF        keypadHandler_i_L0+0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__keypadHandler35:
	BZ          L__keypadHandler36
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__keypadHandler35
L__keypadHandler36:
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
;Temporizador.c,255 :: 		columnCode = PORTA.RA2 | (PORTA.RA4 << 1) |
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
;Temporizador.c,256 :: 		(PORTA.RA5 << 2) | (PORTB.RB3) << 3;
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
L__keypadHandler37:
	BZ          L__keypadHandler38
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__keypadHandler37
L__keypadHandler38:
	MOVF        R0, 0 
	IORWF       keypadHandler_columnCode_L0+0, 1 
;Temporizador.c,251 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	INCF        keypadHandler_i_L0+0, 1 
;Temporizador.c,258 :: 		}
	GOTO        L_keypadHandler7
L_keypadHandler8:
;Temporizador.c,259 :: 		rowCode = PORTB >> 4;
	MOVLW       4
	MOVWF       R0 
	MOVF        PORTB+0, 0 
	MOVWF       FARG_keyHandler_key+0 
	MOVLW       0
	MOVWF       FARG_keyHandler_key+1 
	MOVF        R0, 0 
L__keypadHandler39:
	BZ          L__keypadHandler40
	RRCF        FARG_keyHandler_key+0, 1 
	BCF         FARG_keyHandler_key+0, 7 
	ADDLW       255
	GOTO        L__keypadHandler39
L__keypadHandler40:
;Temporizador.c,260 :: 		PORTB = 0;
	CLRF        PORTB+0 
;Temporizador.c,262 :: 		realCode = rowCode | (columnCode << 4);
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
;Temporizador.c,263 :: 		result = keyHandler(realCode, &type);
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
;Temporizador.c,265 :: 		nPressed += 1;
	INFSNZ      _nPressed+0, 1 
	INCF        _nPressed+1, 1 
;Temporizador.c,267 :: 		if(nPressed < 3)
	MOVLW       128
	XORWF       _nPressed+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler41
	MOVLW       3
	SUBWF       _nPressed+0, 0 
L__keypadHandler41:
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadHandler10
;Temporizador.c,269 :: 		time *= 10;
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
;Temporizador.c,270 :: 		time += result;
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
;Temporizador.c,271 :: 		}
	GOTO        L_keypadHandler11
L_keypadHandler10:
;Temporizador.c,274 :: 		time += result * 0.1;
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
;Temporizador.c,275 :: 		}
L_keypadHandler11:
;Temporizador.c,277 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Temporizador.c,278 :: 		FloatToStr(time, str);
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
;Temporizador.c,279 :: 		Lcd_Out(1, 1, str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _str+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Temporizador.c,280 :: 		}
L_end_keypadHandler:
	RETURN      0
; end of _keypadHandler

_keyHandler:

;Temporizador.c,283 :: 		int keyHandler (int key, KeyType* type)
;Temporizador.c,285 :: 		int result = -1;
	MOVLW       255
	MOVWF       keyHandler_result_L0+0 
	MOVLW       255
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,286 :: 		switch(key)
	GOTO        L_keyHandler12
;Temporizador.c,288 :: 		case 231:
L_keyHandler14:
;Temporizador.c,289 :: 		*type = ON_CLEAR;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       5
	MOVWF       POSTINC1+0 
;Temporizador.c,290 :: 		break;
	GOTO        L_keyHandler13
;Temporizador.c,292 :: 		case 215:
L_keyHandler15:
;Temporizador.c,293 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,294 :: 		result = 0;
	CLRF        keyHandler_result_L0+0 
	CLRF        keyHandler_result_L0+1 
;Temporizador.c,295 :: 		break;
	GOTO        L_keyHandler13
;Temporizador.c,297 :: 		case 183:
L_keyHandler16:
;Temporizador.c,298 :: 		*type = EQUALS;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	CLRF        POSTINC1+0 
;Temporizador.c,299 :: 		break;
	GOTO        L_keyHandler13
;Temporizador.c,301 :: 		case 119:
L_keyHandler17:
;Temporizador.c,302 :: 		*type = SUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
;Temporizador.c,303 :: 		break;
	GOTO        L_keyHandler13
;Temporizador.c,305 :: 		case 235:
L_keyHandler18:
;Temporizador.c,306 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,307 :: 		result = 1;
	MOVLW       1
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,308 :: 		break;
	GOTO        L_keyHandler13
;Temporizador.c,310 :: 		case 219:
L_keyHandler19:
;Temporizador.c,311 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,312 :: 		result = 2;
	MOVLW       2
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,313 :: 		break;
	GOTO        L_keyHandler13
;Temporizador.c,315 :: 		case 187:
L_keyHandler20:
;Temporizador.c,316 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,317 :: 		result = 3;
	MOVLW       3
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,318 :: 		break;
	GOTO        L_keyHandler13
;Temporizador.c,320 :: 		case 123:
L_keyHandler21:
;Temporizador.c,321 :: 		*type = SUB;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       2
	MOVWF       POSTINC1+0 
;Temporizador.c,322 :: 		break;
	GOTO        L_keyHandler13
;Temporizador.c,324 :: 		case 237:
L_keyHandler22:
;Temporizador.c,325 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,326 :: 		result = 4;
	MOVLW       4
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,327 :: 		break;
	GOTO        L_keyHandler13
;Temporizador.c,329 :: 		case 221:
L_keyHandler23:
;Temporizador.c,330 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,331 :: 		result = 5;
	MOVLW       5
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,332 :: 		break;
	GOTO        L_keyHandler13
;Temporizador.c,334 :: 		case 189:
L_keyHandler24:
;Temporizador.c,335 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,336 :: 		result = 6;
	MOVLW       6
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,337 :: 		break;
	GOTO        L_keyHandler13
;Temporizador.c,339 :: 		case 125:
L_keyHandler25:
;Temporizador.c,340 :: 		*type = MULT;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       3
	MOVWF       POSTINC1+0 
;Temporizador.c,341 :: 		break;
	GOTO        L_keyHandler13
;Temporizador.c,343 :: 		case 238:
L_keyHandler26:
;Temporizador.c,344 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,345 :: 		result = 7;
	MOVLW       7
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,346 :: 		break;
	GOTO        L_keyHandler13
;Temporizador.c,348 :: 		case 222:
L_keyHandler27:
;Temporizador.c,349 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,350 :: 		result = 8;
	MOVLW       8
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,351 :: 		break;
	GOTO        L_keyHandler13
;Temporizador.c,353 :: 		case 190:
L_keyHandler28:
;Temporizador.c,354 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;Temporizador.c,355 :: 		result = 9;
	MOVLW       9
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;Temporizador.c,356 :: 		break;
	GOTO        L_keyHandler13
;Temporizador.c,358 :: 		case 126:
L_keyHandler29:
;Temporizador.c,359 :: 		*type = DIVI;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       4
	MOVWF       POSTINC1+0 
;Temporizador.c,360 :: 		break;
	GOTO        L_keyHandler13
;Temporizador.c,361 :: 		}
L_keyHandler12:
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler43
	MOVLW       231
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler43:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler14
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler44
	MOVLW       215
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler44:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler15
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler45
	MOVLW       183
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler45:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler16
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler46
	MOVLW       119
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler46:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler17
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler47
	MOVLW       235
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler47:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler18
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler48
	MOVLW       219
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler48:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler19
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler49
	MOVLW       187
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler49:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler20
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler50
	MOVLW       123
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler50:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler21
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler51
	MOVLW       237
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler51:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler22
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler52
	MOVLW       221
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler52:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler23
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler53
	MOVLW       189
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler53:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler24
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler54
	MOVLW       125
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler54:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler25
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler55
	MOVLW       238
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler55:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler26
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler56
	MOVLW       222
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler56:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler27
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler57
	MOVLW       190
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler57:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler28
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler58
	MOVLW       126
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler58:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler29
L_keyHandler13:
;Temporizador.c,363 :: 		return result;
	MOVF        keyHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keyHandler_result_L0+1, 0 
	MOVWF       R1 
;Temporizador.c,364 :: 		}
L_end_keyHandler:
	RETURN      0
; end of _keyHandler
