
_interrupt:

;alarme.c,60 :: 		void interrupt(void)
;alarme.c,62 :: 		if(INTCON3.INT1IF)
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt0
;alarme.c,64 :: 		keypadHandler();
	CALL        _keypadHandler+0, 0
;alarme.c,67 :: 		TMR2 = COUNTER2;
	MOVLW       127
	MOVWF       TMR2+0 
;alarme.c,69 :: 		PIR1.TMR2IF=0;
	BCF         PIR1+0, 1 
;alarme.c,70 :: 		PIE1.TMR2IE=1;
	BSF         PIE1+0, 1 
;alarme.c,72 :: 		T2CON.TMR2ON = 1;
	BSF         T2CON+0, 2 
;alarme.c,75 :: 		INTCON3.INT1IE = 0;
	BCF         INTCON3+0, 3 
;alarme.c,76 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;alarme.c,77 :: 		}
	GOTO        L_interrupt1
L_interrupt0:
;alarme.c,78 :: 		else if(PIR1.TMR2IF) // Related to bouncing
	BTFSS       PIR1+0, 1 
	GOTO        L_interrupt2
;alarme.c,81 :: 		PIR1.TMR2IF=0;
	BCF         PIR1+0, 1 
;alarme.c,82 :: 		PIE1.TMR2IE=0;
	BCF         PIE1+0, 1 
;alarme.c,83 :: 		T2CON.TMR2ON=0;
	BCF         T2CON+0, 2 
;alarme.c,86 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;alarme.c,87 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;alarme.c,88 :: 		}
	GOTO        L_interrupt3
L_interrupt2:
;alarme.c,89 :: 		else if(INTCON.TMR0IF)
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt4
;alarme.c,91 :: 		alarm();
	CALL        _alarm+0, 0
;alarme.c,93 :: 		TMR0H = COUNTER1 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       216
	MOVWF       TMR0H+0 
;alarme.c,94 :: 		TMR0L = COUNTER1;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       239
	MOVWF       TMR0L+0 
;alarme.c,96 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;alarme.c,97 :: 		}
L_interrupt4:
L_interrupt3:
L_interrupt1:
;alarme.c,99 :: 		}
L_end_interrupt:
L__interrupt72:
	RETFIE      1
; end of _interrupt

_main:

;alarme.c,101 :: 		void main()
;alarme.c,104 :: 		ADCON1 = 0x04;
	MOVLW       4
	MOVWF       ADCON1+0 
;alarme.c,107 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;alarme.c,110 :: 		T0CON.T08BIT = 0;       // 16 bits
	BCF         T0CON+0, 6 
;alarme.c,111 :: 		T0CON.T0CS = 0;         // Internal clock => Crystal/4
	BCF         T0CON+0, 5 
;alarme.c,112 :: 		T0CON.PSA = 0;          // Prescaler ON
	BCF         T0CON+0, 3 
;alarme.c,114 :: 		T0CON.T0PS2 = 1;
	BSF         T0CON+0, 2 
;alarme.c,115 :: 		T0CON.T0PS1 = 1;
	BSF         T0CON+0, 1 
;alarme.c,116 :: 		T0CON.T0PS0 = 1;
	BSF         T0CON+0, 0 
;alarme.c,118 :: 		TMR0H = COUNTER1 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       216
	MOVWF       TMR0H+0 
;alarme.c,119 :: 		TMR0L = COUNTER1;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       239
	MOVWF       TMR0L+0 
;alarme.c,120 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;alarme.c,121 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;alarme.c,122 :: 		T0CON.TMR0ON=1;
	BSF         T0CON+0, 7 
;alarme.c,126 :: 		T2CON.T2CKPS1 = 1;
	BSF         T2CON+0, 1 
;alarme.c,127 :: 		T2CON.T2CKPS0 = 1;
	BSF         T2CON+0, 0 
;alarme.c,130 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;alarme.c,131 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;alarme.c,132 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;alarme.c,135 :: 		TRISB.RB1 = 1;
	BSF         TRISB+0, 1 
