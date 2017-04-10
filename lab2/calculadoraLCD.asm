
_interrupt:

;calculadoraLCD.c,20 :: 		void interrupt(void){
;calculadoraLCD.c,21 :: 		if(INTCON.RBIF)
	BTFSS       INTCON+0, 0 
	GOTO        L_interrupt0
;calculadoraLCD.c,26 :: 		for(i = 0, xx = 0x0f; (i < 4) && (xx==0x0f); i++)
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
L__interrupt12:
;calculadoraLCD.c,28 :: 		PORTB.RB0 = 1; // digital output
	BSF         PORTB+0, 0 
;calculadoraLCD.c,29 :: 		PORTB.RB1 = 1;
	BSF         PORTB+0, 1 
;calculadoraLCD.c,30 :: 		PORTB.RB2 = 1;
	BSF         PORTB+0, 2 
;calculadoraLCD.c,31 :: 		PORTB.RB3 = 1;
	BSF         PORTB+0, 3 
;calculadoraLCD.c,32 :: 		if(i==0)PORTB.RB0 = 0; // digital output
	MOVF        interrupt_i_L1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt6
	BCF         PORTB+0, 0 
L_interrupt6:
;calculadoraLCD.c,33 :: 		if(i==1)PORTB.RB1 = 0;
	MOVF        interrupt_i_L1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
	BCF         PORTB+0, 1 
L_interrupt7:
;calculadoraLCD.c,34 :: 		if(i==2)PORTB.RB2 = 0;
	MOVF        interrupt_i_L1+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
	BCF         PORTB+0, 2 
L_interrupt8:
;calculadoraLCD.c,35 :: 		if(i==3)PORTB.RB3 = 0;
	MOVF        interrupt_i_L1+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt9
	BCF         PORTB+0, 3 
L_interrupt9:
;calculadoraLCD.c,36 :: 		xx = PORTB >> 4;
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
;calculadoraLCD.c,26 :: 		for(i = 0, xx = 0x0f; (i < 4) && (xx==0x0f); i++)
	INCF        interrupt_i_L1+0, 1 
;calculadoraLCD.c,37 :: 		}
	GOTO        L_interrupt1
L_interrupt2:
;calculadoraLCD.c,39 :: 		IntToStr(PORTB, text);
	MOVF        PORTB+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       interrupt_text_L1+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(interrupt_text_L1+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;calculadoraLCD.c,42 :: 		PORTB.RB0 = 0; // digital output
	BCF         PORTB+0, 0 
;calculadoraLCD.c,43 :: 		PORTB.RB1 = 0;
	BCF         PORTB+0, 1 
;calculadoraLCD.c,44 :: 		PORTB.RB2 = 0;
	BCF         PORTB+0, 2 
;calculadoraLCD.c,45 :: 		PORTB.RB3 = 0;
	BCF         PORTB+0, 3 
;calculadoraLCD.c,47 :: 		if(edge == 1)
	MOVF        _edge+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt10
;calculadoraLCD.c,49 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;calculadoraLCD.c,50 :: 		Lcd_Out(1,1,text);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       interrupt_text_L1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(interrupt_text_L1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;calculadoraLCD.c,51 :: 		}
	GOTO        L_interrupt11
L_interrupt10:
;calculadoraLCD.c,55 :: 		}
L_interrupt11:
;calculadoraLCD.c,57 :: 		edge = !edge;
	MOVF        _edge+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _edge+0 
;calculadoraLCD.c,58 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;calculadoraLCD.c,59 :: 		}
L_interrupt0:
;calculadoraLCD.c,60 :: 		}
L_end_interrupt:
L__interrupt14:
	RETFIE      1
; end of _interrupt

_main:

;calculadoraLCD.c,62 :: 		void main()
;calculadoraLCD.c,65 :: 		ADCON1 = 0x6;
	MOVLW       6
	MOVWF       ADCON1+0 
;calculadoraLCD.c,68 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;calculadoraLCD.c,71 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;calculadoraLCD.c,74 :: 		TRISB.RB4 = 1; // digital input
	BSF         TRISB+0, 4 
;calculadoraLCD.c,75 :: 		TRISB.RB5 = 1; // digital input
	BSF         TRISB+0, 5 
;calculadoraLCD.c,76 :: 		TRISB.RB6 = 1; // digital input
	BSF         TRISB+0, 6 
;calculadoraLCD.c,77 :: 		TRISB.RB7 = 1; // digital input
	BSF         TRISB+0, 7 
;calculadoraLCD.c,79 :: 		TRISB.RB0 = 0; // digital output
	BCF         TRISB+0, 0 
;calculadoraLCD.c,80 :: 		TRISB.RB1 = 0;
	BCF         TRISB+0, 1 
;calculadoraLCD.c,81 :: 		TRISB.RB2 = 0;
	BCF         TRISB+0, 2 
;calculadoraLCD.c,82 :: 		TRISB.RB3 = 0;
	BCF         TRISB+0, 3 
;calculadoraLCD.c,84 :: 		PORTB.RB0 = 0; // digital output
	BCF         PORTB+0, 0 
;calculadoraLCD.c,85 :: 		PORTB.RB1 = 0;
	BCF         PORTB+0, 1 
;calculadoraLCD.c,86 :: 		PORTB.RB2 = 0;
	BCF         PORTB+0, 2 
;calculadoraLCD.c,87 :: 		PORTB.RB3 = 0;
	BCF         PORTB+0, 3 
;calculadoraLCD.c,89 :: 		INTCON.RBIE = 1;
	BSF         INTCON+0, 3 
;calculadoraLCD.c,90 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;calculadoraLCD.c,91 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
