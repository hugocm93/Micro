
_interrupt:

;alarme.c,64 :: 		void interrupt(void)
;alarme.c,66 :: 		if(INTCON.TMR0IF)
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;alarme.c,68 :: 		INTCON.TMR0IE=0;
	BCF         INTCON+0, 5 
;alarme.c,69 :: 		TMR0H = COUNTER >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       255
	MOVWF       TMR0H+0 
;alarme.c,70 :: 		TMR0L = COUNTER;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       245
	MOVWF       TMR0L+0 
;alarme.c,72 :: 		if(/*edge == 1 && */(timer2 > 0.02))
	MOVF        _timer2+0, 0 
	MOVWF       R4 
	MOVF        _timer2+1, 0 
	MOVWF       R5 
	MOVF        _timer2+2, 0 
	MOVWF       R6 
	MOVF        _timer2+3, 0 
	MOVWF       R7 
	MOVLW       10
	MOVWF       R0 
	MOVLW       215
	MOVWF       R1 
	MOVLW       35
	MOVWF       R2 
	MOVLW       121
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt1
;alarme.c,74 :: 		alarm();
	CALL        _alarm+0, 0
;alarme.c,75 :: 		timer2 = 0;
	CLRF        _timer2+0 
	CLRF        _timer2+1 
	CLRF        _timer2+2 
	CLRF        _timer2+3 
;alarme.c,76 :: 		}
L_interrupt1:
;alarme.c,78 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;alarme.c,79 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;alarme.c,80 :: 		timer += COUNTER;
	MOVF        _timer+0, 0 
	MOVWF       R0 
	MOVF        _timer+1, 0 
	MOVWF       R1 
	MOVF        _timer+2, 0 
	MOVWF       R2 
	MOVF        _timer+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       245
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       142
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _timer+0 
	MOVF        R1, 0 
	MOVWF       _timer+1 
	MOVF        R2, 0 
	MOVWF       _timer+2 
	MOVF        R3, 0 
	MOVWF       _timer+3 
;alarme.c,81 :: 		timer2 += COUNTER;
	MOVF        _timer2+0, 0 
	MOVWF       R0 
	MOVF        _timer2+1, 0 
	MOVWF       R1 
	MOVF        _timer2+2, 0 
	MOVWF       R2 
	MOVF        _timer2+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       245
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       142
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _timer2+0 
	MOVF        R1, 0 
	MOVWF       _timer2+1 
	MOVF        R2, 0 
	MOVWF       _timer2+2 
	MOVF        R3, 0 
	MOVWF       _timer2+3 
;alarme.c,82 :: 		}
L_interrupt0:
;alarme.c,84 :: 		if(INTCON.RBIF)
	BTFSS       INTCON+0, 0 
	GOTO        L_interrupt2
;alarme.c,86 :: 		if(/*edge == 1 && */(timer > 0.02))
	MOVF        _timer+0, 0 
	MOVWF       R4 
	MOVF        _timer+1, 0 
	MOVWF       R5 
	MOVF        _timer+2, 0 
	MOVWF       R6 
	MOVF        _timer+3, 0 
	MOVWF       R7 
	MOVLW       10
	MOVWF       R0 
	MOVLW       215
	MOVWF       R1 
	MOVLW       35
	MOVWF       R2 
	MOVLW       121
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt3
;alarme.c,88 :: 		keypadHandler();
	CALL        _keypadHandler+0, 0
;alarme.c,89 :: 		timer = 0;
	CLRF        _timer+0 
	CLRF        _timer+1 
	CLRF        _timer+2 
	CLRF        _timer+3 
;alarme.c,90 :: 		}
L_interrupt3:
;alarme.c,92 :: 		edge = !edge;
	MOVF        _edge+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _edge+0 
;alarme.c,93 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;alarme.c,94 :: 		}
L_interrupt2:
;alarme.c,95 :: 		}
L_end_interrupt:
L__interrupt80:
	RETFIE      1
; end of _interrupt

_main:

;alarme.c,97 :: 		void main()
;alarme.c,100 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;alarme.c,103 :: 		T0CON.T08BIT = 0;       // 16 bits
	BCF         T0CON+0, 6 
;alarme.c,104 :: 		T0CON.T0CS = 0;         // Internal clock => Crystal/4
	BCF         T0CON+0, 5 