;alarme.c,139 :: 		TRISC.RC4 = 1;
	BSF         TRISC+0, 4 
;alarme.c,140 :: 		TRISC.RC5 = 1;
	BSF         TRISC+0, 5 
;alarme.c,141 :: 		TRISC.RC6 = 1;
	BSF         TRISC+0, 6 
;alarme.c,142 :: 		TRISC.RC7 = 1;
	BSF         TRISC+0, 7 
;alarme.c,144 :: 		TRISA.RA0 = 1;
	BSF         TRISA+0, 0 
;alarme.c,145 :: 		TRISA.RA1 = 1;
	BSF         TRISA+0, 1 
;alarme.c,149 :: 		TRISB.RB4 = 0;
	BCF         TRISB+0, 4 
;alarme.c,150 :: 		TRISB.RB5 = 0;
	BCF         TRISB+0, 5 
;alarme.c,151 :: 		TRISB.RB6 = 0;
	BCF         TRISB+0, 6 
;alarme.c,152 :: 		TRISB.RB7 = 0;
	BCF         TRISB+0, 7 
;alarme.c,154 :: 		PORTB.RB4 = 0;
	BCF         PORTB+0, 4 
;alarme.c,155 :: 		PORTB.RB5 = 0;
	BCF         PORTB+0, 5 
;alarme.c,156 :: 		PORTB.RB6 = 0;
	BCF         PORTB+0, 6 
;alarme.c,157 :: 		PORTB.RB7 = 0;
	BCF         PORTB+0, 7 
;alarme.c,161 :: 		TRISA.RA2 = 1;
	BSF         TRISA+0, 2 
;alarme.c,162 :: 		TRISA.RA4 = 1;
	BSF         TRISA+0, 4 
;alarme.c,163 :: 		TRISA.RA5 = 1;
	BSF         TRISA+0, 5 
;alarme.c,164 :: 		TRISB.RB3 = 1;
	BSF         TRISB+0, 3 
;alarme.c,167 :: 		TRISC.RC0 = 0;
	BCF         TRISC+0, 0 
;alarme.c,168 :: 		TRISC.RC1 = 0;
	BCF         TRISC+0, 1 
;alarme.c,169 :: 		TRISC.RC2 = 0;
	BCF         TRISC+0, 2 
;alarme.c,170 :: 		TRISC.RC3 = 0;
	BCF         TRISC+0, 3 
;alarme.c,172 :: 		PORTC.RC0 = 0;
	BCF         PORTC+0, 0 
;alarme.c,173 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;alarme.c,174 :: 		PORTC.RC2 = 0;
	BCF         PORTC+0, 2 
;alarme.c,175 :: 		PORTC.RC3 = 0;
	BCF         PORTC+0, 3 
;alarme.c,176 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_alarm:

;alarme.c,179 :: 		void alarm()
;alarme.c,181 :: 		vSensor1 = (ADC_read(0)/1023.0) * 5;
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
;alarme.c,182 :: 		vSensor2 = (ADC_read(1)/1023.0) * 5;
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
;alarme.c,183 :: 		if(isOn)
	MOVF        _isOn+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm5
;alarme.c,185 :: 		char activated = 0;
;alarme.c,186 :: 		int sensorCount = 0;
	CLRF        alarm_sensorCount_L1+0 
	CLRF        alarm_sensorCount_L1+1 
;alarme.c,189 :: 		PORTC.RC0 = PORTC.RC4;
	BTFSC       PORTC+0, 4 
	GOTO        L__alarm75
	BCF         PORTC+0, 0 
	GOTO        L__alarm76
L__alarm75:
	BSF         PORTC+0, 0 
L__alarm76:
;alarme.c,190 :: 		PORTC.RC1 = PORTC.RC5;
	BTFSC       PORTC+0, 5 
	GOTO        L__alarm77
	BCF         PORTC+0, 1 
	GOTO        L__alarm78
