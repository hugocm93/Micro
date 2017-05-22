
_interrupt:

;motor.c,43 :: 		void interrupt(void)
;motor.c,45 :: 		if (intcon.tmr0if)
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;motor.c,48 :: 		tmr0h = COUNTER >> 8;  // Load Timer 0 COUNTER - 1st TMR0H
	MOVLW       252
	MOVWF       TMR0H+0 
;motor.c,49 :: 		tmr0l = COUNTER;       // Load Timer 0 COUNTER - 2nd TMR0L
	MOVLW       241
	MOVWF       TMR0L+0 
;motor.c,51 :: 		freq = pulse_count/WINDOW;
	MOVF        _pulse_count+0, 0 
	MOVWF       R0 
	MOVF        _pulse_count+1, 0 
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
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _freq+0 
	MOVF        R1, 0 
	MOVWF       _freq+1 
	MOVF        R2, 0 
	MOVWF       _freq+2 
	MOVF        R3, 0 
	MOVWF       _freq+3 
;motor.c,52 :: 		pulse_count = 0;
	CLRF        _pulse_count+0 
	CLRF        _pulse_count+1 
;motor.c,54 :: 		error = setPoint - (freq*60)/64.0;
	MOVF        _freq+0, 0 
	MOVWF       R0 
	MOVF        _freq+1, 0 
	MOVWF       R1 
	MOVF        _freq+2, 0 
	MOVWF       R2 
	MOVF        _freq+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       112
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__interrupt+0 
	MOVF        R1, 0 
	MOVWF       FLOC__interrupt+1 
	MOVF        R2, 0 
	MOVWF       FLOC__interrupt+2 
	MOVF        R3, 0 
	MOVWF       FLOC__interrupt+3 
	MOVF        _setPoint+0, 0 
	MOVWF       R0 
	MOVF        _setPoint+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        FLOC__interrupt+0, 0 
	MOVWF       R4 
	MOVF        FLOC__interrupt+1, 0 
	MOVWF       R5 
	MOVF        FLOC__interrupt+2, 0 
	MOVWF       R6 
	MOVF        FLOC__interrupt+3, 0 
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _error+0 
	MOVF        R1, 0 
	MOVWF       _error+1 
	MOVF        R2, 0 
	MOVWF       _error+2 
	MOVF        R3, 0 
	MOVWF       _error+3 
;motor.c,55 :: 		I += error;
	MOVF        _I+0, 0 
	MOVWF       R0 
	MOVF        _I+1, 0 
	MOVWF       R1 
	MOVF        _I+2, 0 
	MOVWF       R2 
	MOVF        _I+3, 0 
	MOVWF       R3 
	MOVF        _error+0, 0 
	MOVWF       R4 
	MOVF        _error+1, 0 
	MOVWF       R5 
	MOVF        _error+2, 0 
	MOVWF       R6 
	MOVF        _error+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _I+0 
	MOVF        R1, 0 
	MOVWF       _I+1 
	MOVF        R2, 0 
	MOVWF       _I+2 
	MOVF        R3, 0 
	MOVWF       _I+3 
