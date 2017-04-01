
_interrupt:

;Circuito3.c,2 :: 		void interrupt(void){
;Circuito3.c,3 :: 		if(INTCON3.INT1IF){
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt0
;Circuito3.c,4 :: 		PORTD.RD0 = 0;
	BCF         PORTD+0, 0 
;Circuito3.c,5 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Circuito3.c,6 :: 		}
	GOTO        L_interrupt1
L_interrupt0:
;Circuito3.c,7 :: 		else if(INTCON3.INT2IF){
	BTFSS       INTCON3+0, 1 
	GOTO        L_interrupt2
;Circuito3.c,8 :: 		PORTD.RD0 = 1;
	BSF         PORTD+0, 0 
;Circuito3.c,9 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Circuito3.c,10 :: 		}
L_interrupt2:
L_interrupt1:
;Circuito3.c,11 :: 		}
L_end_interrupt:
L__interrupt4:
	RETFIE      1
; end of _interrupt

_main:

;Circuito3.c,13 :: 		void main() {
;Circuito3.c,15 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;Circuito3.c,18 :: 		TRISB.RB0 = 1; // digital input
	BSF         TRISB+0, 0 
;Circuito3.c,19 :: 		TRISB.RB1 = 1; // digital input
	BSF         TRISB+0, 1 
;Circuito3.c,20 :: 		TRISB.RB2 = 1; // digital input
	BSF         TRISB+0, 2 
;Circuito3.c,22 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;Circuito3.c,23 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;Circuito3.c,25 :: 		INTCON3.INT2IE = 1;
	BSF         INTCON3+0, 4 
;Circuito3.c,26 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;Circuito3.c,28 :: 		INTCON2.INTEDG1 = 1;  // Rising edge (1->0)
	BSF         INTCON2+0, 5 
;Circuito3.c,29 :: 		INTCON2.INTEDG2 = 0;  // Falling edge (0->1)
	BCF         INTCON2+0, 4 
;Circuito3.c,32 :: 		TRISD.RD0 = 0;  // digital output
	BCF         TRISD+0, 0 
;Circuito3.c,33 :: 		PORTD.RD0 = 0;  // LED Off
	BCF         PORTD+0, 0 
;Circuito3.c,35 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
