
_main:

;motor.c,4 :: 		void main(void)
;motor.c,7 :: 		adcon1 = 0x04;
	MOVLW       4
	MOVWF       ADCON1+0 
;motor.c,10 :: 		trisa.an0 = 1;
	BSF         TRISA+0, 0 
;motor.c,13 :: 		PWM1_Init(5000);
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       99
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;motor.c,14 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;motor.c,16 :: 		while(1)
L_main0:
;motor.c,19 :: 		percent = ADC_Read(0)/1023.0;
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       192
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _percent+0 
	MOVF        R1, 0 
	MOVWF       _percent+1 
	MOVF        R2, 0 
	MOVWF       _percent+2 
	MOVF        R3, 0 
	MOVWF       _percent+3 
;motor.c,20 :: 		duty = percent*255;
	MOVF        _percent+0, 0 
	MOVWF       R0 
	MOVF        _percent+1, 0 
	MOVWF       R1 
	MOVF        _percent+2, 0 
	MOVWF       R2 
	MOVF        _percent+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       134
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2byte+0, 0
	MOVF        R0, 0 
	MOVWF       _duty+0 
;motor.c,21 :: 		PWM1_Set_Duty(duty);
	MOVF        _duty+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;motor.c,24 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
;motor.c,25 :: 		}
	GOTO        L_main0
;motor.c,27 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