;motor.c,56 :: 		duty = u0 + kp*error + ki*I;
	MOVLW       10
	MOVWF       R0 
	MOVLW       215
	MOVWF       R1 
	MOVLW       35
	MOVWF       R2 
	MOVLW       120
	MOVWF       R3 
	MOVF        _error+0, 0 
	MOVWF       R4 
	MOVF        _error+1, 0 
	MOVWF       R5 
	MOVF        _error+2, 0 
	MOVWF       R6 
	MOVF        _error+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__interrupt+0 
	MOVF        R1, 0 
	MOVWF       FLOC__interrupt+1 
	MOVF        R2, 0 
	MOVWF       FLOC__interrupt+2 
	MOVF        R3, 0 
	MOVWF       FLOC__interrupt+3 
	MOVF        _u0+0, 0 
	MOVWF       R0 
	MOVF        _u0+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        FLOC__interrupt+0, 0 
	MOVWF       R4 
	MOVF        FLOC__interrupt+1, 0 
	MOVWF       R5 
	MOVF        FLOC__interrupt+2, 0 
	MOVWF       R6 
	MOVF        FLOC__interrupt+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__interrupt+0 
	MOVF        R1, 0 
	MOVWF       FLOC__interrupt+1 
	MOVF        R2, 0 
	MOVWF       FLOC__interrupt+2 
	MOVF        R3, 0 
	MOVWF       FLOC__interrupt+3 
	MOVLW       10
	MOVWF       R0 
	MOVLW       215
	MOVWF       R1 
	MOVLW       35
	MOVWF       R2 
	MOVLW       120
	MOVWF       R3 
	MOVF        _I+0, 0 
	MOVWF       R4 
	MOVF        _I+1, 0 
	MOVWF       R5 
	MOVF        _I+2, 0 
	MOVWF       R6 
	MOVF        _I+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__interrupt+0, 0 
	MOVWF       R4 
	MOVF        FLOC__interrupt+1, 0 
	MOVWF       R5 
	MOVF        FLOC__interrupt+2, 0 
	MOVWF       R6 
	MOVF        FLOC__interrupt+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       _duty+0 
	MOVF        R1, 0 
	MOVWF       _duty+1 
;motor.c,57 :: 		if(duty < 0)
	MOVLW       128
	XORWF       _duty+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt33
	MOVLW       0
	SUBWF       _duty+0, 0 
L__interrupt33:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt1
;motor.c,58 :: 		duty = 0;
	CLRF        _duty+0 
	CLRF        _duty+1 
	GOTO        L_interrupt2
L_interrupt1:
;motor.c,59 :: 		else if(duty > 255)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _duty+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt34
	MOVF        _duty+0, 0 
	SUBLW       255
L__interrupt34:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt3
;motor.c,60 :: 		duty = 255;
	MOVLW       255
	MOVWF       _duty+0 
	MOVLW       0
	MOVWF       _duty+1 
L_interrupt3:
L_interrupt2:
;motor.c,63 :: 		PWM1_Set_Duty(duty);
	MOVF        _duty+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;motor.c,65 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;motor.c,66 :: 		FloatToStr((freq*60)/64, str);
	MOVF        _freq+0, 0 
	MOVWF       R0 
	MOVF        _freq+1, 0 
	MOVWF       R1 
	MOVF        _freq+2, 0 
	MOVWF       R2 
	MOVF        _freq+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       112
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _str+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;motor.c,67 :: 		lcd_out(1,1,str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _str+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;motor.c,68 :: 		IntToStr(duty, str);
	MOVF        _duty+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _duty+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _str+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;motor.c,69 :: 		lcd_out(1,10,str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _str+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;motor.c,72 :: 		IntToStr(setPoint, str);
	MOVF        _setPoint+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _setPoint+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _str+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;motor.c,74 :: 		lcd_out(2,11,str);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _str+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;motor.c,75 :: 		FloatToStr(error, str);
	MOVF        _error+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _error+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _error+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _error+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _str+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;motor.c,76 :: 		lcd_out(2,1,str);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _str+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;motor.c,78 :: 		intcon.tmr0if = 0;
	BCF         INTCON+0, 2 
;motor.c,79 :: 		}
L_interrupt0:
;motor.c,81 :: 		if(intcon.int0if)
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt4
;motor.c,83 :: 		++pulse_count;
	MOVLW       1
	ADDWF       _pulse_count+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _pulse_count+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _pulse_count+0 
	MOVF        R1, 0 
	MOVWF       _pulse_count+1 
;motor.c,85 :: 		intcon.int0if=0;
	BCF         INTCON+0, 1 
;motor.c,86 :: 		}
L_interrupt4:
;motor.c,88 :: 		if(intcon3.int1if)
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt5
;motor.c,90 :: 		keypadhandler();
	CALL        _keypadHandler+0, 0
