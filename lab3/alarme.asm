
_interrupt:

;alarme.c,56 :: 		void interrupt(void)
;alarme.c,58 :: 		if(INTCON3.INT1IF)
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt0
;alarme.c,60 :: 		keypadHandler();
	CALL        _keypadHandler+0, 0
;alarme.c,63 :: 		TMR0H = COUNTER >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       255
	MOVWF       TMR0H+0 
;alarme.c,64 :: 		TMR0L = COUNTER;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       55
	MOVWF       TMR0L+0 
;alarme.c,65 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;alarme.c,66 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;alarme.c,67 :: 		T0CON.TMR0ON=1;
	BSF         T0CON+0, 7 
;alarme.c,70 :: 		INTCON3.INT1IE = 0;
	BCF         INTCON3+0, 3 
;alarme.c,71 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;alarme.c,72 :: 		}
	GOTO        L_interrupt1
L_interrupt0:
;alarme.c,73 :: 		else if(INTCON.TMR0IF) // Related to bouncing
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt2
;alarme.c,76 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;alarme.c,77 :: 		INTCON.TMR0IE=0;
	BCF         INTCON+0, 5 
;alarme.c,78 :: 		T0CON.TMR0ON=0;
	BCF         T0CON+0, 7 
;alarme.c,81 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;alarme.c,82 :: 		}
L_interrupt2:
L_interrupt1:
;alarme.c,90 :: 		}
L_end_interrupt:
L__interrupt71:
	RETFIE      1
; end of _interrupt

_main:

;alarme.c,92 :: 		void main()
;alarme.c,95 :: 		ADCON1 = 0x04;
	MOVLW       4
	MOVWF       ADCON1+0 
;alarme.c,98 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;alarme.c,101 :: 		T0CON.T08BIT = 0;       // 16 bits
	BCF         T0CON+0, 6 
;alarme.c,102 :: 		T0CON.T0CS = 0;         // Internal clock => Crystal/4
	BCF         T0CON+0, 5 
;alarme.c,103 :: 		T0CON.PSA = 0;          // Prescaler ON
	BCF         T0CON+0, 3 
;alarme.c,105 :: 		T0CON.T0PS2 = 1;
	BSF         T0CON+0, 2 
;alarme.c,106 :: 		T0CON.T0PS1 = 1;
	BSF         T0CON+0, 1 
;alarme.c,107 :: 		T0CON.T0PS0 = 1;
	BSF         T0CON+0, 0 
;alarme.c,110 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;alarme.c,111 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;alarme.c,112 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;alarme.c,115 :: 		TRISB.RB1 = 1;
	BSF         TRISB+0, 1 
;alarme.c,119 :: 		TRISC.RC4 = 1;
	BSF         TRISC+0, 4 
;alarme.c,120 :: 		TRISC.RC5 = 1;
	BSF         TRISC+0, 5 
;alarme.c,121 :: 		TRISC.RC6 = 1;
	BSF         TRISC+0, 6 
;alarme.c,122 :: 		TRISC.RC7 = 1;
	BSF         TRISC+0, 7 
;alarme.c,124 :: 		TRISA.RA0 = 1;
	BSF         TRISA+0, 0 
;alarme.c,125 :: 		TRISA.RA1 = 1;
	BSF         TRISA+0, 1 
;alarme.c,129 :: 		TRISB.RB4 = 0;
	BCF         TRISB+0, 4 
;alarme.c,130 :: 		TRISB.RB5 = 0;
	BCF         TRISB+0, 5 
;alarme.c,131 :: 		TRISB.RB6 = 0;
	BCF         TRISB+0, 6 
;alarme.c,132 :: 		TRISB.RB7 = 0;
	BCF         TRISB+0, 7 
;alarme.c,134 :: 		PORTB.RB4 = 0;
	BCF         PORTB+0, 4 
;alarme.c,135 :: 		PORTB.RB5 = 0;
	BCF         PORTB+0, 5 
;alarme.c,136 :: 		PORTB.RB6 = 0;
	BCF         PORTB+0, 6 
;alarme.c,137 :: 		PORTB.RB7 = 0;
	BCF         PORTB+0, 7 
;alarme.c,141 :: 		TRISA.RA2 = 1;
	BSF         TRISA+0, 2 
