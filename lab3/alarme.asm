
_interrupt:

;alarme.c,64 :: 		void interrupt(void)
;alarme.c,66 :: 		if(INTCON3.INT1IF)
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt0
;alarme.c,70 :: 		keypadHandler();
	CALL        _keypadHandler+0, 0
;alarme.c,71 :: 		canTypeAgain = 0;
	CLRF        _canTypeAgain+0 
	CLRF        _canTypeAgain+1 
;alarme.c,74 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;alarme.c,75 :: 		}
L_interrupt0:
;alarme.c,94 :: 		}
L_end_interrupt:
L__interrupt78:
	RETFIE      1
; end of _interrupt

_main:

;alarme.c,96 :: 		void main()
;alarme.c,99 :: 		ADCON1 = 0x04;
	MOVLW       4
	MOVWF       ADCON1+0 
;alarme.c,102 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;alarme.c,105 :: 		T0CON.T08BIT = 0;       // 16 bits
	BCF         T0CON+0, 6 
;alarme.c,106 :: 		T0CON.T0CS = 0;         // Internal clock => Crystal/4
	BCF         T0CON+0, 5 
;alarme.c,107 :: 		T0CON.PSA = 0;          // Prescaler ON
	BCF         T0CON+0, 3 
;alarme.c,109 :: 		T0CON.T0PS2 = 1;
	BSF         T0CON+0, 2 
;alarme.c,110 :: 		T0CON.T0PS1 = 1;
	BSF         T0CON+0, 1 
;alarme.c,111 :: 		T0CON.T0PS0 = 1;
	BSF         T0CON+0, 0 
;alarme.c,113 :: 		TMR0H = COUNTER >> 8;  // Load Timer 0 counter - 1st TMR0H
	MOVLW       255
	MOVWF       TMR0H+0 
;alarme.c,114 :: 		TMR0L = COUNTER;       // Load Timer 0 counter - 2nd TMR0L
	MOVLW       55
	MOVWF       TMR0L+0 
;alarme.c,117 :: 		INTCON2.TMR0IP=0;
	BCF         INTCON2+0, 2 
;alarme.c,118 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;alarme.c,119 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;alarme.c,120 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;alarme.c,122 :: 		T0CON.TMR0ON=1;
	BSF         T0CON+0, 7 
;alarme.c,125 :: 		INTCON3.INT1IP = 1;
	BSF         INTCON3+0, 6 
;alarme.c,126 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;alarme.c,127 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;alarme.c,130 :: 		TRISB.RB1 = 1;
	BSF         TRISB+0, 1 
;alarme.c,134 :: 		TRISC.RC4 = 1;
	BSF         TRISC+0, 4 
;alarme.c,135 :: 		TRISC.RC5 = 1;
	BSF         TRISC+0, 5 
;alarme.c,136 :: 		TRISC.RC6 = 1;
	BSF         TRISC+0, 6 
;alarme.c,137 :: 		TRISC.RC7 = 1;
	BSF         TRISC+0, 7 
;alarme.c,139 :: 		TRISA.RA0 = 1;
	BSF         TRISA+0, 0 
;alarme.c,140 :: 		TRISA.RA1 = 1;
	BSF         TRISA+0, 1 
;alarme.c,144 :: 		TRISB.RB4 = 0;
	BCF         TRISB+0, 4 
;alarme.c,145 :: 		TRISB.RB5 = 0;
	BCF         TRISB+0, 5 
;alarme.c,146 :: 		TRISB.RB6 = 0;
	BCF         TRISB+0, 6 
;alarme.c,147 :: 		TRISB.RB7 = 0;
	BCF         TRISB+0, 7 
;alarme.c,149 :: 		PORTB.RB4 = 0;
	BCF         PORTB+0, 4 
;alarme.c,150 :: 		PORTB.RB5 = 0;
	BCF         PORTB+0, 5 
;alarme.c,151 :: 		PORTB.RB6 = 0;
	BCF         PORTB+0, 6 
;alarme.c,152 :: 		PORTB.RB7 = 0;
	BCF         PORTB+0, 7 
;alarme.c,156 :: 		TRISA.RA2 = 1;
	BSF         TRISA+0, 2 
;alarme.c,157 :: 		TRISA.RA3 = 1;
	BSF         TRISA+0, 3 
;alarme.c,158 :: 		TRISA.RA5 = 1;
	BSF         TRISA+0, 5 