;motor.c,93 :: 		tmr3h = COUNTER3 >> 8;
	MOVLW       21
	MOVWF       TMR3H+0 
;motor.c,94 :: 		tmr3l = COUNTER3;
	MOVLW       159
	MOVWF       TMR3L+0 
;motor.c,95 :: 		pir2.tmr3if = 0;
	BCF         PIR2+0, 1 
;motor.c,96 :: 		pie2.tmr3ie = 1;
	BSF         PIE2+0, 1 
;motor.c,97 :: 		t3con.tmr3on = 1;
	BSF         T3CON+0, 0 
;motor.c,100 :: 		intcon3.int1ie = 0;
	BCF         INTCON3+0, 3 
;motor.c,101 :: 		intcon3.int1if = 0;
	BCF         INTCON3+0, 0 
;motor.c,102 :: 		}
L_interrupt5:
;motor.c,104 :: 		if(pir2.tmr3if) // related to bouncing
	BTFSS       PIR2+0, 1 
	GOTO        L_interrupt6
;motor.c,106 :: 		pir2.tmr3if = 0;
	BCF         PIR2+0, 1 
;motor.c,107 :: 		pie2.tmr3ie = 0;
	BCF         PIE2+0, 1 
;motor.c,108 :: 		t3con.tmr3on = 0;
	BCF         T3CON+0, 0 
;motor.c,111 :: 		intcon3.int1ie = 1;
	BSF         INTCON3+0, 3 
;motor.c,112 :: 		intcon3.int1if = 0;
	BCF         INTCON3+0, 0 
;motor.c,113 :: 		}
L_interrupt6:
;motor.c,114 :: 		}
L_end_interrupt:
L__interrupt32:
	RETFIE      1
; end of _interrupt

_main:

;motor.c,116 :: 		void main()
;motor.c,119 :: 		adcon1 = 0x04;
	MOVLW       4
	MOVWF       ADCON1+0 
;motor.c,121 :: 		Lcd_init();
	CALL        _Lcd_Init+0, 0
;motor.c,124 :: 		trisa.an0 = 1;
	BSF         TRISA+0, 0 
;motor.c,127 :: 		PWM1_Init(5000);
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       99
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;motor.c,128 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;motor.c,131 :: 		intcon.gie = 1;
	BSF         INTCON+0, 7 
;motor.c,132 :: 		intcon.peie = 1;
	BSF         INTCON+0, 6 
;motor.c,133 :: 		intcon.int0ie = 1;
	BSF         INTCON+0, 4 
;motor.c,134 :: 		intcon.int0if = 0;
	BCF         INTCON+0, 1 
;motor.c,135 :: 		intcon.intedg0 = 1;
	BSF         INTCON+0, 6 
;motor.c,136 :: 		trisb.rb0 = 1; //definindo rb0 como in
	BSF         TRISB+0, 0 
;motor.c,139 :: 		t0con.t08bit = 0;       // 16 bits
	BCF         T0CON+0, 6 
;motor.c,140 :: 		t0con.t0cs = 0;         // internal clock => crystal/4
	BCF         T0CON+0, 5 
;motor.c,141 :: 		t0con.psa = 0;          // prescaler on
	BCF         T0CON+0, 3 
;motor.c,143 :: 		t0con.t0ps2 = 1;
	BSF         T0CON+0, 2 
;motor.c,144 :: 		t0con.t0ps1 = 1;
	BSF         T0CON+0, 1 
;motor.c,145 :: 		t0con.t0ps0 = 1;
	BSF         T0CON+0, 0 
;motor.c,147 :: 		tmr0h = COUNTER >> 8;  // load timer 0 COUNTER - 1st tmr0h
	MOVLW       252
	MOVWF       TMR0H+0 
;motor.c,148 :: 		tmr0l = COUNTER;       // load timer 0 COUNTER - 2nd tmr0l
	MOVLW       241
	MOVWF       TMR0L+0 