;alarme.c,105 :: 		T0CON.PSA = 0;          // Prescaler ON
	BCF         T0CON+0, 3 
;alarme.c,108 :: 		T0CON.T0PS2 = 1;
	BSF         T0CON+0, 2 
;alarme.c,109 :: 		T0CON.T0PS1 = 1;
	BSF         T0CON+0, 1 
;alarme.c,110 :: 		T0CON.T0PS0 = 1;
	BSF         T0CON+0, 0 
;alarme.c,113 :: 		TMR0H = COUNTER >> 8;  // Load Timer 0 counter - 1st TMR0H
	MOVLW       255
	MOVWF       TMR0H+0 
;alarme.c,114 :: 		TMR0L = COUNTER;       // Load Timer 0 counter - 2nd TMR0L
	MOVLW       245
	MOVWF       TMR0L+0 
;alarme.c,117 :: 		INTCON.TMR0IP = 1;
	BSF         INTCON+0, 2 
;alarme.c,118 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;alarme.c,119 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;alarme.c,120 :: 		INTCON.PEIE=0;
	BCF         INTCON+0, 6 
;alarme.c,121 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;alarme.c,124 :: 		T0CON.TMR0ON=1;
	BSF         T0CON+0, 7 
;alarme.c,127 :: 		ADCON1 = 0x04;
	MOVLW       4
	MOVWF       ADCON1+0 
;alarme.c,131 :: 		TRISC.RC4 = 1;
	BSF         TRISC+0, 4 
;alarme.c,132 :: 		TRISC.RC5 = 1;
	BSF         TRISC+0, 5 
;alarme.c,133 :: 		TRISC.RC6 = 1;
	BSF         TRISC+0, 6 
;alarme.c,134 :: 		TRISC.RC7 = 1;
	BSF         TRISC+0, 7 
;alarme.c,136 :: 		TRISA.RA0 = 1;
	BSF         TRISA+0, 0 
;alarme.c,137 :: 		TRISA.RA1 = 1;
	BSF         TRISA+0, 1 
;alarme.c,140 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;alarme.c,141 :: 		INTCON.RBIE = 1;
	BSF         INTCON+0, 3 
;alarme.c,142 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;alarme.c,146 :: 		TRISB.RB4 = 1;
	BSF         TRISB+0, 4 
;alarme.c,147 :: 		TRISB.RB5 = 1;
	BSF         TRISB+0, 5 
;alarme.c,148 :: 		TRISB.RB6 = 1;
	BSF         TRISB+0, 6 
;alarme.c,149 :: 		TRISB.RB7 = 1;
	BSF         TRISB+0, 7 
;alarme.c,153 :: 		TRISB.RB0 = 0;
	BCF         TRISB+0, 0 
;alarme.c,154 :: 		TRISB.RB1 = 0;
	BCF         TRISB+0, 1 
;alarme.c,155 :: 		TRISB.RB2 = 0;
	BCF         TRISB+0, 2 
;alarme.c,156 :: 		TRISB.RB3 = 0;
	BCF         TRISB+0, 3 
;alarme.c,158 :: 		PORTB.RB0 = 0;
	BCF         PORTB+0, 0 
;alarme.c,159 :: 		PORTB.RB1 = 0;
	BCF         PORTB+0, 1 
;alarme.c,160 :: 		PORTB.RB2 = 0;
	BCF         PORTB+0, 2 
;alarme.c,161 :: 		PORTB.RB3 = 0;
	BCF         PORTB+0, 3 
;alarme.c,164 :: 		TRISC.RC0 = 0;
	BCF         TRISC+0, 0 
;alarme.c,165 :: 		TRISC.RC1 = 0;
	BCF         TRISC+0, 1 
;alarme.c,166 :: 		TRISC.RC2 = 0;
	BCF         TRISC+0, 2 
;alarme.c,167 :: 		TRISC.RC3 = 0;
	BCF         TRISC+0, 3 
;alarme.c,169 :: 		PORTC.RC0 = 0;
	BCF         PORTC+0, 0 
;alarme.c,170 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;alarme.c,171 :: 		PORTC.RC2 = 0;
	BCF         PORTC+0, 2 
;alarme.c,172 :: 		PORTC.RC3 = 0;
	BCF         PORTC+0, 3 