;alarme.c,159 :: 		TRISB.RB3 = 1;
	BSF         TRISB+0, 3 
;alarme.c,162 :: 		TRISC.RC0 = 0;
	BCF         TRISC+0, 0 
;alarme.c,163 :: 		TRISC.RC1 = 0;
	BCF         TRISC+0, 1 
;alarme.c,164 :: 		TRISC.RC2 = 0;
	BCF         TRISC+0, 2 
;alarme.c,165 :: 		TRISC.RC3 = 0;
	BCF         TRISC+0, 3 
;alarme.c,167 :: 		PORTC.RC0 = 0;
	BCF         PORTC+0, 0 
;alarme.c,168 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;alarme.c,169 :: 		PORTC.RC2 = 0;
	BCF         PORTC+0, 2 
;alarme.c,170 :: 		PORTC.RC3 = 0;
	BCF         PORTC+0, 3 
;alarme.c,171 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_alarm:

;alarme.c,174 :: 		void alarm()
;alarme.c,176 :: 		vSensor1 = (ADC_read(0)/1023.0) * 5;
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _Word2Double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       192
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _vSensor1+0 
	MOVF        R1, 0 
	MOVWF       _vSensor1+1 
	MOVF        R2, 0 
	MOVWF       _vSensor1+2 
	MOVF        R3, 0 
	MOVWF       _vSensor1+3 
;alarme.c,177 :: 		vSensor2 = (ADC_read(1)/1023.0) * 5;
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _Word2Double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       192
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _vSensor2+0 
	MOVF        R1, 0 
	MOVWF       _vSensor2+1 
	MOVF        R2, 0 
	MOVWF       _vSensor2+2 
	MOVF        R3, 0 
	MOVWF       _vSensor2+3 
;alarme.c,178 :: 		if(isOn)
	MOVF        _isOn+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm2
;alarme.c,180 :: 		char activated = 0;
;alarme.c,181 :: 		int sensorCount = 0;
	CLRF        alarm_sensorCount_L1+0 
	CLRF        alarm_sensorCount_L1+1 
;alarme.c,184 :: 		PORTC.RC0 = PORTC.RC4;
	BTFSC       PORTC+0, 4 
	GOTO        L__alarm81
	BCF         PORTC+0, 0 
	GOTO        L__alarm82
L__alarm81:
	BSF         PORTC+0, 0 
L__alarm82:
;alarme.c,185 :: 		PORTC.RC1 = PORTC.RC5;
	BTFSC       PORTC+0, 5 
	GOTO        L__alarm83
	BCF         PORTC+0, 1 
	GOTO        L__alarm84
L__alarm83:
	BSF         PORTC+0, 1 
L__alarm84:
;alarme.c,186 :: 		PORTC.RC2 = PORTC.RC6;
	BTFSC       PORTC+0, 6 
	GOTO        L__alarm85
	BCF         PORTC+0, 2 
	GOTO        L__alarm86
L__alarm85:
	BSF         PORTC+0, 2 
L__alarm86:
;alarme.c,187 :: 		PORTC.RC3 = PORTC.RC7;
	BTFSC       PORTC+0, 7 
	GOTO        L__alarm87
	BCF         PORTC+0, 3 
	GOTO        L__alarm88
L__alarm87:
	BSF         PORTC+0, 3 
L__alarm88:
;alarme.c,189 :: 		sensorCount += PORTC.RC4;
	CLRF        R0 
	BTFSC       PORTC+0, 4 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,190 :: 		sensorCount += PORTC.RC5;
	CLRF        R0 
	BTFSC       PORTC+0, 5 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,191 :: 		sensorCount += PORTC.RC6;
	CLRF        R0 
	BTFSC       PORTC+0, 6 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,192 :: 		sensorCount += PORTC.RC7;
	CLRF        R0 
	BTFSC       PORTC+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,193 :: 		sensorCount += vSensor1 >= 4 ? 1 : 0;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	MOVF        _vSensor1+0, 0 
	MOVWF       R0 
	MOVF        _vSensor1+1, 0 
	MOVWF       R1 
	MOVF        _vSensor1+2, 0 
	MOVWF       R2 
	MOVF        _vSensor1+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm3
	MOVLW       1
	MOVWF       R0 
	GOTO        L_alarm4
L_alarm3:
	CLRF        R0 