L__alarm77:
	BSF         PORTC+0, 1 
L__alarm78:
;alarme.c,191 :: 		PORTC.RC2 = PORTC.RC6;
	BTFSC       PORTC+0, 6 
	GOTO        L__alarm79
	BCF         PORTC+0, 2 
	GOTO        L__alarm80
L__alarm79:
	BSF         PORTC+0, 2 
L__alarm80:
;alarme.c,192 :: 		PORTC.RC3 = PORTC.RC7;
	BTFSC       PORTC+0, 7 
	GOTO        L__alarm81
	BCF         PORTC+0, 3 
	GOTO        L__alarm82
L__alarm81:
	BSF         PORTC+0, 3 
L__alarm82:
;alarme.c,194 :: 		sensorCount += PORTC.RC4;
	CLRF        R0 
	BTFSC       PORTC+0, 4 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,195 :: 		sensorCount += PORTC.RC5;
	CLRF        R0 
	BTFSC       PORTC+0, 5 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,196 :: 		sensorCount += PORTC.RC6;
	CLRF        R0 
	BTFSC       PORTC+0, 6 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,197 :: 		sensorCount += PORTC.RC7;
	CLRF        R0 
	BTFSC       PORTC+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,198 :: 		sensorCount += vSensor1 >= 4 ? 1 : 0;
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
	GOTO        L_alarm6
	MOVLW       1
	MOVWF       R0 
	GOTO        L_alarm7
L_alarm6:
	CLRF        R0 
L_alarm7:
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,199 :: 		sensorCount += vSensor2 > 3 ? 1 : 0;
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
	GOTO        L_alarm8
	MOVLW       1
	MOVWF       R0 
	GOTO        L_alarm9
L_alarm8:
	CLRF        R0 
L_alarm9:
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	ADDWFC      alarm_sensorCount_L1+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       alarm_sensorCount_L1+0 
	MOVF        R2, 0 
	MOVWF       alarm_sensorCount_L1+1 
;alarme.c,201 :: 		activated = sensorCount >= 2 ? 1 : 0;
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__alarm83
	MOVLW       2
	SUBWF       R1, 0 
L__alarm83:
	BTFSS       STATUS+0, 0 
	GOTO        L_alarm10
	MOVLW       1
	MOVWF       R0 
	GOTO        L_alarm11
L_alarm10:
	CLRF        R0 
L_alarm11:
;alarme.c,203 :: 		if(activated)
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm12
;alarme.c,206 :: 		char str[60] = "";
	MOVLW       ?ICSalarm_str_L2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICSalarm_str_L2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICSalarm_str_L2+0)
	MOVWF       TBLPTRU 
	MOVLW       alarm_str_L2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FSR1H 
	MOVLW       60
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;alarme.c,207 :: 		IntToStr(sensorCount, number);
	MOVF        alarm_sensorCount_L1+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        alarm_sensorCount_L1+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       alarm_number_L2+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(alarm_number_L2+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;alarme.c,209 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;alarme.c,211 :: 		strcat(str, msg1);
	MOVLW       alarm_str_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _msg1+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_msg1+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,212 :: 		strcat(str, number);
	MOVLW       alarm_str_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       alarm_number_L2+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(alarm_number_L2+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
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
;alarme.c,215 :: 		Lcd_Out(2,1,msg2);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _msg2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_msg2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,216 :: 		}
	GOTO        L_alarm13
L_alarm12:
;alarme.c,220 :: 		char str[60] = "";
	MOVLW       ?ICSalarm_str_L2_L2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICSalarm_str_L2_L2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICSalarm_str_L2_L2+0)
	MOVWF       TBLPTRU 
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FSR1H 
	MOVLW       60
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;alarme.c,222 :: 		if(PORTC.RC4)
	BTFSS       PORTC+0, 4 
	GOTO        L_alarm14