;alarme.c,142 :: 		TRISA.RA3 = 1;
	BSF         TRISA+0, 3 
;alarme.c,143 :: 		TRISA.RA5 = 1;
	BSF         TRISA+0, 5 
;alarme.c,144 :: 		TRISB.RB3 = 1;
	BSF         TRISB+0, 3 
;alarme.c,147 :: 		TRISC.RC0 = 0;
	BCF         TRISC+0, 0 
;alarme.c,148 :: 		TRISC.RC1 = 0;
	BCF         TRISC+0, 1 
;alarme.c,149 :: 		TRISC.RC2 = 0;
	BCF         TRISC+0, 2 
;alarme.c,150 :: 		TRISC.RC3 = 0;
	BCF         TRISC+0, 3 
;alarme.c,152 :: 		PORTC.RC0 = 0;
	BCF         PORTC+0, 0 
;alarme.c,153 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;alarme.c,154 :: 		PORTC.RC2 = 0;
	BCF         PORTC+0, 2 
;alarme.c,155 :: 		PORTC.RC3 = 0;
	BCF         PORTC+0, 3 
;alarme.c,156 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_alarm:

;alarme.c,159 :: 		void alarm()
;alarme.c,161 :: 		vSensor1 = (ADC_read(0)/1023.0) * 5;
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
;alarme.c,162 :: 		vSensor2 = (ADC_read(1)/1023.0) * 5;
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
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
;alarme.c,163 :: 		if(isOn)
	MOVF        _isOn+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm3
;alarme.c,165 :: 		char activated = 0;
;alarme.c,166 :: 		int sensorCount = 0;
	CLRF        alarm_sensorCount_L1+0 
	CLRF        alarm_sensorCount_L1+1 
;alarme.c,169 :: 		PORTC.RC0 = PORTC.RC4;
	BTFSC       PORTC+0, 4 
	GOTO        L__alarm74
	BCF         PORTC+0, 0 
	GOTO        L__alarm75
L__alarm74:
	BSF         PORTC+0, 0 
L__alarm75:
;alarme.c,170 :: 		PORTC.RC1 = PORTC.RC5;
	BTFSC       PORTC+0, 5 
	GOTO        L__alarm76
	BCF         PORTC+0, 1 
	GOTO        L__alarm77
L__alarm76:
	BSF         PORTC+0, 1 
L__alarm77:
;alarme.c,171 :: 		PORTC.RC2 = PORTC.RC6;
	BTFSC       PORTC+0, 6 
	GOTO        L__alarm78
	BCF         PORTC+0, 2 
	GOTO        L__alarm79
L__alarm78:
	BSF         PORTC+0, 2 
L__alarm79:
;alarme.c,172 :: 		PORTC.RC3 = PORTC.RC7;
	BTFSC       PORTC+0, 7 
	GOTO        L__alarm80
	BCF         PORTC+0, 3 
	GOTO        L__alarm81
L__alarm80:
	BSF         PORTC+0, 3 
L__alarm81:
;alarme.c,174 :: 		sensorCount += PORTC.RC4;
	CLRF        R0 
	BTFSC       PORTC+0, 4 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,175 :: 		sensorCount += PORTC.RC5;
	CLRF        R0 
	BTFSC       PORTC+0, 5 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,176 :: 		sensorCount += PORTC.RC6;
	CLRF        R0 
	BTFSC       PORTC+0, 6 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,177 :: 		sensorCount += PORTC.RC7;
	CLRF        R0 
	BTFSC       PORTC+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,178 :: 		sensorCount += vSensor1 >= 4 ? 1 : 0;
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
	GOTO        L_alarm4
	MOVLW       1
	MOVWF       ?FLOC___alarmT123+0 
	GOTO        L_alarm5
L_alarm4:
	CLRF        ?FLOC___alarmT123+0 
L_alarm5:
	MOVF        ?FLOC___alarmT123+0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	BTFSC       ?FLOC___alarmT123+0, 7 
	MOVLW       255
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,179 :: 		sensorCount += vSensor2 > 3 ? 1 : 0;
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
	GOTO        L_alarm6
	MOVLW       1
	MOVWF       ?FLOC___alarmT126+0 
	GOTO        L_alarm7
L_alarm6:
	CLRF        ?FLOC___alarmT126+0 