L_alarm4:
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,194 :: 		sensorCount += vSensor2 > 3 ? 1 : 0;
	MOVF        _vSensor2+0, 0 
	MOVWF       R4 
	MOVF        _vSensor2+1, 0 
	MOVWF       R5 
	MOVF        _vSensor2+2, 0 
	MOVWF       R6 
	MOVF        _vSensor2+3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       64
	MOVWF       R2 
	MOVLW       128
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm5
	MOVLW       1
	MOVWF       R0 
	GOTO        L_alarm6
L_alarm5:
	CLRF        R0 
L_alarm6:
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      alarm_sensorCount_L1+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       alarm_sensorCount_L1+0 
	MOVF        R2, 0 
	MOVWF       alarm_sensorCount_L1+1 
;alarme.c,196 :: 		activated = sensorCount >= 2 ? 1 : 0;
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__alarm89
	MOVLW       2
	SUBWF       R1, 0 
L__alarm89:
	BTFSS       STATUS+0, 0 
	GOTO        L_alarm7
	MOVLW       1
	MOVWF       R0 
	GOTO        L_alarm8
L_alarm7:
	CLRF        R0 
L_alarm8:
;alarme.c,198 :: 		if(activated)
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm9
;alarme.c,202 :: 		IntToStr(sensorCount, number);
	MOVF        alarm_sensorCount_L1+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        alarm_sensorCount_L1+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       alarm_number_L2+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(alarm_number_L2+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;alarme.c,204 :: 		strcat(str, msg1);
	MOVLW       alarm_str_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _msg1+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_msg1+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,205 :: 		strcat(str, number);
	MOVLW       alarm_str_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       alarm_number_L2+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(alarm_number_L2+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,206 :: 		strcat(str, msg2);
	MOVLW       alarm_str_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _msg2+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_msg2+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,208 :: 		if(strcmp(lastText, str))
	MOVLW       _lastText+0
	MOVWF       FARG_strcmp_s1+0 
	MOVLW       hi_addr(_lastText+0)
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       alarm_str_L2+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm10
;alarme.c,210 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;alarme.c,211 :: 		strcpy(lastText, str);
	MOVLW       _lastText+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_lastText+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       alarm_str_L2+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;alarme.c,213 :: 		Lcd_Out(1,1,str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       alarm_str_L2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,214 :: 		}
L_alarm10:
;alarme.c,215 :: 		}
	GOTO        L_alarm11
L_alarm9:
;alarme.c,221 :: 		if(PORTC.RC4)
	BTFSS       PORTC+0, 4 
	GOTO        L_alarm12
;alarme.c,222 :: 		strcpy(number, "1");
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr1_alarme+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr1_alarme+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
L_alarm12:
;alarme.c,224 :: 		if(PORTC.RC5)
	BTFSS       PORTC+0, 5 
	GOTO        L_alarm13
;alarme.c,225 :: 		strcpy(number, "2");
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr2_alarme+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr2_alarme+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
L_alarm13:
;alarme.c,227 :: 		if(PORTC.RC6)
	BTFSS       PORTC+0, 6 
	GOTO        L_alarm14
;alarme.c,228 :: 		strcpy(number, "3");
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr3_alarme+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr3_alarme+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
L_alarm14:
;alarme.c,230 :: 		if(PORTC.RC7)
	BTFSS       PORTC+0, 7 
	GOTO        L_alarm15
;alarme.c,231 :: 		strcpy(number, "4");
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr4_alarme+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr4_alarme+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
L_alarm15:
;alarme.c,233 :: 		if(vSensor1 >= 4)
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	MOVF        _vSensor1+0, 0 
	MOVWF       R0 
	MOVF        _vSensor1+1, 0 
	MOVWF       R1 
	MOVF        _vSensor1+2, 0 
	MOVWF       R2 
	MOVF        _vSensor1+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm16
;alarme.c,234 :: 		strcpy(number, "5");
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr5_alarme+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr5_alarme+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
L_alarm16:
;alarme.c,236 :: 		if(vSensor2 > 3)
	MOVF        _vSensor2+0, 0 
	MOVWF       R4 
	MOVF        _vSensor2+1, 0 
	MOVWF       R5 
	MOVF        _vSensor2+2, 0 
	MOVWF       R6 
	MOVF        _vSensor2+3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       64
	MOVWF       R2 
	MOVLW       128
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm17
;alarme.c,237 :: 		strcpy(number, "6");
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr6_alarme+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr6_alarme+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
L_alarm17:
;alarme.c,240 :: 		strcat(str, msg3);
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _msg3+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_msg3+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,241 :: 		strcat(str, number);
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,242 :: 		strcat(str, msg4);
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _msg4+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_msg4+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,244 :: 		if(strcmp(lastText, str))
	MOVLW       _lastText+0
	MOVWF       FARG_strcmp_s1+0 
	MOVLW       hi_addr(_lastText+0)
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm18
;alarme.c,246 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;alarme.c,247 :: 		strcpy(lastText, str);
	MOVLW       _lastText+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_lastText+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;alarme.c,249 :: 		Lcd_Out(1,1,str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,250 :: 		}
L_alarm18:
;alarme.c,251 :: 		}
L_alarm11:
;alarme.c,252 :: 		}
	GOTO        L_alarm19