;alarme.c,223 :: 		strcpy(number, "1");
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr1_alarme+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr1_alarme+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
L_alarm14:
;alarme.c,225 :: 		if(PORTC.RC5)
	BTFSS       PORTC+0, 5 
	GOTO        L_alarm15
;alarme.c,226 :: 		strcpy(number, "2");
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr2_alarme+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr2_alarme+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
L_alarm15:
;alarme.c,228 :: 		if(PORTC.RC6)
	BTFSS       PORTC+0, 6 
	GOTO        L_alarm16
;alarme.c,229 :: 		strcpy(number, "3");
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr3_alarme+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr3_alarme+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
L_alarm16:
;alarme.c,231 :: 		if(PORTC.RC7)
	BTFSS       PORTC+0, 7 
	GOTO        L_alarm17
;alarme.c,232 :: 		strcpy(number, "4");
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr4_alarme+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr4_alarme+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
L_alarm17:
;alarme.c,234 :: 		if(vSensor1 >= 4)
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
	GOTO        L_alarm18
;alarme.c,235 :: 		strcpy(number, "5");
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr5_alarme+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr5_alarme+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
L_alarm18:
;alarme.c,237 :: 		if(vSensor2 > 3)
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
	GOTO        L_alarm19
;alarme.c,238 :: 		strcpy(number, "6");
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr6_alarme+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr6_alarme+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
L_alarm19:
;alarme.c,241 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;alarme.c,243 :: 		strcat(str, msg3);
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _msg3+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_msg3+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,244 :: 		strcat(str, number);
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,245 :: 		Lcd_Out(1,1, str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,247 :: 		Lcd_Out(2,1, msg4);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _msg4+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_msg4+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,248 :: 		}
L_alarm13:
;alarme.c,249 :: 		}
	GOTO        L_alarm20
L_alarm5:
;alarme.c,255 :: 		if(vSensor1 < 1)
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       127
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
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm21
;alarme.c,256 :: 		vSensor1 = 0;
	CLRF        _vSensor1+0 
	CLRF        _vSensor1+1 
	CLRF        _vSensor1+2 
	CLRF        _vSensor1+3 
L_alarm21:
;alarme.c,257 :: 		if(vSensor2 < 1)
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	MOVF        _vSensor2+0, 0 
	MOVWF       R0 
	MOVF        _vSensor2+1, 0 
	MOVWF       R1 
	MOVF        _vSensor2+2, 0 
	MOVWF       R2 
	MOVF        _vSensor2+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm22
;alarme.c,258 :: 		vSensor2 = 0;
	CLRF        _vSensor2+0 
	CLRF        _vSensor2+1 
	CLRF        _vSensor2+2 
	CLRF        _vSensor2+3 
