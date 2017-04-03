
_interrupt:

;Circuito3.c,3 :: 		void interrupt(void){
;Circuito3.c,4 :: 		if(INTCON.RBIF){
	BTFSS       INTCON+0, 0 
	GOTO        L_interrupt0
;Circuito3.c,5 :: 		PORTD.RD0 = ~PORTD.RD0;
	BTG         PORTD+0, 0 
;Circuito3.c,6 :: 		xx = PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       _xx+0 
;Circuito3.c,7 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;Circuito3.c,8 :: 		}
L_interrupt0:
;Circuito3.c,9 :: 		}
L_end_interrupt:
L__interrupt2:
	RETFIE      1
; end of _interrupt

_main:

;Circuito3.c,11 :: 		void main() {
;Circuito3.c,13 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;Circuito3.c,16 :: 		TRISB.RB4 = 1; // digital input
	BSF         TRISB+0, 4 
;Circuito3.c,18 :: 		INTCON.RBIE = 1;
	BSF         INTCON+0, 3 
;Circuito3.c,19 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;Circuito3.c,22 :: 		TRISD.RD0 = 0;  // digital output
	BCF         TRISD+0, 0 
;Circuito3.c,23 :: 		PORTD.RD0 = 0;  // LED Off
	BCF         PORTD+0, 0 
;Circuito3.c,25 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