;motor.c,150 :: 		intcon.tmr0if=0;
	BCF         INTCON+0, 2 
;motor.c,151 :: 		intcon.tmr0ie=1;
	BSF         INTCON+0, 5 
;motor.c,153 :: 		t0con.tmr0on=1;         // timer on
	BSF         T0CON+0, 7 
;motor.c,156 :: 		t3con.rd16 = 1;
	BSF         T3CON+0, 7 
;motor.c,157 :: 		t3con.t3ccp2 = 1;
	BSF         T3CON+0, 6 
;motor.c,158 :: 		t3con.t3ckps1 = 0;
	BCF         T3CON+0, 5 
;motor.c,159 :: 		t3con.t3ckps0 = 1;
	BSF         T3CON+0, 4 
;motor.c,160 :: 		t3con.tmr3cs = 0;
	BCF         T3CON+0, 1 
;motor.c,163 :: 		intcon3.int1ie = 1;
	BSF         INTCON3+0, 3 
;motor.c,164 :: 		intcon3.int1if = 0;
	BCF         INTCON3+0, 0 
;motor.c,167 :: 		trisb.rb1 = 1;
	BSF         TRISB+0, 1 
;motor.c,171 :: 		trisb.rb4 = 0;
	BCF         TRISB+0, 4 
;motor.c,172 :: 		trisb.rb5 = 0;
	BCF         TRISB+0, 5 
;motor.c,173 :: 		trisb.rb6 = 0;
	BCF         TRISB+0, 6 
;motor.c,174 :: 		trisb.rb7 = 0;
	BCF         TRISB+0, 7 
;motor.c,176 :: 		portb.rb4 = 0;
	BCF         PORTB+0, 4 
;motor.c,177 :: 		portb.rb5 = 0;
	BCF         PORTB+0, 5 
;motor.c,178 :: 		portb.rb6 = 0;
	BCF         PORTB+0, 6 
;motor.c,179 :: 		portb.rb7 = 0;
	BCF         PORTB+0, 7 
;motor.c,183 :: 		trisa.ra2 = 1;
	BSF         TRISA+0, 2 
;motor.c,184 :: 		trisa.ra4 = 1;
	BSF         TRISA+0, 4 
;motor.c,185 :: 		trisa.ra5 = 1;
	BSF         TRISA+0, 5 
;motor.c,186 :: 		trisb.rb3 = 1;
	BSF         TRISB+0, 3 
;motor.c,187 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_keypadHandler:

;motor.c,189 :: 		void keypadHandler()
;motor.c,194 :: 		char rowCode = 0;
;motor.c,195 :: 		char keycode = 0;
;motor.c,196 :: 		char columnCode = 0;
	CLRF        keypadHandler_columnCode_L0+0 
;motor.c,198 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	CLRF        keypadHandler_i_L0+0 
	MOVLW       15
	MOVWF       keypadHandler_columnCode_L0+0 
L_keypadHandler7:
	MOVF        keypadHandler_columnCode_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler8
;motor.c,201 :: 		PORTB = ~(1 << i) << 4;
	MOVF        keypadHandler_i_L0+0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__keypadHandler37:
	BZ          L__keypadHandler38
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__keypadHandler37
L__keypadHandler38:
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
;motor.c,202 :: 		columnCode = PORTA.RA2 | (PORTA.RA4 << 1) |
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
;motor.c,203 :: 		(PORTA.RA5 << 2) | (PORTB.RB3) << 3;
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
L__keypadHandler39:
	BZ          L__keypadHandler40
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__keypadHandler39
L__keypadHandler40:
	MOVF        R0, 0 
	IORWF       keypadHandler_columnCode_L0+0, 1 
;motor.c,198 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	INCF        keypadHandler_i_L0+0, 1 
;motor.c,205 :: 		}
	GOTO        L_keypadHandler7