L_alarm7:
	MOVF        ?FLOC___alarmT126+0, 0 
	ADDWF       alarm_sensorCount_L1+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       ?FLOC___alarmT126+0, 7 
	MOVLW       255
	ADDWFC      alarm_sensorCount_L1+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       alarm_sensorCount_L1+0 
	MOVF        R2, 0 
	MOVWF       alarm_sensorCount_L1+1 
;alarme.c,181 :: 		activated = sensorCount >= 2 ? 1 : 0;
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__alarm82
	MOVLW       2
	SUBWF       R1, 0 
L__alarm82:
	BTFSS       STATUS+0, 0 
	GOTO        L_alarm8
	MOVLW       1
	MOVWF       ?FLOC___alarmT129+0 
	GOTO        L_alarm9
L_alarm8:
	CLRF        ?FLOC___alarmT129+0 
L_alarm9:
;alarme.c,183 :: 		if(activated)
	MOVF        ?FLOC___alarmT129+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm10
;alarme.c,187 :: 		IntToStr(sensorCount, number);
	MOVF        alarm_sensorCount_L1+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        alarm_sensorCount_L1+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       alarm_number_L2+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(alarm_number_L2+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;alarme.c,189 :: 		strcat(str, msg1);
	MOVLW       alarm_str_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _msg1+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_msg1+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,190 :: 		strcat(str, number);
	MOVLW       alarm_str_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       alarm_number_L2+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(alarm_number_L2+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,191 :: 		strcat(str, msg2);
	MOVLW       alarm_str_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _msg2+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_msg2+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,193 :: 		if(strcmp(lastText, str))
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
	GOTO        L_alarm11
;alarme.c,195 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;alarme.c,196 :: 		strcpy(lastText, str);
	MOVLW       _lastText+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_lastText+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       alarm_str_L2+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;alarme.c,198 :: 		Lcd_Out(1,1,str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       alarm_str_L2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,199 :: 		}
L_alarm11:
;alarme.c,200 :: 		}
	GOTO        L_alarm12
L_alarm10:
;alarme.c,206 :: 		if(PORTC.RC4)
	BTFSS       PORTC+0, 4 
	GOTO        L_alarm13
;alarme.c,207 :: 		strcpy(number, "1");
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr1_alarme+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr1_alarme+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
L_alarm13:
;alarme.c,209 :: 		if(PORTC.RC5)
	BTFSS       PORTC+0, 5 
	GOTO        L_alarm14
;alarme.c,210 :: 		strcpy(number, "2");
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr2_alarme+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr2_alarme+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
L_alarm14:
;alarme.c,212 :: 		if(PORTC.RC6)
	BTFSS       PORTC+0, 6 
	GOTO        L_alarm15
;alarme.c,213 :: 		strcpy(number, "3");
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr3_alarme+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr3_alarme+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
L_alarm15:
;alarme.c,215 :: 		if(PORTC.RC7)
	BTFSS       PORTC+0, 7 
	GOTO        L_alarm16
;alarme.c,216 :: 		strcpy(number, "4");
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr4_alarme+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr4_alarme+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
L_alarm16:
;alarme.c,218 :: 		if(vSensor1 >= 4)
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
	GOTO        L_alarm17
;alarme.c,219 :: 		strcpy(number, "5");
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr5_alarme+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr5_alarme+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
L_alarm17:
;alarme.c,221 :: 		if(vSensor2 > 3)
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
	GOTO        L_alarm18
;alarme.c,222 :: 		strcpy(number, "6");
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr6_alarme+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr6_alarme+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
L_alarm18:
;alarme.c,225 :: 		strcat(str, msg3);
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _msg3+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_msg3+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,226 :: 		strcat(str, number);
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,227 :: 		strcat(str, msg4);
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _msg4+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_msg4+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,229 :: 		if(strcmp(lastText, str))
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
	GOTO        L_alarm19
;alarme.c,231 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;alarme.c,232 :: 		strcpy(lastText, str);
	MOVLW       _lastText+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_lastText+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;alarme.c,234 :: 		Lcd_Out(1,1,str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,235 :: 		}
L_alarm19:
;alarme.c,236 :: 		}
L_alarm12:
;alarme.c,237 :: 		}
	GOTO        L_alarm20