L_alarm22:
;alarme.c,260 :: 		FloatToStr(vSensor1, str1);
	MOVF        _vSensor1+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _vSensor1+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _vSensor1+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _vSensor1+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       alarm_str1_L1+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(alarm_str1_L1+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;alarme.c,261 :: 		FloatToStr(vSensor2, str2);
	MOVF        _vSensor2+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _vSensor2+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _vSensor2+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _vSensor2+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       alarm_str2_L1+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(alarm_str2_L1+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;alarme.c,262 :: 		str1[3] = '\0';
	CLRF        alarm_str1_L1+3 
;alarme.c,263 :: 		str2[3] = '\0';
	CLRF        alarm_str2_L1+3 
;alarme.c,265 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;alarme.c,267 :: 		Lcd_Out(1,1,str1);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       alarm_str1_L1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(alarm_str1_L1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,268 :: 		Lcd_Out(1,4,"V");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_alarme+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_alarme+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,269 :: 		Lcd_Out(2,1,str2);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       alarm_str2_L1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(alarm_str2_L1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,270 :: 		Lcd_Out(2,4,"V");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_alarme+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_alarme+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,271 :: 		}
L_alarm20:
;alarme.c,272 :: 		}
L_end_alarm:
	RETURN      0
; end of _alarm

_keypadHandler:

;alarme.c,275 :: 		void keypadHandler()
;alarme.c,281 :: 		char rowCode = 0;
;alarme.c,282 :: 		char realCode = 0;
;alarme.c,283 :: 		char columnCode = 0;
	CLRF        keypadHandler_columnCode_L0+0 
;alarme.c,285 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	CLRF        keypadHandler_i_L0+0 
	MOVLW       15
	MOVWF       keypadHandler_columnCode_L0+0 
L_keypadHandler23:
	MOVF        keypadHandler_columnCode_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler24
;alarme.c,288 :: 		PORTB = ~(1 << i) << 4;
	MOVF        keypadHandler_i_L0+0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__keypadHandler85:
	BZ          L__keypadHandler86
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__keypadHandler85
L__keypadHandler86:
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
;alarme.c,289 :: 		columnCode = PORTA.RA2 | (PORTA.RA4 << 1) |
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
;alarme.c,290 :: 		(PORTA.RA5 << 2) | (PORTB.RB3) << 3;
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
L__keypadHandler87:
	BZ          L__keypadHandler88
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__keypadHandler87
L__keypadHandler88:
	MOVF        R0, 0 
	IORWF       keypadHandler_columnCode_L0+0, 1 
;alarme.c,285 :: 		for(i = 0, columnCode = 0xf; columnCode == 0xf; i++)
	INCF        keypadHandler_i_L0+0, 1 
;alarme.c,292 :: 		}
	GOTO        L_keypadHandler23
L_keypadHandler24:
;alarme.c,293 :: 		rowCode = PORTB >> 4;
	MOVLW       4
	MOVWF       R0 
	MOVF        PORTB+0, 0 
	MOVWF       FARG_keyHandler_key+0 
	MOVLW       0
	MOVWF       FARG_keyHandler_key+1 
	MOVF        R0, 0 
L__keypadHandler89:
	BZ          L__keypadHandler90
	RRCF        FARG_keyHandler_key+0, 1 
	BCF         FARG_keyHandler_key+0, 7 
	ADDLW       255
	GOTO        L__keypadHandler89
L__keypadHandler90:
;alarme.c,294 :: 		PORTB = 0;
	CLRF        PORTB+0 
;alarme.c,296 :: 		realCode = rowCode | (columnCode << 4);
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
;alarme.c,297 :: 		result = keyHandler(realCode, &type);
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
;alarme.c,299 :: 		if(type == NUM)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler26
;alarme.c,301 :: 		if(result == 0)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler91
	MOVLW       0
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler91:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler27
;alarme.c,302 :: 		keyPressed[0] = '0';
	MOVLW       48
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler27:
;alarme.c,304 :: 		if(result == 1)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler92
	MOVLW       1
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler92:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler28
;alarme.c,305 :: 		keyPressed[0] = '1';
	MOVLW       49
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler28:
;alarme.c,307 :: 		if(result == 2)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler93
	MOVLW       2
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler93:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler29
;alarme.c,308 :: 		keyPressed[0] = '2';
	MOVLW       50
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler29:
;alarme.c,310 :: 		if(result == 3)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler94
	MOVLW       3
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler94:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler30
;alarme.c,311 :: 		keyPressed[0] = '3';
	MOVLW       51
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler30:
;alarme.c,313 :: 		if(result == 4)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler95
	MOVLW       4
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler95:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler31
;alarme.c,314 :: 		keyPressed[0] = '4';
	MOVLW       52
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler31:
;alarme.c,316 :: 		if(result == 5)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler96
	MOVLW       5
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler96:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler32
;alarme.c,317 :: 		keyPressed[0] = '5';
	MOVLW       53
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler32:
;alarme.c,319 :: 		if(result == 6)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler97
	MOVLW       6
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler97:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler33
;alarme.c,320 :: 		keyPressed[0] = '6';
	MOVLW       54
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler33:
;alarme.c,322 :: 		if(result == 7)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler98
	MOVLW       7
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler98:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler34
;alarme.c,323 :: 		keyPressed[0] = '7';
	MOVLW       55
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler34:
;alarme.c,325 :: 		if(result == 8)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler99
	MOVLW       8
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler99:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler35
;alarme.c,326 :: 		keyPressed[0] = '8';
	MOVLW       56
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler35:
;alarme.c,328 :: 		if(result == 9)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler100
	MOVLW       9
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler100:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler36
;alarme.c,329 :: 		keyPressed[0] = '9';
	MOVLW       57
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler36:
;alarme.c,330 :: 		}
L_keypadHandler26:
;alarme.c,332 :: 		if(type == SUM)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler37
;alarme.c,333 :: 		keyPressed[0] = '+';
	MOVLW       43
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler37:
;alarme.c,335 :: 		if(type == SUB)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler38
;alarme.c,336 :: 		keyPressed[0] = '-';
	MOVLW       45
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler38:
;alarme.c,338 :: 		if(type == MULT)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler39
;alarme.c,339 :: 		keyPressed[0] = '*';
	MOVLW       42
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler39:
;alarme.c,341 :: 		if(type == DIVI)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler40
;alarme.c,342 :: 		keyPressed[0] = '/';
	MOVLW       47
	MOVWF       keypadHandler_keyPressed_L0+0 