L_alarm2:
;alarme.c,260 :: 		IntToStr(vSensor1, str1);
	MOVF        _vSensor1+0, 0 
	MOVWF       R0 
	MOVF        _vSensor1+1, 0 
	MOVWF       R1 
	MOVF        _vSensor1+2, 0 
	MOVWF       R2 
	MOVF        _vSensor1+3, 0 
	MOVWF       R3 
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       alarm_str1_L1+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(alarm_str1_L1+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;alarme.c,261 :: 		IntToStr(vSensor2, str2);
	MOVF        _vSensor2+0, 0 
	MOVWF       R0 
	MOVF        _vSensor2+1, 0 
	MOVWF       R1 
	MOVF        _vSensor2+2, 0 
	MOVWF       R2 
	MOVF        _vSensor2+3, 0 
	MOVWF       R3 
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       alarm_str2_L1+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(alarm_str2_L1+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;alarme.c,263 :: 		strcat(str, str1);
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       alarm_str1_L1+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(alarm_str1_L1+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,264 :: 		strcat(str, "V ");
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr7_alarme+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr7_alarme+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,265 :: 		strcat(str, str2);
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       alarm_str2_L1+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(alarm_str2_L1+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,266 :: 		strcat(str, "V");
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr8_alarme+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr8_alarme+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,268 :: 		if(strcmp(lastText, str))
	MOVLW       _lastText+0
	MOVWF       FARG_strcmp_s1+0 
	MOVLW       hi_addr(_lastText+0)
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm20
;alarme.c,270 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;alarme.c,271 :: 		strcpy(lastText, str);
	MOVLW       _lastText+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_lastText+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;alarme.c,273 :: 		Lcd_Out(1,1,str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,274 :: 		}
L_alarm20:
;alarme.c,275 :: 		}
L_alarm19:
;alarme.c,276 :: 		}
L_end_alarm:
	RETURN      0
; end of _alarm

_keypadHandler:

;alarme.c,279 :: 		void keypadHandler()
;alarme.c,285 :: 		int rowCode = 0;
	CLRF        keypadHandler_rowCode_L0+0 
	CLRF        keypadHandler_rowCode_L0+1 
;alarme.c,288 :: 		for(i = 0; (i < 4) && PORTB.RB1 == 0; i++)
	CLRF        keypadHandler_i_L0+0 
L_keypadHandler21:
	MOVLW       4
	SUBWF       keypadHandler_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadHandler22
	BTFSC       PORTB+0, 1 
	GOTO        L_keypadHandler22
L__keypadHandler76:
;alarme.c,290 :: 		PORTB.RB4 = 1;
	BSF         PORTB+0, 4 
;alarme.c,291 :: 		PORTB.RB5 = 1;
	BSF         PORTB+0, 5 
;alarme.c,292 :: 		PORTB.RB6 = 1;
	BSF         PORTB+0, 6 
;alarme.c,293 :: 		PORTB.RB7 = 1;
	BSF         PORTB+0, 7 
;alarme.c,294 :: 		if(i==0)PORTB.RB4 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler26
	BCF         PORTB+0, 4 
L_keypadHandler26:
;alarme.c,295 :: 		if(i==1)PORTB.RB5 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler27
	BCF         PORTB+0, 5 
L_keypadHandler27:
;alarme.c,296 :: 		if(i==2)PORTB.RB6 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler28
	BCF         PORTB+0, 6 
L_keypadHandler28:
;alarme.c,297 :: 		if(i==3)PORTB.RB7 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler29
	BCF         PORTB+0, 7 
L_keypadHandler29:
;alarme.c,298 :: 		columnCode = PORTA.RA2 | PORTA.RA3 << 1 |
	CLRF        R2 
	BTFSC       PORTA+0, 3 
	INCF        R2, 1 
	MOVF        R2, 0 
	MOVWF       R1 
	RLCF        R1, 1 
	BCF         R1, 0 
	CLRF        R0 
	BTFSC       PORTA+0, 2 
	INCF        R0, 1 
	MOVF        R1, 0 
	IORWF       R0, 0 
	MOVWF       R4 
;alarme.c,299 :: 		PORTA.RA5 << 2 | PORTB.RB3 << 3;
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
	IORWF       R4, 1 
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
L__keypadHandler91:
	BZ          L__keypadHandler92
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__keypadHandler91
L__keypadHandler92:
	MOVF        R0, 0 
	IORWF       R4, 0 
	MOVWF       _columnCode+0 
;alarme.c,288 :: 		for(i = 0; (i < 4) && PORTB.RB1 == 0; i++)
	INCF        keypadHandler_i_L0+0, 1 
;alarme.c,300 :: 		}
	GOTO        L_keypadHandler21
L_keypadHandler22:
;alarme.c,301 :: 		rowCode = PORTB >> 4;
	MOVLW       4
	MOVWF       R0 
	MOVF        PORTB+0, 0 
	MOVWF       keypadHandler_rowCode_L0+0 
	MOVLW       0
	MOVWF       keypadHandler_rowCode_L0+1 
	MOVF        R0, 0 
L__keypadHandler93:
	BZ          L__keypadHandler94
	RRCF        keypadHandler_rowCode_L0+0, 1 
	BCF         keypadHandler_rowCode_L0+0, 7 
	ADDLW       255
	GOTO        L__keypadHandler93
L__keypadHandler94:
	MOVLW       0
	MOVWF       keypadHandler_rowCode_L0+1 
;alarme.c,302 :: 		realCode = rowCode | columnCode << 4;
	MOVLW       4
	MOVWF       R2 
	MOVF        _columnCode+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__keypadHandler95:
	BZ          L__keypadHandler96
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__keypadHandler95
L__keypadHandler96:
	MOVF        R0, 0 
	IORWF       keypadHandler_rowCode_L0+0, 0 
	MOVWF       FARG_keyHandler_key+0 
	MOVF        keypadHandler_rowCode_L0+1, 0 
	IORWF       R1, 0 
	MOVWF       FARG_keyHandler_key+1 
;alarme.c,303 :: 		result = keyHandler(realCode, &type);
	MOVLW       keypadHandler_type_L0+0
	MOVWF       FARG_keyHandler_type+0 
	MOVLW       hi_addr(keypadHandler_type_L0+0)
	MOVWF       FARG_keyHandler_type+1 
	CALL        _keyHandler+0, 0
	MOVF        R0, 0 
	MOVWF       keypadHandler_result_L0+0 
	MOVF        R1, 0 
	MOVWF       keypadHandler_result_L0+1 
;alarme.c,306 :: 		PORTB.RB4 = 0;
	BCF         PORTB+0, 4 
;alarme.c,307 :: 		PORTB.RB5 = 0;
	BCF         PORTB+0, 5 
;alarme.c,308 :: 		PORTB.RB6 = 0;
	BCF         PORTB+0, 6 
;alarme.c,309 :: 		PORTB.RB7 = 0;
	BCF         PORTB+0, 7 
;alarme.c,311 :: 		if(edge == 1)
	MOVF        _edge+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler30
;alarme.c,313 :: 		if(type == NUM)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler31
;alarme.c,315 :: 		if(result == 0)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler97
	MOVLW       0
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler97:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler32
;alarme.c,316 :: 		keyPressed[0] = '0';
	MOVLW       48
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler32:
;alarme.c,318 :: 		if(result == 1)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler98
	MOVLW       1
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler98:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler33
;alarme.c,319 :: 		keyPressed[0] = '1';
	MOVLW       49
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler33:
;alarme.c,321 :: 		if(result == 2)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler99
	MOVLW       2
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler99:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler34
;alarme.c,322 :: 		keyPressed[0] = '2';
	MOVLW       50
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler34:
;alarme.c,324 :: 		if(result == 3)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler100
	MOVLW       3
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler100:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler35
;alarme.c,325 :: 		keyPressed[0] = '3';
	MOVLW       51
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler35:
;alarme.c,327 :: 		if(result == 4)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler101
	MOVLW       4
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler101:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler36
;alarme.c,328 :: 		keyPressed[0] = '4';
	MOVLW       52
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler36:
;alarme.c,330 :: 		if(result == 5)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler102
	MOVLW       5
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler102:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler37
;alarme.c,331 :: 		keyPressed[0] = '5';
	MOVLW       53
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler37:
;alarme.c,333 :: 		if(result == 6)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler103
	MOVLW       6
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler103:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler38
;alarme.c,334 :: 		keyPressed[0] = '6';
	MOVLW       54
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler38:
;alarme.c,336 :: 		if(result == 7)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler104
	MOVLW       7
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler104:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler39
;alarme.c,337 :: 		keyPressed[0] = '7';
	MOVLW       55
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler39:
;alarme.c,339 :: 		if(result == 8)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler105
	MOVLW       8
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler105:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler40
;alarme.c,340 :: 		keyPressed[0] = '8';
	MOVLW       56
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler40:
;alarme.c,342 :: 		if(result == 9)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler106
	MOVLW       9
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler106:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler41
;alarme.c,343 :: 		keyPressed[0] = '9';
	MOVLW       57
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler41:
;alarme.c,344 :: 		}
L_keypadHandler31:
;alarme.c,346 :: 		if(type == SUM)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler42
;alarme.c,347 :: 		keyPressed[0] = '+';
	MOVLW       43
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler42:
;alarme.c,349 :: 		if(type == SUB)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler43
;alarme.c,350 :: 		keyPressed[0] = '-';
	MOVLW       45
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler43:
;alarme.c,352 :: 		if(type == MULT)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler44
;alarme.c,353 :: 		keyPressed[0] = '*';
	MOVLW       42
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler44:
;alarme.c,355 :: 		if(type == DIVI)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler45
;alarme.c,356 :: 		keyPressed[0] = '/';
	MOVLW       47
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler45:
;alarme.c,358 :: 		keyPressed[1] = '\0';
	CLRF        keypadHandler_keyPressed_L0+1 