L_keypadHandler8:
;motor.c,206 :: 		rowCode = PORTB >> 4;
	MOVLW       4
	MOVWF       R0 
	MOVF        PORTB+0, 0 
	MOVWF       FARG_keyHandler_key+0 
	MOVLW       0
	MOVWF       FARG_keyHandler_key+1 
	MOVF        R0, 0 
L__keypadHandler41:
	BZ          L__keypadHandler42
	RRCF        FARG_keyHandler_key+0, 1 
	BCF         FARG_keyHandler_key+0, 7 
	ADDLW       255
	GOTO        L__keypadHandler41
L__keypadHandler42:
;motor.c,207 :: 		PORTB = 0;
	CLRF        PORTB+0 
;motor.c,209 :: 		keycode = rowCode | (columnCode << 4);
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
;motor.c,210 :: 		result = keyHandler(keycode, &type);
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
;motor.c,212 :: 		if(type == NUM)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler10
;motor.c,214 :: 		tempSetPoint *= 10;
	MOVF        _tempSetPoint+0, 0 
	MOVWF       R0 
	MOVF        _tempSetPoint+1, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _tempSetPoint+0 
	MOVF        R1, 0 
	MOVWF       _tempSetPoint+1 
;motor.c,215 :: 		tempSetPoint += result;
	MOVF        keypadHandler_result_L0+0, 0 
	ADDWF       _tempSetPoint+0, 1 
	MOVF        keypadHandler_result_L0+1, 0 
	ADDWFC      _tempSetPoint+1, 1 
;motor.c,216 :: 		}
	GOTO        L_keypadHandler11
L_keypadHandler10:
;motor.c,217 :: 		else if(type == SUM)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler12
;motor.c,219 :: 		setPoint = tempSetPoint;
	MOVF        _tempSetPoint+0, 0 
	MOVWF       _setPoint+0 
	MOVF        _tempSetPoint+1, 0 
	MOVWF       _setPoint+1 
;motor.c,220 :: 		tempSetPoint = 0;
	CLRF        _tempSetPoint+0 
	CLRF        _tempSetPoint+1 
;motor.c,221 :: 		}
L_keypadHandler12:
L_keypadHandler11:
;motor.c,222 :: 		}
L_end_keypadHandler:
	RETURN      0
; end of _keypadHandler

_keyHandler:

;motor.c,225 :: 		int keyHandler (int key, KeyType* type)
;motor.c,227 :: 		int result = -1;
	MOVLW       255
	MOVWF       keyHandler_result_L0+0 
	MOVLW       255
	MOVWF       keyHandler_result_L0+1 
;motor.c,228 :: 		switch(key)
	GOTO        L_keyHandler13
;motor.c,230 :: 		case 231:
L_keyHandler15:
;motor.c,231 :: 		*type = ON_CLEAR;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       5
	MOVWF       POSTINC1+0 
;motor.c,232 :: 		break;
	GOTO        L_keyHandler14
;motor.c,234 :: 		case 215:
L_keyHandler16:
;motor.c,235 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;motor.c,236 :: 		result = 0;
	CLRF        keyHandler_result_L0+0 
	CLRF        keyHandler_result_L0+1 
;motor.c,237 :: 		break;
	GOTO        L_keyHandler14
;motor.c,239 :: 		case 183:
L_keyHandler17:
;motor.c,240 :: 		*type = EQUALS;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	CLRF        POSTINC1+0 
;motor.c,241 :: 		break;
	GOTO        L_keyHandler14
;motor.c,243 :: 		case 119:
L_keyHandler18:
;motor.c,244 :: 		*type = SUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
;motor.c,245 :: 		break;
	GOTO        L_keyHandler14
;motor.c,247 :: 		case 235:
L_keyHandler19:
;motor.c,248 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;motor.c,249 :: 		result = 1;
	MOVLW       1
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;motor.c,250 :: 		break;
	GOTO        L_keyHandler14
