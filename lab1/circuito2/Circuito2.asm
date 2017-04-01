
_interrupt:

;Circuito2.c,5 :: 		void interrupt(void){
;Circuito2.c,6 :: 		if(INTCON.INT0IF){
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt0
;Circuito2.c,7 :: 		PORTD.RD0 = flag;
	BTFSC       _flag+0, 0 
	GOTO        L__interrupt3
	BCF         PORTD+0, 0 
	GOTO        L__interrupt4
L__interrupt3:
	BSF         PORTD+0, 0 
L__interrupt4:
;Circuito2.c,9 :: 		INTCON.INT0IF=0;
	BCF         INTCON+0, 1 
;Circuito2.c,10 :: 		flag = !flag;
	MOVF        _flag+0, 0 
	IORWF       _flag+1, 0 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _flag+0 
	MOVLW       0
	MOVWF       _flag+1 
;Circuito2.c,11 :: 		}
L_interrupt0:
;Circuito2.c,12 :: 		}
L_end_interrupt:
L__interrupt2:
	RETFIE      1
; end of _interrupt

_main:

;Circuito2.c,14 :: 		void main() {
;Circuito2.c,16 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;Circuito2.c,19 :: 		TRISB.RB0 = 1; // digital input
	BSF         TRISB+0, 0 
;Circuito2.c,20 :: 		INTCON.INT0IF = 0;    // init flag with zero
	BCF         INTCON+0, 1 
;Circuito2.c,21 :: 		INTCON.INT0IE = 1;    // Interrupt is enabled
	BSF         INTCON+0, 4 
;Circuito2.c,24 :: 		TRISB.RB1 = 1; // digital input
	BSF         TRISB+0, 1 
;Circuito2.c,25 :: 		INTCON3.INT1IF = 0;    // init flag with zero
	BCF         INTCON3+0, 0 
;Circuito2.c,26 :: 		INTCON3.INT1IE = 1;    // Interrupt is enabled
	BSF         INTCON3+0, 3 
;Circuito2.c,29 :: 		TRISD.RD0 = 0;  // digital output
	BCF         TRISD+0, 0 
;Circuito2.c,30 :: 		PORTD.RD0 = 0;  // LED Off
	BCF         PORTD+0, 0 
;Circuito2.c,32 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
