
_interrupt:

;Circuito4.c,8 :: 		void interrupt(void){
;Circuito4.c,9 :: 		if (INTCON.TMR0IF == 1){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;Circuito4.c,10 :: 		if(PORTD.RD0==0)
	BTFSC       PORTD+0, 0 
	GOTO        L_interrupt1
;Circuito4.c,12 :: 		TMR0H = COUNTER2 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       194
	MOVWF       TMR0H+0 
;Circuito4.c,13 :: 		TMR0L = COUNTER2;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       246
	MOVWF       TMR0L+0 
;Circuito4.c,14 :: 		PORTD.RD0=1;
	BSF         PORTD+0, 0 
;Circuito4.c,15 :: 		}
	GOTO        L_interrupt2
L_interrupt1:
;Circuito4.c,16 :: 		else if(PORTD.RD0==1)
	BTFSS       PORTD+0, 0 
	GOTO        L_interrupt3
;Circuito4.c,18 :: 		TMR0H = COUNTER1 >> 8;  // RE-Load Timer 0 counter - 1st TMR0H
	MOVLW       158
	MOVWF       TMR0H+0 
;Circuito4.c,19 :: 		TMR0L = COUNTER1;       // RE-Load Timer 0 counter - 2nd TMR0L
	MOVLW       87
	MOVWF       TMR0L+0 
;Circuito4.c,20 :: 		PORTD.RD0=0;
	BCF         PORTD+0, 0 
;Circuito4.c,21 :: 		}
L_interrupt3:
L_interrupt2:
;Circuito4.c,22 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;Circuito4.c,23 :: 		}
L_interrupt0:
;Circuito4.c,24 :: 		}
L_end_interrupt:
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;Circuito4.c,26 :: 		void main() {
;Circuito4.c,28 :: 		TRISD.RD0 = 0;  // digital output
	BCF         TRISD+0, 0 
;Circuito4.c,29 :: 		PORTD.RD0 = 0;  // LED off
	BCF         PORTD+0, 0 
;Circuito4.c,32 :: 		T0CON.T08BIT = 0;       // 16 bits
	BCF         T0CON+0, 6 
;Circuito4.c,33 :: 		T0CON.T0CS = 0;         // Internal clock => Crystal/4
	BCF         T0CON+0, 5 
;Circuito4.c,34 :: 		T0CON.PSA = 0;          // Prescaler ON
	BCF         T0CON+0, 3 
;Circuito4.c,37 :: 		T0CON.T0PS2 = 1;
	BSF         T0CON+0, 2 
;Circuito4.c,38 :: 		T0CON.T0PS1 = 1;
	BSF         T0CON+0, 1 
;Circuito4.c,39 :: 		T0CON.T0PS0 = 1;
	BSF         T0CON+0, 0 
;Circuito4.c,42 :: 		TMR0H = COUNTER1 >> 8;  // Load Timer 0 counter - 1st TMR0H
	MOVLW       158
	MOVWF       TMR0H+0 
;Circuito4.c,43 :: 		TMR0L = COUNTER1;       // Load Timer 0 counter - 2nd TMR0L
	MOVLW       87
	MOVWF       TMR0L+0 
;Circuito4.c,46 :: 		INTCON.TMR0IP = 1;
	BSF         INTCON+0, 2 
;Circuito4.c,47 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;Circuito4.c,48 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;Circuito4.c,49 :: 		INTCON.PEIE=0;
	BCF         INTCON+0, 6 
;Circuito4.c,50 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;Circuito4.c,52 :: 		T0CON.TMR0ON=1;         // Timer ON
	BSF         T0CON+0, 7 
;Circuito4.c,54 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
