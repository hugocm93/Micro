
_main:

;Circuito5.c,13 :: 		void main()
;Circuito5.c,16 :: 		TRISD.RD0 = 0;  // digital output
	BCF         TRISD+0, 0 
;Circuito5.c,17 :: 		PORTD.RD0 = 0;  // LED off
	BCF         PORTD+0, 0 
;Circuito5.c,19 :: 		pulses1 = calcPulses(3.2, 256);
	MOVLW       205
	MOVWF       FARG_calcPulses_seconds+0 
	MOVLW       204
	MOVWF       FARG_calcPulses_seconds+1 
	MOVLW       76
	MOVWF       FARG_calcPulses_seconds+2 
	MOVLW       128
	MOVWF       FARG_calcPulses_seconds+3 
	MOVLW       0
	MOVWF       FARG_calcPulses_scale+0 
	CALL        _calcPulses+0, 0
	MOVF        R0, 0 
	MOVWF       _pulses1+0 
	MOVF        R1, 0 
	MOVWF       _pulses1+1 
;Circuito5.c,20 :: 		pulses2 = calcPulses(2, 16);
	MOVLW       0
	MOVWF       FARG_calcPulses_seconds+0 
	MOVLW       0
	MOVWF       FARG_calcPulses_seconds+1 
	MOVLW       0
	MOVWF       FARG_calcPulses_seconds+2 
	MOVLW       128
	MOVWF       FARG_calcPulses_seconds+3 
	MOVLW       16
	MOVWF       FARG_calcPulses_scale+0 
	CALL        _calcPulses+0, 0
	MOVF        R0, 0 
	MOVWF       _pulses2+0 
	MOVF        R1, 0 
	MOVWF       _pulses2+1 
;Circuito5.c,23 :: 		setupCounter(0, pulses1);
	CLRF        FARG_setupCounter_counterNumber+0 
	MOVF        _pulses1+0, 0 
	MOVWF       FARG_setupCounter_pulses+0 
	CALL        _setupCounter+0, 0
;Circuito5.c,26 :: 		setupCounter(1, pulses2);
	MOVLW       1
	MOVWF       FARG_setupCounter_counterNumber+0 
	MOVF        _pulses2+0, 0 
	MOVWF       FARG_setupCounter_pulses+0 
	CALL        _setupCounter+0, 0
;Circuito5.c,27 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;Circuito5.c,30 :: 		void interrupt(void)
;Circuito5.c,32 :: 		if (INTCON.TMR0IF)
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;Circuito5.c,34 :: 		PORTD.RD0 = 1;
	BSF         PORTD+0, 0 
;Circuito5.c,36 :: 		TMR2 = pulses2;
	MOVF        _pulses2+0, 0 
	MOVWF       TMR2+0 
;Circuito5.c,38 :: 		INTCON.TMR2IF=0;
	BCF         INTCON+0, 1 
;Circuito5.c,39 :: 		}
	GOTO        L_interrupt1
L_interrupt0:
;Circuito5.c,40 :: 		else if (INTCON.TMR2IF)
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt2
;Circuito5.c,42 :: 		PORTD.RD0 = 0;
	BCF         PORTD+0, 0 
;Circuito5.c,44 :: 		TMR0H = pulses1 >> 8;
	MOVF        _pulses1+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _pulses1+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;Circuito5.c,45 :: 		TMR0L = pulses1;
	MOVF        _pulses1+0, 0 
	MOVWF       TMR0L+0 
;Circuito5.c,47 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;Circuito5.c,48 :: 		}
L_interrupt2:
L_interrupt1:
;Circuito5.c,49 :: 		}
L_end_interrupt:
L__interrupt9:
	RETFIE      1
; end of _interrupt

_setupCounter:

;Circuito5.c,52 :: 		void setupCounter(char counterNumber, short pulses)
;Circuito5.c,54 :: 		switch(counterNumber)
	GOTO        L_setupCounter3
;Circuito5.c,56 :: 		case 0:
L_setupCounter5:
;Circuito5.c,58 :: 		T0CON.T08BIT = 0;       // 16 bits
	BCF         T0CON+0, 6 
;Circuito5.c,59 :: 		T0CON.T0CS = 0;         // Internal clock => Crystal/4
	BCF         T0CON+0, 5 