L_keypadHandler40:
;alarme.c,344 :: 		keyPressed[1] = '\0';
	CLRF        keypadHandler_keyPressed_L0+1 
;alarme.c,346 :: 		Lcd_Out(1, 15, keyPressed);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       keypadHandler_keyPressed_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(keypadHandler_keyPressed_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,348 :: 		rightKeysActivation[nKeyPressed] = (activationCode[nKeyPressed] != keyPressed[0]) == 0 ? 1 : 0;
	MOVLW       _rightKeysActivation+0
	ADDWF       _nKeyPressed+0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_rightKeysActivation+0)
	ADDWFC      _nKeyPressed+1, 0 
	MOVWF       R3 
	MOVLW       _activationCode+0
	ADDWF       _nKeyPressed+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_activationCode+0)
	ADDWFC      _nKeyPressed+1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_activationCode+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	BTFSC       _nKeyPressed+1, 7 
	MOVLW       255
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
	GOTO        L_keypadHandler41
	MOVLW       1
	MOVWF       R0 
	GOTO        L_keypadHandler42
L_keypadHandler41:
	CLRF        R0 
L_keypadHandler42:
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;alarme.c,349 :: 		rightKeysDeActivation[nKeyPressed] = (DeActivationCode[nKeyPressed] != keyPressed[0]) == 0 ? 1 : 0;
	MOVLW       _rightKeysDeActivation+0
	ADDWF       _nKeyPressed+0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_rightKeysDeActivation+0)
	ADDWFC      _nKeyPressed+1, 0 
	MOVWF       R3 
	MOVLW       _deActivationCode+0
	ADDWF       _nKeyPressed+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_deActivationCode+0)
	ADDWFC      _nKeyPressed+1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_deActivationCode+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	BTFSC       _nKeyPressed+1, 7 
	MOVLW       255
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
	GOTO        L_keypadHandler43
	MOVLW       1
	MOVWF       R0 
	GOTO        L_keypadHandler44
L_keypadHandler43:
	CLRF        R0 
L_keypadHandler44:
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;alarme.c,351 :: 		if(nKeyPressed == 5)
	MOVLW       0
	XORWF       _nKeyPressed+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler101
	MOVLW       5
	XORWF       _nKeyPressed+0, 0 
L__keypadHandler101:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler45
;alarme.c,354 :: 		char activationCounter = 0;
	CLRF        keypadHandler_activationCounter_L1+0 
	CLRF        keypadHandler_deActivationCounter_L1+0 