;alarme.c,173 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_alarm:

;alarme.c,176 :: 		void alarm()
;alarme.c,178 :: 		vSensor1 = (ADC_read(0)/1023.0) * 5;
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
;alarme.c,179 :: 		vSensor2 = (ADC_read(1)/1023.0) * 5;
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
;alarme.c,180 :: 		if(isOn)
	MOVF        _isOn+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm4
;alarme.c,182 :: 		char activated = 0;
;alarme.c,183 :: 		int sensorCount = 0;
	CLRF        alarm_sensorCount_L1+0 
	CLRF        alarm_sensorCount_L1+1 
;alarme.c,186 :: 		PORTC.RC0 = PORTC.RC4;
	BTFSC       PORTC+0, 4 
	GOTO        L__alarm83
	BCF         PORTC+0, 0 
	GOTO        L__alarm84
L__alarm83:
	BSF         PORTC+0, 0 
L__alarm84:
;alarme.c,187 :: 		PORTC.RC1 = PORTC.RC5;
	BTFSC       PORTC+0, 5 
	GOTO        L__alarm85
	BCF         PORTC+0, 1 
	GOTO        L__alarm86
L__alarm85:
	BSF         PORTC+0, 1 
L__alarm86:
;alarme.c,188 :: 		PORTC.RC2 = PORTC.RC6;
	BTFSC       PORTC+0, 6 
	GOTO        L__alarm87
	BCF         PORTC+0, 2 
	GOTO        L__alarm88
L__alarm87:
	BSF         PORTC+0, 2 
L__alarm88:
;alarme.c,189 :: 		PORTC.RC3 = PORTC.RC7;
	BTFSC       PORTC+0, 7 
	GOTO        L__alarm89
	BCF         PORTC+0, 3 
	GOTO        L__alarm90
L__alarm89:
	BSF         PORTC+0, 3 
L__alarm90:
;alarme.c,191 :: 		sensorCount += PORTC.RC4;
	CLRF        R0 
	BTFSC       PORTC+0, 4 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,192 :: 		sensorCount += PORTC.RC5;
	CLRF        R0 
	BTFSC       PORTC+0, 5 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,193 :: 		sensorCount += PORTC.RC6;
	CLRF        R0 
	BTFSC       PORTC+0, 6 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,194 :: 		sensorCount += PORTC.RC7;
	CLRF        R0 
	BTFSC       PORTC+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,195 :: 		sensorCount += vSensor1 >= 4 ? 1 : 0;
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
	GOTO        L_alarm5
	MOVLW       1
	MOVWF       ?FLOC___alarmT128+0 
	GOTO        L_alarm6
L_alarm5:
	CLRF        ?FLOC___alarmT128+0 
L_alarm6:
	MOVF        ?FLOC___alarmT128+0, 0 
	ADDWF       alarm_sensorCount_L1+0, 1 
	MOVLW       0
	BTFSC       ?FLOC___alarmT128+0, 7 
	MOVLW       255
	ADDWFC      alarm_sensorCount_L1+1, 1 
;alarme.c,196 :: 		sensorCount += vSensor2 > 3 ? 1 : 0;
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
	GOTO        L_alarm7
	MOVLW       1
	MOVWF       ?FLOC___alarmT131+0 
	GOTO        L_alarm8
L_alarm7:
	CLRF        ?FLOC___alarmT131+0 
L_alarm8:
	MOVF        ?FLOC___alarmT131+0, 0 
	ADDWF       alarm_sensorCount_L1+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       ?FLOC___alarmT131+0, 7 
	MOVLW       255
	ADDWFC      alarm_sensorCount_L1+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       alarm_sensorCount_L1+0 
	MOVF        R2, 0 
	MOVWF       alarm_sensorCount_L1+1 
;alarme.c,198 :: 		activated = sensorCount >= 2 ? 1 : 0;
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__alarm91
	MOVLW       2
	SUBWF       R1, 0 
L__alarm91:
	BTFSS       STATUS+0, 0 
	GOTO        L_alarm9
	MOVLW       1
	MOVWF       ?FLOC___alarmT134+0 
	GOTO        L_alarm10
L_alarm9:
	CLRF        ?FLOC___alarmT134+0 
L_alarm10:
;alarme.c,200 :: 		if(activated)
	MOVF        ?FLOC___alarmT134+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm11