L_alarm3:
;alarme.c,245 :: 		IntToStr(vSensor1, str1);
	MOVF        _vSensor1+0, 0 
	MOVWF       R0 
	MOVF        _vSensor1+1, 0 
	MOVWF       R1 
	MOVF        _vSensor1+2, 0 
	MOVWF       R2 
	MOVF        _vSensor1+3, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       alarm_str1_L1+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(alarm_str1_L1+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;alarme.c,246 :: 		IntToStr(vSensor2, str2);
	MOVF        _vSensor2+0, 0 
	MOVWF       R0 
	MOVF        _vSensor2+1, 0 
	MOVWF       R1 
	MOVF        _vSensor2+2, 0 
	MOVWF       R2 
	MOVF        _vSensor2+3, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       alarm_str2_L1+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(alarm_str2_L1+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;alarme.c,248 :: 		strcat(str, str1);
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       alarm_str1_L1+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(alarm_str1_L1+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,249 :: 		strcat(str, "V ");
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr7_alarme+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr7_alarme+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,250 :: 		strcat(str, str2);
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       alarm_str2_L1+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(alarm_str2_L1+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,251 :: 		strcat(str, "V");
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr8_alarme+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr8_alarme+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,253 :: 		if(strcmp(lastText, str))
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
	GOTO        L_alarm21
;alarme.c,255 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;alarme.c,256 :: 		strcpy(lastText, str);
	MOVLW       _lastText+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_lastText+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;alarme.c,258 :: 		Lcd_Out(1,1,str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,259 :: 		}
L_alarm21:
;alarme.c,260 :: 		}
L_alarm20:
;alarme.c,261 :: 		}
L_end_alarm:
	RETURN      0
; end of _alarm

_keypadHandler:

;alarme.c,264 :: 		void keypadHandler()
;alarme.c,270 :: 		char rowCode = 0;
	CLRF        keypadHandler_rowCode_L0+0 
	CLRF        keypadHandler_columnCode_L0+0 
;alarme.c,274 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	CLRF        keypadHandler_i_L0+0 
	MOVLW       15
	MOVWF       keypadHandler_columnCode_L0+0 
L_keypadHandler22:
	MOVF        keypadHandler_columnCode_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler23
;alarme.c,276 :: 		PORTB = ~(1 << i) << 4;
	MOVF        keypadHandler_i_L0+0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__keypadHandler84:
	BZ          L__keypadHandler85
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__keypadHandler84
L__keypadHandler85:
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
;alarme.c,277 :: 		columnCode = PORTA.RA2 | (PORTA.RA3 << 1) |
	CLRF        R2 
	BTFSC       PORTA+0, 3 
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
;alarme.c,278 :: 		(PORTA.RA5 << 2) | (PORTB.RB3) << 3;
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
L__keypadHandler86:
	BZ          L__keypadHandler87
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__keypadHandler86
L__keypadHandler87:
	MOVF        R0, 0 
	IORWF       keypadHandler_columnCode_L0+0, 1 
;alarme.c,274 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	INCF        keypadHandler_i_L0+0, 1 
;alarme.c,279 :: 		}
	GOTO        L_keypadHandler22
L_keypadHandler23:
;alarme.c,280 :: 		rowCode = PORTB >> 4;
	MOVF        PORTB+0, 0 
	MOVWF       R2 
	RRCF        R2, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	BCF         R2, 7 
	MOVF        R2, 0 
	MOVWF       keypadHandler_rowCode_L0+0 
;alarme.c,281 :: 		PORTB = 0;
	CLRF        PORTB+0 
;alarme.c,283 :: 		realCode = rowCode | (columnCode << 4);
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
	IORWF       R2, 0 
	MOVWF       FARG_keyHandler_key+0 
;alarme.c,284 :: 		result = keyHandler(realCode, &type);
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
;alarme.c,286 :: 		if(type == NUM)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler25
;alarme.c,288 :: 		if(result == 0)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler88
	MOVLW       0
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler88:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler26
;alarme.c,289 :: 		keyPressed[0] = '0';
	MOVLW       48
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler26:
;alarme.c,291 :: 		if(result == 1)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler89
	MOVLW       1
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler89:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler27
;alarme.c,292 :: 		keyPressed[0] = '1';
	MOVLW       49
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler27:
;alarme.c,294 :: 		if(result == 2)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler90
	MOVLW       2
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler90:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler28
;alarme.c,295 :: 		keyPressed[0] = '2';
	MOVLW       50
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler28:
;alarme.c,297 :: 		if(result == 3)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler91
	MOVLW       3
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler91:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler29
;alarme.c,298 :: 		keyPressed[0] = '3';
	MOVLW       51
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler29:
;alarme.c,300 :: 		if(result == 4)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler92
	MOVLW       4
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler92:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler30
;alarme.c,301 :: 		keyPressed[0] = '4';
	MOVLW       52
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler30:
;alarme.c,303 :: 		if(result == 5)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler93
	MOVLW       5
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler93:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler31
;alarme.c,304 :: 		keyPressed[0] = '5';
	MOVLW       53
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler31:
;alarme.c,306 :: 		if(result == 6)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler94
	MOVLW       6
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler94:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler32
;alarme.c,307 :: 		keyPressed[0] = '6';
	MOVLW       54
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler32:
;alarme.c,309 :: 		if(result == 7)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler95
	MOVLW       7
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler95:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler33
;alarme.c,310 :: 		keyPressed[0] = '7';
	MOVLW       55
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler33:
;alarme.c,312 :: 		if(result == 8)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler96
	MOVLW       8
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler96:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler34
;alarme.c,313 :: 		keyPressed[0] = '8';
	MOVLW       56
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler34:
;alarme.c,315 :: 		if(result == 9)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler97
	MOVLW       9
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler97:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler35
;alarme.c,316 :: 		keyPressed[0] = '9';
	MOVLW       57
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler35:
;alarme.c,317 :: 		}
L_keypadHandler25:
;alarme.c,319 :: 		if(type == SUM)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler36
;alarme.c,320 :: 		keyPressed[0] = '+';
	MOVLW       43
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler36:
;alarme.c,322 :: 		if(type == SUB)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler37
;alarme.c,323 :: 		keyPressed[0] = '-';
	MOVLW       45
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler37:
;alarme.c,325 :: 		if(type == MULT)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler38
;alarme.c,326 :: 		keyPressed[0] = '*';
	MOVLW       42
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler38:
;alarme.c,328 :: 		if(type == DIVI)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler39
;alarme.c,329 :: 		keyPressed[0] = '/';
	MOVLW       47
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler39:
;alarme.c,331 :: 		keyPressed[1] = '\0';
	CLRF        keypadHandler_keyPressed_L0+1 
