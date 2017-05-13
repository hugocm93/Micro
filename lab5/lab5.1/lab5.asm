
_interrupt:

;lab5.c,22 :: 		void interrupt()
;lab5.c,24 :: 		if (intcon.tmr0if)
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;lab5.c,26 :: 		freq = pulse_count/1.0;
	MOVF        _pulse_count+0, 0 
	MOVWF       R0 
	MOVF        _pulse_count+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        R0, 0 
	MOVWF       _freq+0 
	MOVF        R1, 0 
	MOVWF       _freq+1 
	MOVF        R2, 0 
	MOVWF       _freq+2 
	MOVF        R3, 0 
	MOVWF       _freq+3 
;lab5.c,29 :: 		tmr0h = COUNTER >> 8;  // Load Timer 0 counter - 1st TMR0H
	MOVLW       225
	MOVWF       TMR0H+0 
;lab5.c,30 :: 		tmr0l = COUNTER;       // Load Timer 0 counter - 2nd TMR0L
	MOVLW       121
	MOVWF       TMR0L+0 
;lab5.c,32 :: 		pulse_count = 0;
	CLRF        _pulse_count+0 
	CLRF        _pulse_count+1 
;lab5.c,34 :: 		intcon.tmr0if = 0;
	BCF         INTCON+0, 2 
;lab5.c,35 :: 		}
L_interrupt0:
;lab5.c,38 :: 		if(intcon.int0if)
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt1
;lab5.c,40 :: 		++pulse_count;
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
;lab5.c,42 :: 		intcon.int0if=0;
	BCF         INTCON+0, 1 
;lab5.c,43 :: 		}
L_interrupt1:
;lab5.c,45 :: 		}
L_end_interrupt:
L__interrupt6:
	RETFIE      1
; end of _interrupt

_main:

;lab5.c,49 :: 		void main()
;lab5.c,51 :: 		adcon1 = 0x06;
	MOVLW       6
	MOVWF       ADCON1+0 
;lab5.c,53 :: 		Lcd_init();
	CALL        _Lcd_Init+0, 0
;lab5.c,56 :: 		intcon.gie = 1;
	BSF         INTCON+0, 7 
;lab5.c,57 :: 		intcon.peie = 1;
	BSF         INTCON+0, 6 
;lab5.c,58 :: 		intcon.int0ie = 1;
	BSF         INTCON+0, 4 
;lab5.c,59 :: 		intcon.int0if = 0;
	BCF         INTCON+0, 1 
;lab5.c,60 :: 		intcon.intedg0 = 1;
	BSF         INTCON+0, 6 
;lab5.c,61 :: 		trisb.rb0 = 1; //definindo rb0 como in
	BSF         TRISB+0, 0 
;lab5.c,65 :: 		t0con.t08bit = 0;       // 16 bits
	BCF         T0CON+0, 6 
;lab5.c,66 :: 		t0con.t0cs = 0;         // internal clock => crystal/4
	BCF         T0CON+0, 5 
;lab5.c,67 :: 		t0con.psa = 0;          // prescaler on
	BCF         T0CON+0, 3 
;lab5.c,70 :: 		t0con.t0ps2 = 1;
	BSF         T0CON+0, 2 
;lab5.c,71 :: 		t0con.t0ps1 = 1;
	BSF         T0CON+0, 1 
;lab5.c,72 :: 		t0con.t0ps0 = 1;
	BSF         T0CON+0, 0 
;lab5.c,75 :: 		tmr0h = COUNTER >> 8;  // load timer 0 counter - 1st tmr0h
	MOVLW       225
	MOVWF       TMR0H+0 
;lab5.c,76 :: 		tmr0l = COUNTER;       // load timer 0 counter - 2nd tmr0l
	MOVLW       121
	MOVWF       TMR0L+0 
;lab5.c,79 :: 		intcon.tmr0if=0;
	BCF         INTCON+0, 2 
;lab5.c,80 :: 		intcon.tmr0ie=1;
	BSF         INTCON+0, 5 
;lab5.c,82 :: 		t0con.tmr0on=1;         // timer on
	BSF         T0CON+0, 7 
;lab5.c,84 :: 		while(1)
L_main2:
;lab5.c,86 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;lab5.c,87 :: 		FloatToStr(freq, str);
	MOVF        _freq+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _freq+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _freq+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _freq+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _str+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;lab5.c,88 :: 		lcd_out(1,1,str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _str+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_str+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;lab5.c,89 :: 		lcd_out(1,13,"Hz");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       13
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_lab5+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_lab5+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;lab5.c,91 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
	NOP
;lab5.c,92 :: 		}
	GOTO        L_main2
;lab5.c,93 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