;alarme.c,204 :: 		IntToStr(sensorCount, number);
	MOVF        alarm_sensorCount_L1+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        alarm_sensorCount_L1+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       alarm_number_L2+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(alarm_number_L2+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;alarme.c,206 :: 		strcat(str, msg1);
	MOVLW       alarm_str_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _msg1+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_msg1+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,207 :: 		strcat(str, number);
	MOVLW       alarm_str_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       alarm_number_L2+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(alarm_number_L2+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,208 :: 		strcat(str, msg2);
	MOVLW       alarm_str_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _msg2+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_msg2+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,210 :: 		if(strcmp(lastText, str))
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
	GOTO        L_alarm12
;alarme.c,212 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;alarme.c,213 :: 		strcpy(lastText, str);
	MOVLW       _lastText+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_lastText+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       alarm_str_L2+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;alarme.c,215 :: 		Lcd_Out(1,1,str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       alarm_str_L2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(alarm_str_L2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,216 :: 		}
L_alarm12:
;alarme.c,217 :: 		}
	GOTO        L_alarm13
L_alarm11:
;alarme.c,223 :: 		if(PORTC.RC4)
	BTFSS       PORTC+0, 4 
	GOTO        L_alarm14
;alarme.c,224 :: 		strcpy(number, "1");
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
;alarme.c,226 :: 		if(PORTC.RC5)
	BTFSS       PORTC+0, 5 
	GOTO        L_alarm15
;alarme.c,227 :: 		strcpy(number, "2");
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
;alarme.c,229 :: 		if(PORTC.RC6)
	BTFSS       PORTC+0, 6 
	GOTO        L_alarm16
;alarme.c,230 :: 		strcpy(number, "3");
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
;alarme.c,232 :: 		if(PORTC.RC7)
	BTFSS       PORTC+0, 7 
	GOTO        L_alarm17
;alarme.c,233 :: 		strcpy(number, "4");
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
;alarme.c,235 :: 		if(vSensor1 >= 4)
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
;alarme.c,236 :: 		strcpy(number, "5");
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
;alarme.c,238 :: 		if(vSensor2 > 3)
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
;alarme.c,239 :: 		strcpy(number, "6");
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
;alarme.c,242 :: 		strcat(str, msg3);
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _msg3+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_msg3+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,243 :: 		strcat(str, number);
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       alarm_number_L2_L2+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(alarm_number_L2_L2+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,244 :: 		strcat(str, msg4);
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _msg4+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_msg4+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,246 :: 		if(strcmp(lastText, str))
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
	GOTO        L_alarm20
;alarme.c,248 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;alarme.c,249 :: 		strcpy(lastText, str);
	MOVLW       _lastText+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_lastText+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;alarme.c,251 :: 		Lcd_Out(1,1,str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       alarm_str_L2_L2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(alarm_str_L2_L2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,252 :: 		}
L_alarm20:
;alarme.c,253 :: 		}
L_alarm13:
;alarme.c,254 :: 		}
	GOTO        L_alarm21
L_alarm4:
;alarme.c,262 :: 		IntToStr(vSensor1, str1);
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
;alarme.c,263 :: 		IntToStr(vSensor2, str2);
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
;alarme.c,265 :: 		strcat(str, str1);
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       alarm_str1_L1+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(alarm_str1_L1+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,266 :: 		strcat(str, "V ");
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr7_alarme+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr7_alarme+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,267 :: 		strcat(str, str2);
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       alarm_str2_L1+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(alarm_str2_L1+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,268 :: 		strcat(str, "V");
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr8_alarme+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr8_alarme+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;alarme.c,270 :: 		if(strcmp(lastText, str))
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
	GOTO        L_alarm22
;alarme.c,272 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;alarme.c,273 :: 		strcpy(lastText, str);
	MOVLW       _lastText+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_lastText+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;alarme.c,275 :: 		Lcd_Out(1,1,str);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       alarm_str_L1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(alarm_str_L1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;alarme.c,276 :: 		}
L_alarm22:
;alarme.c,277 :: 		}
L_alarm21:
;alarme.c,278 :: 		}
L_end_alarm:
	RETURN      0
; end of _alarm

_keypadHandler:

;alarme.c,281 :: 		void keypadHandler()
;alarme.c,288 :: 		for(i = 0, columnCode = 0x0f; (i < 4) && (columnCode==0x0f); i++)
	CLRF        keypadHandler_i_L0+0 
	MOVLW       15
	MOVWF       _columnCode+0 
L_keypadHandler23:
	MOVLW       4
	SUBWF       keypadHandler_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadHandler24
	MOVF        _columnCode+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler24
L__keypadHandler78:
;alarme.c,290 :: 		PORTB.RB0 = 1; // digital output
	BSF         PORTB+0, 0 
;alarme.c,291 :: 		PORTB.RB1 = 1;
	BSF         PORTB+0, 1 
;alarme.c,292 :: 		PORTB.RB2 = 1;
	BSF         PORTB+0, 2 
;alarme.c,293 :: 		PORTB.RB3 = 1;
	BSF         PORTB+0, 3 
;alarme.c,294 :: 		if(i==0)PORTB.RB0 = 0; // digital output
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler28
	BCF         PORTB+0, 0 
L_keypadHandler28:
;alarme.c,295 :: 		if(i==1)PORTB.RB1 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler29
	BCF         PORTB+0, 1 
L_keypadHandler29:
;alarme.c,296 :: 		if(i==2)PORTB.RB2 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler30
	BCF         PORTB+0, 2 
L_keypadHandler30:
;alarme.c,297 :: 		if(i==3)PORTB.RB3 = 0;
	MOVF        keypadHandler_i_L0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler31
	BCF         PORTB+0, 3 
L_keypadHandler31:
;alarme.c,298 :: 		columnCode = PORTB >> 4;
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
	MOVWF       _columnCode+0 
;alarme.c,288 :: 		for(i = 0, columnCode = 0x0f; (i < 4) && (columnCode==0x0f); i++)
	INCF        keypadHandler_i_L0+0, 1 
;alarme.c,299 :: 		}
	GOTO        L_keypadHandler23
L_keypadHandler24:
;alarme.c,300 :: 		result = keyHandler(PORTB, &type);
	MOVF        PORTB+0, 0 
	MOVWF       FARG_keyHandler_key+0 
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
;alarme.c,301 :: 		PORTB.RB0 = 0; // digital output
	BCF         PORTB+0, 0 
;alarme.c,302 :: 		PORTB.RB1 = 0;
	BCF         PORTB+0, 1 
;alarme.c,303 :: 		PORTB.RB2 = 0;
	BCF         PORTB+0, 2 
;alarme.c,304 :: 		PORTB.RB3 = 0;
	BCF         PORTB+0, 3 
;alarme.c,306 :: 		if(edge == 1)
	MOVF        _edge+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler32
;alarme.c,308 :: 		if(type == NUM)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler33
;alarme.c,310 :: 		if(result == 0)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler93
	MOVLW       0
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler93:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler34
;alarme.c,311 :: 		nKeyPressed = "0";
	MOVLW       ?lstr_9_alarme+0
	MOVWF       _nKeyPressed+0 
L_keypadHandler34:
;alarme.c,313 :: 		if(result == 1)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler94
	MOVLW       1
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler94:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler35
;alarme.c,314 :: 		nKeyPressed = "1";
	MOVLW       ?lstr_10_alarme+0
	MOVWF       _nKeyPressed+0 
L_keypadHandler35:
;alarme.c,316 :: 		if(result == 2)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler95
	MOVLW       2
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler95:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler36
;alarme.c,317 :: 		nKeyPressed = "2";
	MOVLW       ?lstr_11_alarme+0
	MOVWF       _nKeyPressed+0 
L_keypadHandler36:
;alarme.c,319 :: 		if(result == 3)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler96
	MOVLW       3
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler96:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler37
;alarme.c,320 :: 		nKeyPressed = "3";
	MOVLW       ?lstr_12_alarme+0
	MOVWF       _nKeyPressed+0 
L_keypadHandler37:
;alarme.c,322 :: 		if(result == 4)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler97
	MOVLW       4
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler97:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler38
;alarme.c,323 :: 		nKeyPressed = "4";
	MOVLW       ?lstr_13_alarme+0
	MOVWF       _nKeyPressed+0 
L_keypadHandler38:
;alarme.c,325 :: 		if(result == 5)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler98
	MOVLW       5
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler98:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler39
;alarme.c,326 :: 		nKeyPressed = "5";
	MOVLW       ?lstr_14_alarme+0
	MOVWF       _nKeyPressed+0 
L_keypadHandler39:
;alarme.c,328 :: 		if(result == 6)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler99
	MOVLW       6
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler99:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler40
;alarme.c,329 :: 		nKeyPressed = "6";
	MOVLW       ?lstr_15_alarme+0
	MOVWF       _nKeyPressed+0 
L_keypadHandler40:
;alarme.c,331 :: 		if(result == 7)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler100
	MOVLW       7
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler100:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler41
;alarme.c,332 :: 		nKeyPressed = "7";
	MOVLW       ?lstr_16_alarme+0
	MOVWF       _nKeyPressed+0 
L_keypadHandler41:
;alarme.c,334 :: 		if(result == 8)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler101
	MOVLW       8
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler101:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler42
;alarme.c,335 :: 		nKeyPressed = "8";
	MOVLW       ?lstr_17_alarme+0
	MOVWF       _nKeyPressed+0 
L_keypadHandler42:
;alarme.c,337 :: 		if(result == 9)
	MOVLW       0
	XORWF       keypadHandler_result_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler102
	MOVLW       9
	XORWF       keypadHandler_result_L0+0, 0 
L__keypadHandler102:
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler43
;alarme.c,338 :: 		nKeyPressed = "9";
	MOVLW       ?lstr_18_alarme+0
	MOVWF       _nKeyPressed+0 
L_keypadHandler43:
;alarme.c,339 :: 		}
L_keypadHandler33:
;alarme.c,341 :: 		if(type == SUM)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler44
;alarme.c,342 :: 		nKeyPressed = "+";
	MOVLW       ?lstr_19_alarme+0
	MOVWF       _nKeyPressed+0 