;alarme.c,334 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;alarme.c,336 :: 		IntToStr(rowCode, lastText);
	MOVF        keypadHandler_rowCode_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _lastText+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_lastText+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;alarme.c,337 :: 		Lcd_Out(1,1,lastText);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _lastText+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_lastText+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,339 :: 		IntToStr(columnCode, lastText);
	MOVF        keypadHandler_columnCode_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _lastText+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_lastText+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;alarme.c,340 :: 		Lcd_Out(2,1,lastText);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _lastText+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_lastText+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,343 :: 		rightKeysActivation[nKeyPressed] = (activationCode[nKeyPressed] != keyPressed[0]) == 0 ? 1 : 0;
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
	GOTO        L_keypadHandler40
	MOVLW       1
	MOVWF       ?FLOC___keypadHandlerT255+0 
	GOTO        L_keypadHandler41
L_keypadHandler40:
	CLRF        ?FLOC___keypadHandlerT255+0 
L_keypadHandler41:
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        ?FLOC___keypadHandlerT255+0, 0 
	MOVWF       POSTINC1+0 
;alarme.c,344 :: 		rightKeysDeActivation[nKeyPressed] = (DeActivationCode[nKeyPressed] != keyPressed[0]) == 0 ? 1 : 0;
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
	GOTO        L_keypadHandler42
	MOVLW       1
	MOVWF       ?FLOC___keypadHandlerT266+0 
	GOTO        L_keypadHandler43
L_keypadHandler42:
	CLRF        ?FLOC___keypadHandlerT266+0 
L_keypadHandler43:
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        ?FLOC___keypadHandlerT266+0, 0 
	MOVWF       POSTINC1+0 
;alarme.c,346 :: 		if(nKeyPressed == 6)
	MOVF        _nKeyPressed+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler44