;alarme.c,360 :: 		IntToStr(columnCode, lastText);
	MOVF        _columnCode+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _lastText+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_lastText+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;alarme.c,362 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;alarme.c,363 :: 		Lcd_Out(1,1,"oi");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_alarme+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_alarme+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,365 :: 		rightKeysActivation[nKeyPressed] = (activationCode[nKeyPressed] != keyPressed[0]) == 0 ? 1 : 0;
	MOVLW       _rightKeysActivation+0
	MOVWF       R2 
	MOVLW       hi_addr(_rightKeysActivation+0)
	MOVWF       R3 
	MOVF        _nKeyPressed+0, 0 
	ADDWF       R2, 1 
	BTFSC       STATUS+0, 0 
	INCF        R3, 1 
	MOVLW       _activationCode+0
	ADDWF       _nKeyPressed+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_activationCode+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_activationCode+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	XORWF       keypadHandler_keyPressed_L0+0, 0 
	MOVLW       0
	BTFSS       STATUS+0, 2 
	MOVLW       1
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler46
	MOVLW       1
	MOVWF       R0 
	GOTO        L_keypadHandler47
L_keypadHandler46:
	CLRF        R0 
L_keypadHandler47:
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;alarme.c,366 :: 		rightKeysDeActivation[nKeyPressed] = (DeActivationCode[nKeyPressed] != keyPressed[0]) == 0 ? 1 : 0;
	MOVLW       _rightKeysDeActivation+0
	MOVWF       R2 
	MOVLW       hi_addr(_rightKeysDeActivation+0)
	MOVWF       R3 
	MOVF        _nKeyPressed+0, 0 
	ADDWF       R2, 1 
	BTFSC       STATUS+0, 0 
	INCF        R3, 1 
	MOVLW       _deActivationCode+0
	ADDWF       _nKeyPressed+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_deActivationCode+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_deActivationCode+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	XORWF       keypadHandler_keyPressed_L0+0, 0 
	MOVLW       0
	BTFSS       STATUS+0, 2 
	MOVLW       1
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler48
	MOVLW       1
	MOVWF       R0 
	GOTO        L_keypadHandler49