L_keypadHandler44:
;alarme.c,344 :: 		if(type == SUB)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler45
;alarme.c,345 :: 		nKeyPressed = "-";
	MOVLW       ?lstr_20_alarme+0
	MOVWF       _nKeyPressed+0 
L_keypadHandler45:
;alarme.c,347 :: 		if(type == MULT)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler46
;alarme.c,348 :: 		nKeyPressed = "*";
	MOVLW       ?lstr_21_alarme+0
	MOVWF       _nKeyPressed+0 
L_keypadHandler46:
;alarme.c,350 :: 		if(type == DIVI)
	MOVF        keypadHandler_type_L0+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler47
;alarme.c,351 :: 		nKeyPressed = "/";
	MOVLW       ?lstr_22_alarme+0
	MOVWF       _nKeyPressed+0 
L_keypadHandler47:
;alarme.c,353 :: 		rightKeysActivation[nKeyPressed] = (activationCode[nKeyPressed] != keyPressed[0]) == 0 ? 1 : 0;
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
	GOTO        L_keypadHandler48
	MOVLW       1
	MOVWF       ?FLOC___keypadHandlerT267+0 
	GOTO        L_keypadHandler49
L_keypadHandler48:
	CLRF        ?FLOC___keypadHandlerT267+0 