;alarme.c,349 :: 		char activationCounter = 0;
	CLRF        keypadHandler_activationCounter_L1+0 
	CLRF        keypadHandler_deActivationCounter_L1+0 
;alarme.c,351 :: 		for(i = 0; i < nKeyPressed; i++)
	CLRF        keypadHandler_i_L1+0 
	CLRF        keypadHandler_i_L1+1 
L_keypadHandler45:
	MOVLW       128
	XORWF       keypadHandler_i_L1+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler98
	MOVF        _nKeyPressed+0, 0 
	SUBWF       keypadHandler_i_L1+0, 0 
L__keypadHandler98:
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadHandler46
;alarme.c,353 :: 		activationCounter += rightKeysActivation[i];
	MOVLW       _rightKeysActivation+0
	ADDWF       keypadHandler_i_L1+0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_rightKeysActivation+0)
	ADDWFC      keypadHandler_i_L1+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       keypadHandler_activationCounter_L1+0, 1 
;alarme.c,354 :: 		deActivationCounter += rightKeysDeActivation[i];
	MOVLW       _rightKeysDeActivation+0
	ADDWF       keypadHandler_i_L1+0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_rightKeysDeActivation+0)
	ADDWFC      keypadHandler_i_L1+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       keypadHandler_deActivationCounter_L1+0, 1 
;alarme.c,351 :: 		for(i = 0; i < nKeyPressed; i++)
	INFSNZ      keypadHandler_i_L1+0, 1 
	INCF        keypadHandler_i_L1+1, 1 
;alarme.c,355 :: 		}
	GOTO        L_keypadHandler45
L_keypadHandler46:
;alarme.c,357 :: 		if(activationCounter == 6)
	MOVF        keypadHandler_activationCounter_L1+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler48
;alarme.c,359 :: 		isOn = 1;
	MOVLW       1
	MOVWF       _isOn+0 
;alarme.c,360 :: 		}
L_keypadHandler48:
;alarme.c,362 :: 		if(deActivationCounter == 6)
	MOVF        keypadHandler_deActivationCounter_L1+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler49
;alarme.c,364 :: 		isOn = 0;
	CLRF        _isOn+0 
;alarme.c,365 :: 		}
L_keypadHandler49:
;alarme.c,366 :: 		}
L_keypadHandler44:
;alarme.c,368 :: 		nKeyPressed = nKeyPressed == 6 ? 0 : nKeyPressed++;
	MOVF        _nKeyPressed+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler50
	CLRF        ?FLOC___keypadHandlerT283+0 
	GOTO        L_keypadHandler51
L_keypadHandler50:
	MOVF        _nKeyPressed+0, 0 
	MOVWF       R1 
	MOVF        _nKeyPressed+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _nKeyPressed+0 
	MOVF        R1, 0 
	MOVWF       ?FLOC___keypadHandlerT283+0 
L_keypadHandler51:
	MOVF        ?FLOC___keypadHandlerT283+0, 0 
	MOVWF       _nKeyPressed+0 
;alarme.c,369 :: 		}
L_end_keypadHandler:
	RETURN      0
; end of _keypadHandler

_keyHandler:

;alarme.c,372 :: 		int keyHandler (int key, KeyType* type)
;alarme.c,374 :: 		int result = -1;
	MOVLW       255
	MOVWF       keyHandler_result_L0+0 
	MOVLW       255
	MOVWF       keyHandler_result_L0+1 
;alarme.c,375 :: 		switch(key)
	GOTO        L_keyHandler52
;alarme.c,377 :: 		case 231:
L_keyHandler54:
;alarme.c,378 :: 		*type = ON_CLEAR;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       5
	MOVWF       POSTINC1+0 
;alarme.c,379 :: 		break;
	GOTO        L_keyHandler53
;alarme.c,381 :: 		case 215:
L_keyHandler55:
;alarme.c,382 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,383 :: 		result = 0;
	CLRF        keyHandler_result_L0+0 
	CLRF        keyHandler_result_L0+1 
;alarme.c,384 :: 		break;
	GOTO        L_keyHandler53
;alarme.c,386 :: 		case 183:
L_keyHandler56:
;alarme.c,387 :: 		*type = EQUALS;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	CLRF        POSTINC1+0 
;alarme.c,388 :: 		break;
	GOTO        L_keyHandler53