L_keypadHandler48:
	CLRF        R0 
L_keypadHandler49:
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;alarme.c,368 :: 		if(nKeyPressed == 6)
	MOVF        _nKeyPressed+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler50
;alarme.c,371 :: 		char activationCounter = 0;
	CLRF        keypadHandler_activationCounter_L2+0 
	CLRF        keypadHandler_deActivationCounter_L2+0 
;alarme.c,373 :: 		for(i = 0; i < nKeyPressed; i++)
	CLRF        keypadHandler_i_L2+0 
	CLRF        keypadHandler_i_L2+1 
L_keypadHandler51:
	MOVLW       128
	XORWF       keypadHandler_i_L2+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler107
	MOVF        _nKeyPressed+0, 0 
	SUBWF       keypadHandler_i_L2+0, 0 
L__keypadHandler107:
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadHandler52
;alarme.c,375 :: 		activationCounter += rightKeysActivation[i];
	MOVLW       _rightKeysActivation+0
	ADDWF       keypadHandler_i_L2+0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_rightKeysActivation+0)
	ADDWFC      keypadHandler_i_L2+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       keypadHandler_activationCounter_L2+0, 1 
;alarme.c,376 :: 		deActivationCounter += rightKeysDeActivation[i];
	MOVLW       _rightKeysDeActivation+0
	ADDWF       keypadHandler_i_L2+0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_rightKeysDeActivation+0)
	ADDWFC      keypadHandler_i_L2+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       keypadHandler_deActivationCounter_L2+0, 1 