;motor.c,252 :: 		case 219:
L_keyHandler20:
;motor.c,253 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;motor.c,254 :: 		result = 2;
	MOVLW       2
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;motor.c,255 :: 		break;
	GOTO        L_keyHandler14
;motor.c,257 :: 		case 187:
L_keyHandler21:
;motor.c,258 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;motor.c,259 :: 		result = 3;
	MOVLW       3
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;motor.c,260 :: 		break;
	GOTO        L_keyHandler14
;motor.c,262 :: 		case 123:
L_keyHandler22:
;motor.c,263 :: 		*type = SUB;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       2
	MOVWF       POSTINC1+0 
;motor.c,264 :: 		break;
	GOTO        L_keyHandler14
;motor.c,266 :: 		case 237:
L_keyHandler23:
;motor.c,267 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;motor.c,268 :: 		result = 4;
	MOVLW       4
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;motor.c,269 :: 		break;
	GOTO        L_keyHandler14
;motor.c,271 :: 		case 221:
L_keyHandler24:
;motor.c,272 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;motor.c,273 :: 		result = 5;
	MOVLW       5
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;motor.c,274 :: 		break;
	GOTO        L_keyHandler14
;motor.c,276 :: 		case 189:
L_keyHandler25:
;motor.c,277 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;motor.c,278 :: 		result = 6;
	MOVLW       6
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;motor.c,279 :: 		break;
	GOTO        L_keyHandler14
;motor.c,281 :: 		case 125:
L_keyHandler26:
;motor.c,282 :: 		*type = MULT;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       3
	MOVWF       POSTINC1+0 
;motor.c,283 :: 		break;
	GOTO        L_keyHandler14
;motor.c,285 :: 		case 238:
L_keyHandler27:
;motor.c,286 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;motor.c,287 :: 		result = 7;
	MOVLW       7
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;motor.c,288 :: 		break;
	GOTO        L_keyHandler14
;motor.c,290 :: 		case 222:
L_keyHandler28:
;motor.c,291 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;motor.c,292 :: 		result = 8;
	MOVLW       8
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;motor.c,293 :: 		break;
	GOTO        L_keyHandler14
;motor.c,295 :: 		case 190:
L_keyHandler29:
;motor.c,296 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;motor.c,297 :: 		result = 9;
	MOVLW       9
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;motor.c,298 :: 		break;
	GOTO        L_keyHandler14
;motor.c,300 :: 		case 126:
L_keyHandler30:
;motor.c,301 :: 		*type = DIVI;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       4
	MOVWF       POSTINC1+0 
;motor.c,302 :: 		break;
	GOTO        L_keyHandler14
;motor.c,303 :: 		}
L_keyHandler13:
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler44
	MOVLW       231
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler44:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler15
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler45
	MOVLW       215
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler45:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler16
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler46
	MOVLW       183
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler46:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler17
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler47
	MOVLW       119
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler47:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler18
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler48
	MOVLW       235
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler48:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler19
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler49
	MOVLW       219
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler49:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler20
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler50
	MOVLW       187
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler50:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler21
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler51
	MOVLW       123
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler51:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler22
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler52
	MOVLW       237
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler52:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler23
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler53
	MOVLW       221
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler53:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler24
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler54
	MOVLW       189
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler54:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler25
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler55
	MOVLW       125
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler55:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler26
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler56
	MOVLW       238
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler56:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler27
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler57
	MOVLW       222
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler57:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler28
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler58
	MOVLW       190
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler58:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler29
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler59
	MOVLW       126
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler59:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler30
L_keyHandler14:
;motor.c,305 :: 		return result;
	MOVF        keyHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keyHandler_result_L0+1, 0 
	MOVWF       R1 
;motor.c,306 :: 		}
L_end_keyHandler:
	RETURN      0
; end of _keyHandler