;alarme.c,390 :: 		case 119:
L_keyHandler57:
;alarme.c,391 :: 		*type = SUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
;alarme.c,392 :: 		break;
	GOTO        L_keyHandler53
;alarme.c,394 :: 		case 235:
L_keyHandler58:
;alarme.c,395 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,396 :: 		result = 7;
	MOVLW       7
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,397 :: 		break;
	GOTO        L_keyHandler53
;alarme.c,399 :: 		case 219:
L_keyHandler59:
;alarme.c,400 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,401 :: 		result = 8;
	MOVLW       8
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,402 :: 		break;
	GOTO        L_keyHandler53
;alarme.c,404 :: 		case 187:
L_keyHandler60:
;alarme.c,405 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,406 :: 		result = 9;
	MOVLW       9
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,407 :: 		break;
	GOTO        L_keyHandler53
;alarme.c,409 :: 		case 123:
L_keyHandler61:
;alarme.c,410 :: 		*type = SUB;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       2
	MOVWF       POSTINC1+0 
;alarme.c,411 :: 		break;
	GOTO        L_keyHandler53
;alarme.c,413 :: 		case 237:
L_keyHandler62:
;alarme.c,414 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,415 :: 		result = 4;
	MOVLW       4
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,416 :: 		break;
	GOTO        L_keyHandler53
;alarme.c,418 :: 		case 221:
L_keyHandler63:
;alarme.c,419 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,420 :: 		result = 5;
	MOVLW       5
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,421 :: 		break;
	GOTO        L_keyHandler53
;alarme.c,423 :: 		case 189:
L_keyHandler64:
;alarme.c,424 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,425 :: 		result = 6;
	MOVLW       6
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,426 :: 		break;
	GOTO        L_keyHandler53
;alarme.c,428 :: 		case 125:
L_keyHandler65:
;alarme.c,429 :: 		*type = MULT;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       3
	MOVWF       POSTINC1+0 
;alarme.c,430 :: 		break;
	GOTO        L_keyHandler53
;alarme.c,432 :: 		case 238:
L_keyHandler66:
;alarme.c,433 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,434 :: 		result = 1;
	MOVLW       1
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,435 :: 		break;
	GOTO        L_keyHandler53
;alarme.c,437 :: 		case 222:
L_keyHandler67:
;alarme.c,438 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,439 :: 		result = 2;
	MOVLW       2
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,440 :: 		break;
	GOTO        L_keyHandler53
;alarme.c,442 :: 		case 190:
L_keyHandler68:
;alarme.c,443 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,444 :: 		result = 3;
	MOVLW       3
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,445 :: 		break;
	GOTO        L_keyHandler53
;alarme.c,447 :: 		case 126:
L_keyHandler69:
;alarme.c,448 :: 		*type = DIVI;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       4
	MOVWF       POSTINC1+0 
;alarme.c,449 :: 		break;
	GOTO        L_keyHandler53
;alarme.c,450 :: 		}
L_keyHandler52:
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler100
	MOVLW       231
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler100:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler54
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler101
	MOVLW       215
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler101:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler55
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler102
	MOVLW       183
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler102:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler56
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler103
	MOVLW       119
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler103:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler57
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler104
	MOVLW       235
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler104:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler58
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler105
	MOVLW       219
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler105:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler59
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler106
	MOVLW       187
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler106:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler60
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler107
	MOVLW       123
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler107:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler61
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler108
	MOVLW       237
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler108:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler62
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler109
	MOVLW       221
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler109:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler63
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler110
	MOVLW       189
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler110:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler64
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler111
	MOVLW       125
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler111:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler65
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler112
	MOVLW       238
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler112:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler66
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler113
	MOVLW       222
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler113:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler67
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler114
	MOVLW       190
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler114:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler68
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler115
	MOVLW       126
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler115:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler69
L_keyHandler53:
;alarme.c,452 :: 		return result;
	MOVF        keyHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keyHandler_result_L0+1, 0 
	MOVWF       R1 
;alarme.c,453 :: 		}
L_end_keyHandler:
	RETURN      0
; end of _keyHandler