L_keypadHandler49:
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        ?FLOC___keypadHandlerT267+0, 0 
	MOVWF       POSTINC1+0 
;alarme.c,354 :: 		rightKeysDeActivation[nKeyPressed] = (DeActivationCode[nKeyPressed] != keyPressed[0]) == 0 ? 1 : 0;
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
	GOTO        L_keypadHandler50
	MOVLW       1
	MOVWF       ?FLOC___keypadHandlerT278+0 
	GOTO        L_keypadHandler51
L_keypadHandler50:
	CLRF        ?FLOC___keypadHandlerT278+0 
L_keypadHandler51:
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        ?FLOC___keypadHandlerT278+0, 0 
	MOVWF       POSTINC1+0 
;alarme.c,356 :: 		if(nKeyPressed == 6)
	MOVF        _nKeyPressed+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler52
;alarme.c,359 :: 		char activationCounter = 0;
	CLRF        keypadHandler_activationCounter_L2+0 
	CLRF        keypadHandler_deActivationCounter_L2+0 
;alarme.c,361 :: 		for(i = 0; i < nKeyPressed; i++)
	CLRF        keypadHandler_i_L2+0 
	CLRF        keypadHandler_i_L2+1 
L_keypadHandler53:
	MOVLW       128
	XORWF       keypadHandler_i_L2+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keypadHandler103
	MOVF        _nKeyPressed+0, 0 
	SUBWF       keypadHandler_i_L2+0, 0 