;alarme.c,356 :: 		for(i = 0; i <= nKeyPressed; i++)
	CLRF        keypadHandler_i_L1+0 
	CLRF        keypadHandler_i_L1+1 
L_keypadHandler46:
	MOVLW       128
	XORWF       _nKeyPressed+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       keypadHandler_i_L1+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler102
	MOVF        keypadHandler_i_L1+0, 0 
	SUBWF       _nKeyPressed+0, 0 
L__keypadHandler102:
	BTFSS       STATUS+0, 0 
	GOTO        L_keypadHandler47
;alarme.c,358 :: 		activationCounter += rightKeysActivation[i];
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
;alarme.c,359 :: 		deActivationCounter += rightKeysDeActivation[i];
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
;alarme.c,356 :: 		for(i = 0; i <= nKeyPressed; i++)
	INFSNZ      keypadHandler_i_L1+0, 1 
	INCF        keypadHandler_i_L1+1, 1 
;alarme.c,360 :: 		}
	GOTO        L_keypadHandler46
L_keypadHandler47:
;alarme.c,362 :: 		if(activationCounter == 6)
	MOVF        keypadHandler_activationCounter_L1+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler49
;alarme.c,364 :: 		isOn = 1;
	MOVLW       1
	MOVWF       _isOn+0 
;alarme.c,365 :: 		}
L_keypadHandler49:
;alarme.c,367 :: 		if(deActivationCounter == 6)
	MOVF        keypadHandler_deActivationCounter_L1+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler50
;alarme.c,369 :: 		isOn = 0;
	CLRF        _isOn+0 
;alarme.c,370 :: 		}
L_keypadHandler50:
;alarme.c,371 :: 		}
L_keypadHandler45:
;alarme.c,373 :: 		nKeyPressed = (nKeyPressed == 5) ? 0 : nKeyPressed + 1;
	MOVLW       0
	XORWF       _nKeyPressed+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler103
	MOVLW       5
	XORWF       _nKeyPressed+0, 0 
L__keypadHandler103:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler51
	CLRF        R2 
	CLRF        R3 
	GOTO        L_keypadHandler52
L_keypadHandler51:
	MOVLW       1
	ADDWF       _nKeyPressed+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _nKeyPressed+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
L_keypadHandler52:
	MOVF        R2, 0 
	MOVWF       _nKeyPressed+0 
	MOVF        R3, 0 
	MOVWF       _nKeyPressed+1 
;alarme.c,374 :: 		}
L_end_keypadHandler:
	RETURN      0
; end of _keypadHandler

_keyHandler:

;alarme.c,377 :: 		int keyHandler (int key, KeyType* type)
;alarme.c,379 :: 		int result = -1;
	MOVLW       255
	MOVWF       keyHandler_result_L0+0 
	MOVLW       255
	MOVWF       keyHandler_result_L0+1 
;alarme.c,380 :: 		switch(key)
	GOTO        L_keyHandler53
;alarme.c,382 :: 		case 231:
L_keyHandler55:
;alarme.c,383 :: 		*type = ON_CLEAR;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       5
	MOVWF       POSTINC1+0 
;alarme.c,384 :: 		break;
	GOTO        L_keyHandler54
;alarme.c,386 :: 		case 215:
L_keyHandler56:
;alarme.c,387 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,388 :: 		result = 0;
	CLRF        keyHandler_result_L0+0 
	CLRF        keyHandler_result_L0+1 
;alarme.c,389 :: 		break;
	GOTO        L_keyHandler54
;alarme.c,391 :: 		case 183:
L_keyHandler57:
;alarme.c,392 :: 		*type = EQUALS;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	CLRF        POSTINC1+0 
;alarme.c,393 :: 		break;
	GOTO        L_keyHandler54
;alarme.c,395 :: 		case 119:
L_keyHandler58:
;alarme.c,396 :: 		*type = SUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
;alarme.c,397 :: 		break;
	GOTO        L_keyHandler54
