
_interrupt:

;calculadoraLCD.c,18 :: 		void interrupt(void){
;calculadoraLCD.c,19 :: 		if(INTCON.RBIF)
	BTFSS       INTCON+0, 0 
	GOTO        L_interrupt0
;calculadoraLCD.c,21 :: 		char rows = PORTA;
	MOVF        PORTA+0, 0 
	MOVWF       interrupt_rows_L1+0 
;calculadoraLCD.c,23 :: 		xx = ~(PORTB) >> 4;
	COMF        PORTB+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
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
;calculadoraLCD.c,24 :: 		xx += rows;
	MOVF        interrupt_rows_L1+0, 0 
	ADDWF       _xx+0, 1 
;calculadoraLCD.c,25 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;calculadoraLCD.c,26 :: 		IntToStr(xx, text);
	MOVF        _xx+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       interrupt_text_L1+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(interrupt_text_L1+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;calculadoraLCD.c,27 :: 		Lcd_Out(1,1,text);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       interrupt_text_L1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(interrupt_text_L1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;calculadoraLCD.c,28 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;calculadoraLCD.c,29 :: 		}
L_interrupt0:
;calculadoraLCD.c,30 :: 		}
L_end_interrupt:
L__interrupt7:
	RETFIE      1
; end of _interrupt

_main:

;calculadoraLCD.c,32 :: 		void main()
;calculadoraLCD.c,34 :: 		trisa = 0; //digital output
	CLRF        TRISA+0 
;calculadoraLCD.c,35 :: 		PORTA = 0xf; //PORTA HIGH
	MOVLW       15
	MOVWF       PORTA+0 
;calculadoraLCD.c,38 :: 		ADCON1 = 0x6;
	MOVLW       6
	MOVWF       ADCON1+0 
;calculadoraLCD.c,41 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;calculadoraLCD.c,44 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;calculadoraLCD.c,47 :: 		TRISB.RB4 = 1; // digital input
	BSF         TRISB+0, 4 
;calculadoraLCD.c,48 :: 		TRISB.RB5 = 1; // digital input
	BSF         TRISB+0, 5 
;calculadoraLCD.c,49 :: 		TRISB.RB6 = 1; // digital input
	BSF         TRISB+0, 6 
;calculadoraLCD.c,50 :: 		TRISB.RB7 = 1; // digital input
	BSF         TRISB+0, 7 
;calculadoraLCD.c,52 :: 		INTCON.RBIE = 1;
	BSF         INTCON+0, 3 
;calculadoraLCD.c,53 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;calculadoraLCD.c,55 :: 		while(1)
L_main1:
;calculadoraLCD.c,57 :: 		char i = 0;
	CLRF        main_i_L1+0 
;calculadoraLCD.c,58 :: 		for(; i < 4; i++)
L_main3:
	MOVLW       4
	SUBWF       main_i_L1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main4
;calculadoraLCD.c,60 :: 		PORTA = ~(1 << i); // varredura
	MOVF        main_i_L1+0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__main9:
	BZ          L__main10
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__main9
L__main10:
	COMF        R0, 0 
	MOVWF       PORTA+0 
;calculadoraLCD.c,58 :: 		for(; i < 4; i++)
	INCF        main_i_L1+0, 1 
;calculadoraLCD.c,61 :: 		}
	GOTO        L_main3
L_main4:
;calculadoraLCD.c,62 :: 		}
	GOTO        L_main1
;calculadoraLCD.c,63 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
