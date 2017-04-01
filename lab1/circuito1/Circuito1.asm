
_interrupt:

;Circuito1.c,2 :: 		void interrupt(void){
;Circuito1.c,3 :: 		if (INTCON.INT0IF){
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt0
;Circuito1.c,4 :: 		PORTD.RD0 = 1;   // led on
	BSF         PORTD+0, 0 
;Circuito1.c,5 :: 		INTCON.INT0IF=0;
	BCF         INTCON+0, 1 
;Circuito1.c,6 :: 		}
	GOTO        L_interrupt1
L_interrupt0:
;Circuito1.c,7 :: 		else if (INTCON3.INT1IF){
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt2
;Circuito1.c,8 :: 		PORTD.RD0 = 0;   //led off
	BCF         PORTD+0, 0 
;Circuito1.c,9 :: 		INTCON3.INT1IF=0;
	BCF         INTCON3+0, 0 
;Circuito1.c,10 :: 		}
L_interrupt2:
L_interrupt1:
;Circuito1.c,11 :: 		}
L_end_interrupt:
L__interrupt4:
	RETFIE      1
; end of _interrupt

_main:

;Circuito1.c,13 :: 		void main() {
;Circuito1.c,15 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;Circuito1.c,18 :: 		TRISB.RB0 = 1; // digital input
	BSF         TRISB+0, 0 
;Circuito1.c,19 :: 		INTCON.INT0IF = 0;    // init flag with zero
	BCF         INTCON+0, 1 
;Circuito1.c,20 :: 		INTCON.INT0IE = 1;    // Interrupt is enabled
	BSF         INTCON+0, 4 
;Circuito1.c,23 :: 		TRISB.RB1 = 1; // digital input
	BSF         TRISB+0, 1 
;Circuito1.c,24 :: 		INTCON3.INT1IF = 0;    // init flag with zero
	BCF         INTCON3+0, 0 
;Circuito1.c,25 :: 		INTCON3.INT1IE = 1;    // Interrupt is enabled
	BSF         INTCON3+0, 3 
;Circuito1.c,28 :: 		TRISD.RD0 = 0;  // digital output
	BCF         TRISD+0, 0 
;Circuito1.c,29 :: 		PORTD.RD0 = 0;  // LED Off
	BCF         PORTD+0, 0 
;Circuito1.c,31 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