;alarme.c,399 :: 		case 235:
L_keyHandler59:
;alarme.c,400 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,401 :: 		result = 1;
	MOVLW       1
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,402 :: 		break;
	GOTO        L_keyHandler54
;alarme.c,404 :: 		case 219:
L_keyHandler60:
;alarme.c,405 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,406 :: 		result = 2;
	MOVLW       2
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,407 :: 		break;
	GOTO        L_keyHandler54
;alarme.c,409 :: 		case 187:
L_keyHandler61:
;alarme.c,410 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,411 :: 		result = 3;
	MOVLW       3
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,412 :: 		break;
	GOTO        L_keyHandler54
;alarme.c,414 :: 		case 123:
L_keyHandler62:
;alarme.c,415 :: 		*type = SUB;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       2
	MOVWF       POSTINC1+0 
;alarme.c,416 :: 		break;
	GOTO        L_keyHandler54
;alarme.c,418 :: 		case 237:
L_keyHandler63:
;alarme.c,419 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,420 :: 		result = 4;
	MOVLW       4
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,421 :: 		break;
	GOTO        L_keyHandler54
;alarme.c,423 :: 		case 221:
L_keyHandler64:
;alarme.c,424 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,425 :: 		result = 5;
	MOVLW       5
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,426 :: 		break;
	GOTO        L_keyHandler54
;alarme.c,428 :: 		case 189:
L_keyHandler65:
;alarme.c,429 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,430 :: 		result = 6;
	MOVLW       6
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,431 :: 		break;
	GOTO        L_keyHandler54
;alarme.c,433 :: 		case 125:
L_keyHandler66:
;alarme.c,434 :: 		*type = MULT;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       3
	MOVWF       POSTINC1+0 
;alarme.c,435 :: 		break;
	GOTO        L_keyHandler54
;alarme.c,437 :: 		case 238:
L_keyHandler67:
;alarme.c,438 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,439 :: 		result = 7;
	MOVLW       7
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,440 :: 		break;
	GOTO        L_keyHandler54
;alarme.c,442 :: 		case 222:
L_keyHandler68:
;alarme.c,443 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,444 :: 		result = 8;
	MOVLW       8
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,445 :: 		break;
	GOTO        L_keyHandler54
;alarme.c,447 :: 		case 190:
L_keyHandler69:
;alarme.c,448 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,449 :: 		result = 9;
	MOVLW       9
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,450 :: 		break;
	GOTO        L_keyHandler54
;alarme.c,452 :: 		case 126:
L_keyHandler70:
;alarme.c,453 :: 		*type = DIVI;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       4
	MOVWF       POSTINC1+0 
;alarme.c,454 :: 		break;
	GOTO        L_keyHandler54
;alarme.c,455 :: 		}
L_keyHandler53:
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler105
	MOVLW       231
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler105:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler55
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler106
	MOVLW       215
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler106:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler56
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler107
	MOVLW       183
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler107:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler57
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler108
	MOVLW       119
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler108:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler58
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler109
	MOVLW       235
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler109:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler59
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler110
	MOVLW       219
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler110:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler60
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler111
	MOVLW       187
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler111:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler61
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler112
	MOVLW       123
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler112:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler62
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler113
	MOVLW       237
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler113:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler63
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler114
	MOVLW       221
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler114:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler64
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler115
	MOVLW       189
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler115:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler65
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler116
	MOVLW       125
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler116:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler66
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler117
	MOVLW       238
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler117:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler67
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler118
	MOVLW       222
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler118:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler68
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler119
	MOVLW       190
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler119:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler69
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler120
	MOVLW       126
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler120:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler70
L_keyHandler54:
;alarme.c,457 :: 		return result;
	MOVF        keyHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keyHandler_result_L0+1, 0 
	MOVWF       R1 
;alarme.c,458 :: 		}
L_end_keyHandler:
	RETURN      0
; end of _keyHandler