;alarme.c,373 :: 		for(i = 0; i < nKeyPressed; i++)
	INFSNZ      keypadHandler_i_L2+0, 1 
	INCF        keypadHandler_i_L2+1, 1 
;alarme.c,377 :: 		}
	GOTO        L_keypadHandler51
L_keypadHandler52:
;alarme.c,379 :: 		if(activationCounter == 6)
	MOVF        keypadHandler_activationCounter_L2+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler54
;alarme.c,381 :: 		isOn = 1;
	MOVLW       1
	MOVWF       _isOn+0 
;alarme.c,382 :: 		}
L_keypadHandler54:
;alarme.c,384 :: 		if(deActivationCounter == 6)
	MOVF        keypadHandler_deActivationCounter_L2+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler55
;alarme.c,386 :: 		isOn = 0;
	CLRF        _isOn+0 
;alarme.c,387 :: 		}
L_keypadHandler55:
;alarme.c,388 :: 		}
L_keypadHandler50:
;alarme.c,390 :: 		nKeyPressed = nKeyPressed == 6 ? 0 : nKeyPressed++;
	MOVF        _nKeyPressed+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler56
	CLRF        R2 
	GOTO        L_keypadHandler57
L_keypadHandler56:
	MOVF        _nKeyPressed+0, 0 
	MOVWF       R1 
	MOVF        _nKeyPressed+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _nKeyPressed+0 
	MOVF        R1, 0 
	MOVWF       R2 
L_keypadHandler57:
	MOVF        R2, 0 
	MOVWF       _nKeyPressed+0 
;alarme.c,391 :: 		}
L_keypadHandler30:
;alarme.c,392 :: 		}
L_end_keypadHandler:
	RETURN      0
; end of _keypadHandler

_keyHandler:

;alarme.c,395 :: 		int keyHandler (int key, KeyType* type)
;alarme.c,397 :: 		int result = -1;
	MOVLW       255
	MOVWF       keyHandler_result_L0+0 
	MOVLW       255
	MOVWF       keyHandler_result_L0+1 
;alarme.c,398 :: 		switch(key)
	GOTO        L_keyHandler58
;alarme.c,400 :: 		case 231:
L_keyHandler60:
;alarme.c,401 :: 		*type = ON_CLEAR;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       5
	MOVWF       POSTINC1+0 
;alarme.c,402 :: 		break;
	GOTO        L_keyHandler59
;alarme.c,404 :: 		case 215:
L_keyHandler61:
;alarme.c,405 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,406 :: 		result = 0;
	CLRF        keyHandler_result_L0+0 
	CLRF        keyHandler_result_L0+1 
;alarme.c,407 :: 		break;
	GOTO        L_keyHandler59