;Circuito5.c,60 :: 		T0CON.PSA = 0;          // Prescaler ON
	BCF         T0CON+0, 3 
;Circuito5.c,63 :: 		T0CON.T0PS2 = 1;
	BSF         T0CON+0, 2 
;Circuito5.c,64 :: 		T0CON.T0PS1 = 1;
	BSF         T0CON+0, 1 
;Circuito5.c,65 :: 		T0CON.T0PS0 = 1;
	BSF         T0CON+0, 0 
;Circuito5.c,68 :: 		TMR0H = pulses >> 8;  // Load Timer 0 counter - 1st TMR0H
	MOVLW       0
	BTFSC       FARG_setupCounter_pulses+0, 7 
	MOVLW       255
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;Circuito5.c,69 :: 		TMR0L = pulses;       // Load Timer 0 counter - 2nd TMR0L
	MOVF        FARG_setupCounter_pulses+0, 0 
	MOVWF       TMR0L+0 
;Circuito5.c,72 :: 		INTCON.TMR0IP = 1;
	BSF         INTCON+0, 2 
;Circuito5.c,73 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;Circuito5.c,74 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;Circuito5.c,75 :: 		INTCON.PEIE=0;
	BCF         INTCON+0, 6 
;Circuito5.c,76 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;Circuito5.c,78 :: 		T0CON.TMR0ON=1;         // Timer ON
	BSF         T0CON+0, 7 
;Circuito5.c,79 :: 		break;
	GOTO        L_setupCounter4
;Circuito5.c,81 :: 		case 1:
L_setupCounter6:
;Circuito5.c,83 :: 		T2CON.T2CKPS1 = 1;
	BSF         T2CON+0, 1 
;Circuito5.c,84 :: 		T2CON.T2CKPS0 = 1;
	BSF         T2CON+0, 0 
;Circuito5.c,87 :: 		TMR2 = pulses;  // Load Timer 2 counter
	MOVF        FARG_setupCounter_pulses+0, 0 
	MOVWF       TMR2+0 
;Circuito5.c,90 :: 		INTCON.TMR2IP = 1;
	BSF         INTCON+0, 1 
;Circuito5.c,91 :: 		INTCON.TMR2IF=0;
	BCF         INTCON+0, 1 
;Circuito5.c,92 :: 		INTCON.TMR2IE=1;
	BSF         INTCON+0, 1 
;Circuito5.c,93 :: 		INTCON.PEIE=0;
	BCF         INTCON+0, 6 
;Circuito5.c,94 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;Circuito5.c,97 :: 		T2CON.TMR2ON = 1;       // On
	BSF         T2CON+0, 2 
;Circuito5.c,98 :: 		break;
	GOTO        L_setupCounter4
;Circuito5.c,99 :: 		}
L_setupCounter3:
	MOVF        FARG_setupCounter_counterNumber+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_setupCounter5
	MOVF        FARG_setupCounter_counterNumber+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_setupCounter6
L_setupCounter4:
;Circuito5.c,100 :: 		}
L_end_setupCounter:
	RETURN      0
; end of _setupCounter

_calcPulses:

;Circuito5.c,103 :: 		int calcPulses(float seconds, char scale)
;Circuito5.c,105 :: 		float pulseDuration = 1/(clockFrequency / (float)scale);
	MOVF        FARG_calcPulses_scale+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       36
	MOVWF       R1 
	MOVLW       116
	MOVWF       R2 
	MOVLW       148
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       127
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
;Circuito5.c,106 :: 		short pulses = seconds / pulseDuration;
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FARG_calcPulses_seconds+0, 0 
	MOVWF       R0 
	MOVF        FARG_calcPulses_seconds+1, 0 
	MOVWF       R1 
	MOVF        FARG_calcPulses_seconds+2, 0 
	MOVWF       R2 
	MOVF        FARG_calcPulses_seconds+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	CALL        _double2int+0, 0
;Circuito5.c,108 :: 		return (0xffff - pulses);
	MOVF        R0, 0 
	SUBLW       255
	MOVWF       R0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       255
	SUBFWB      R1, 1 
;Circuito5.c,109 :: 		}
L_end_calcPulses:
	RETURN      0
; end of _calcPulses