L__keypadHandler103:
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadHandler54
;alarme.c,363 :: 		activationCounter += rightKeysActivation[i];
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
;alarme.c,364 :: 		deActivationCounter += rightKeysDeActivation[i];
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
;alarme.c,361 :: 		for(i = 0; i < nKeyPressed; i++)
	INFSNZ      keypadHandler_i_L2+0, 1 
	INCF        keypadHandler_i_L2+1, 1 
;alarme.c,365 :: 		}
	GOTO        L_keypadHandler53
L_keypadHandler54:
;alarme.c,367 :: 		if(activationCounter == 6)
	MOVF        keypadHandler_activationCounter_L2+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler56
;alarme.c,369 :: 		isOn = 1;
	MOVLW       1
	MOVWF       _isOn+0 
;alarme.c,370 :: 		}
L_keypadHandler56:
;alarme.c,372 :: 		if(deActivationCounter == 6)
	MOVF        keypadHandler_deActivationCounter_L2+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler57
;alarme.c,374 :: 		isOn = 0;
	CLRF        _isOn+0 
;alarme.c,375 :: 		}
L_keypadHandler57:
;alarme.c,376 :: 		}
L_keypadHandler52:
;alarme.c,378 :: 		nKeyPressed = nKeyPressed == 6 ? 0 : nKeyPressed++;
	MOVF        _nKeyPressed+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadHandler58
	CLRF        ?FLOC___keypadHandlerT295+0 
	GOTO        L_keypadHandler59
L_keypadHandler58:
	MOVF        _nKeyPressed+0, 0 
	MOVWF       R1 
	MOVF        _nKeyPressed+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _nKeyPressed+0 
	MOVF        R1, 0 
	MOVWF       ?FLOC___keypadHandlerT295+0 
L_keypadHandler59:
	MOVF        ?FLOC___keypadHandlerT295+0, 0 
	MOVWF       _nKeyPressed+0 
;alarme.c,379 :: 		}
L_keypadHandler32:
;alarme.c,380 :: 		}
L_end_keypadHandler:
	RETURN      0
; end of _keypadHandler

_keyHandler:

;alarme.c,383 :: 		int keyHandler (int key, KeyType* type)
;alarme.c,385 :: 		int result = -1;
	MOVLW       255
	MOVWF       keyHandler_result_L0+0 
	MOVLW       255
	MOVWF       keyHandler_result_L0+1 
;alarme.c,386 :: 		switch(key)
	GOTO        L_keyHandler60
;alarme.c,388 :: 		case 231:
L_keyHandler62:
;alarme.c,389 :: 		*type = ON_CLEAR;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       5
	MOVWF       POSTINC1+0 
;alarme.c,390 :: 		break;
	GOTO        L_keyHandler61
;alarme.c,392 :: 		case 215:
L_keyHandler63:
;alarme.c,393 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,394 :: 		result = 0;
	CLRF        keyHandler_result_L0+0 
	CLRF        keyHandler_result_L0+1 
;alarme.c,395 :: 		break;
	GOTO        L_keyHandler61
;alarme.c,397 :: 		case 183:
L_keyHandler64:
;alarme.c,398 :: 		*type = EQUALS;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	CLRF        POSTINC1+0 
;alarme.c,399 :: 		break;
	GOTO        L_keyHandler61
;alarme.c,401 :: 		case 119:
L_keyHandler65:
;alarme.c,402 :: 		*type = SUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       1
	MOVWF       POSTINC1+0 
;alarme.c,403 :: 		break;
	GOTO        L_keyHandler61
;alarme.c,405 :: 		case 235:
L_keyHandler66:
;alarme.c,406 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,407 :: 		result = 7;
	MOVLW       7
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,408 :: 		break;
	GOTO        L_keyHandler61
;alarme.c,410 :: 		case 219:
L_keyHandler67:
;alarme.c,411 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,412 :: 		result = 8;
	MOVLW       8
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,413 :: 		break;
	GOTO        L_keyHandler61