;alarme.c,409 :: 		case 183:
L_keyHandler62:
;alarme.c,410 :: 		*type = EQUALS;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	CLRF        POSTINC1+0 
;alarme.c,411 :: 		break;
	GOTO        L_keyHandler59
;alarme.c,413 :: 		case 119:
L_keyHandler63:
;alarme.c,414 :: 		*type = SUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
;alarme.c,415 :: 		break;
	GOTO        L_keyHandler59
;alarme.c,417 :: 		case 235:
L_keyHandler64:
;alarme.c,418 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,419 :: 		result = 7;
	MOVLW       7
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,420 :: 		break;
	GOTO        L_keyHandler59
;alarme.c,422 :: 		case 219:
L_keyHandler65:
;alarme.c,423 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,424 :: 		result = 8;
	MOVLW       8
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,425 :: 		break;
	GOTO        L_keyHandler59
;alarme.c,427 :: 		case 187:
L_keyHandler66:
;alarme.c,428 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,429 :: 		result = 9;
	MOVLW       9
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,430 :: 		break;
	GOTO        L_keyHandler59
;alarme.c,432 :: 		case 123:
L_keyHandler67:
;alarme.c,433 :: 		*type = SUB;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       2
	MOVWF       POSTINC1+0 
;alarme.c,434 :: 		break;
	GOTO        L_keyHandler59
;alarme.c,436 :: 		case 237:
L_keyHandler68:
;alarme.c,437 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,438 :: 		result = 4;
	MOVLW       4
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,439 :: 		break;
	GOTO        L_keyHandler59
;alarme.c,441 :: 		case 221:
L_keyHandler69:
;alarme.c,442 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,443 :: 		result = 5;
	MOVLW       5
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,444 :: 		break;
	GOTO        L_keyHandler59
;alarme.c,446 :: 		case 189:
L_keyHandler70:
;alarme.c,447 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,448 :: 		result = 6;
	MOVLW       6
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,449 :: 		break;
	GOTO        L_keyHandler59
;alarme.c,451 :: 		case 125:
L_keyHandler71:
;alarme.c,452 :: 		*type = MULT;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       3
	MOVWF       POSTINC1+0 
;alarme.c,453 :: 		break;
	GOTO        L_keyHandler59
;alarme.c,455 :: 		case 238:
L_keyHandler72:
;alarme.c,456 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,457 :: 		result = 1;
	MOVLW       1
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,458 :: 		break;
	GOTO        L_keyHandler59
;alarme.c,460 :: 		case 222:
L_keyHandler73:
;alarme.c,461 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,462 :: 		result = 2;
	MOVLW       2
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,463 :: 		break;
	GOTO        L_keyHandler59
;alarme.c,465 :: 		case 190:
L_keyHandler74:
;alarme.c,466 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,467 :: 		result = 3;
	MOVLW       3
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,468 :: 		break;
	GOTO        L_keyHandler59
;alarme.c,470 :: 		case 126:
L_keyHandler75:
;alarme.c,471 :: 		*type = DIVI;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       4
	MOVWF       POSTINC1+0 
;alarme.c,472 :: 		break;
	GOTO        L_keyHandler59
;alarme.c,473 :: 		}
L_keyHandler58:
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler109
	MOVLW       231
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler109:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler60
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler110
	MOVLW       215
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler110:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler61
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler111
	MOVLW       183
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler111:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler62
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler112
	MOVLW       119
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler112:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler63
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler113
	MOVLW       235
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler113:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler64
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler114
	MOVLW       219
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler114:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler65
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler115
	MOVLW       187
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler115:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler66
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler116
	MOVLW       123
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler116:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler67
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler117
	MOVLW       237
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler117:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler68
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler118
	MOVLW       221
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler118:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler69
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler119
	MOVLW       189
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler119:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler70
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler120
	MOVLW       125
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler120:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler71
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler121
	MOVLW       238
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler121:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler72
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler122
	MOVLW       222
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler122:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler73
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler123
	MOVLW       190
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler123:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler74
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler124
	MOVLW       126
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler124:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler75
L_keyHandler59:
;alarme.c,475 :: 		return result;
	MOVF        keyHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keyHandler_result_L0+1, 0 
	MOVWF       R1 
;alarme.c,476 :: 		}
L_end_keyHandler:
	RETURN      0
; end of _keyHandler