;alarme.c,415 :: 		case 187:
L_keyHandler68:
;alarme.c,416 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,417 :: 		result = 9;
	MOVLW       9
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,418 :: 		break;
	GOTO        L_keyHandler61
;alarme.c,420 :: 		case 123:
L_keyHandler69:
;alarme.c,421 :: 		*type = SUB;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       2
	MOVWF       POSTINC1+0 
;alarme.c,422 :: 		break;
	GOTO        L_keyHandler61
;alarme.c,424 :: 		case 237:
L_keyHandler70:
;alarme.c,425 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,426 :: 		result = 4;
	MOVLW       4
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,427 :: 		break;
	GOTO        L_keyHandler61
;alarme.c,429 :: 		case 221:
L_keyHandler71:
;alarme.c,430 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,431 :: 		result = 5;
	MOVLW       5
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,432 :: 		break;
	GOTO        L_keyHandler61
;alarme.c,434 :: 		case 189:
L_keyHandler72:
;alarme.c,435 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,436 :: 		result = 6;
	MOVLW       6
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,437 :: 		break;
	GOTO        L_keyHandler61
;alarme.c,439 :: 		case 125:
L_keyHandler73:
;alarme.c,440 :: 		*type = MULT;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       3
	MOVWF       POSTINC1+0 
;alarme.c,441 :: 		break;
	GOTO        L_keyHandler61
;alarme.c,443 :: 		case 238:
L_keyHandler74:
;alarme.c,444 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,445 :: 		result = 1;
	MOVLW       1
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,446 :: 		break;
	GOTO        L_keyHandler61
;alarme.c,448 :: 		case 222:
L_keyHandler75:
;alarme.c,449 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,450 :: 		result = 2;
	MOVLW       2
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,451 :: 		break;
	GOTO        L_keyHandler61
;alarme.c,453 :: 		case 190:
L_keyHandler76:
;alarme.c,454 :: 		*type = NUM;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       6
	MOVWF       POSTINC1+0 
;alarme.c,455 :: 		result = 3;
	MOVLW       3
	MOVWF       keyHandler_result_L0+0 
	MOVLW       0
	MOVWF       keyHandler_result_L0+1 
;alarme.c,456 :: 		break;
	GOTO        L_keyHandler61
;alarme.c,458 :: 		case 126:
L_keyHandler77:
;alarme.c,459 :: 		*type = DIVI;
	MOVFF       FARG_keyHandler_type+0, FSR1
	MOVFF       FARG_keyHandler_type+1, FSR1H
	MOVLW       4
	MOVWF       POSTINC1+0 
;alarme.c,460 :: 		break;
	GOTO        L_keyHandler61
;alarme.c,461 :: 		}
L_keyHandler60:
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler105
	MOVLW       231
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler105:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler62
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler106
	MOVLW       215
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler106:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler63
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler107
	MOVLW       183
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler107:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler64
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler108
	MOVLW       119
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler108:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler65
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler109
	MOVLW       235
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler109:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler66
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler110
	MOVLW       219
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler110:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler67
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler111
	MOVLW       187
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler111:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler68
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler112
	MOVLW       123
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler112:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler69
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler113
	MOVLW       237
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler113:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler70
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler114
	MOVLW       221
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler114:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler71
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler115
	MOVLW       189
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler115:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler72
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler116
	MOVLW       125
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler116:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler73
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler117
	MOVLW       238
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler117:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler74
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler118
	MOVLW       222
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler118:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler75
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler119
	MOVLW       190
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler119:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler76
	MOVLW       0
	XORWF       FARG_keyHandler_key+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__keyHandler120
	MOVLW       126
	XORWF       FARG_keyHandler_key+0, 0 
L__keyHandler120:
	BTFSC       STATUS+0, 2 
	GOTO        L_keyHandler77
L_keyHandler61:
;alarme.c,463 :: 		return result;
	MOVF        keyHandler_result_L0+0, 0 
	MOVWF       R0 
	MOVF        keyHandler_result_L0+1, 0 
	MOVWF       R1 
;alarme.c,464 :: 		}
L_end_keyHandler:
	RETURN      0
; end of _keyHandler
