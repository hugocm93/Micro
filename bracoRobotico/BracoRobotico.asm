
_main:

;BracoRobotico.c,21 :: 		void main()
;BracoRobotico.c,25 :: 		char delimiter[] = "end";
	MOVLW       101
	MOVWF       main_delimiter_L0+0 
	MOVLW       110
	MOVWF       main_delimiter_L0+1 
	MOVLW       100
	MOVWF       main_delimiter_L0+2 
	CLRF        main_delimiter_L0+3 
	MOVLW       255
	MOVWF       main_attempts_L0+0 
;BracoRobotico.c,29 :: 		ADCON1 = 0x06;
	MOVLW       6
	MOVWF       ADCON1+0 
;BracoRobotico.c,30 :: 		trisd = 0;
	CLRF        TRISD+0 
;BracoRobotico.c,31 :: 		portd = 0;
	CLRF        PORTD+0 
;BracoRobotico.c,33 :: 		ServoInit(); //Inicializa Servo
	CALL        _ServoInit+0, 0
;BracoRobotico.c,34 :: 		Delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
;BracoRobotico.c,35 :: 		UART1_Init(57600);
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;BracoRobotico.c,36 :: 		Delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main1:
	DECFSZ      R13, 1, 1
	BRA         L_main1
	DECFSZ      R12, 1, 1
	BRA         L_main1
	DECFSZ      R11, 1, 1
	BRA         L_main1
;BracoRobotico.c,37 :: 		UART1_Write_Text("Start:\r\n");
	MOVLW       ?lstr1_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,39 :: 		ServoAttach(BASE, &PORTD, BASE);
	CLRF        FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	CLRF        FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,40 :: 		ServoAttach(SHOULDER, &PORTD, SHOULDER);
	MOVLW       1
	MOVWF       FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	MOVLW       1
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,41 :: 		ServoAttach(ELBOW, &PORTD, ELBOW);
	MOVLW       2
	MOVWF       FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	MOVLW       2
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,42 :: 		ServoAttach(GRIPPER, &PORTD, GRIPPER);
	MOVLW       3
	MOVWF       FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	MOVLW       3
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,44 :: 		ServoWrite(BASE, mapInverse(58, BASE_MIN, BASE_MAX));
	MOVLW       0
	MOVWF       FARG_mapInverse_angle+0 
	MOVLW       0
	MOVWF       FARG_mapInverse_angle+1 
	MOVLW       104
	MOVWF       FARG_mapInverse_angle+2 
	MOVLW       132
	MOVWF       FARG_mapInverse_angle+3 
	CLRF        FARG_mapInverse_min+0 
	CLRF        FARG_mapInverse_min+1 
	CLRF        FARG_mapInverse_min+2 
	CLRF        FARG_mapInverse_min+3 
	MOVLW       0
	MOVWF       FARG_mapInverse_max+0 
	MOVLW       0
	MOVWF       FARG_mapInverse_max+1 
	MOVLW       52
	MOVWF       FARG_mapInverse_max+2 
	MOVLW       134
	MOVWF       FARG_mapInverse_max+3 
	CALL        _mapInverse+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	CLRF        FARG_ServoWrite_srv_id+0 
	CALL        _ServoWrite+0, 0
;BracoRobotico.c,45 :: 		ServoWrite(SHOULDER, mapInverse(72, SHOULDER_MIN, SHOULDER_MAX));
	MOVLW       0
	MOVWF       FARG_mapInverse_angle+0 
	MOVLW       0
	MOVWF       FARG_mapInverse_angle+1 
	MOVLW       16
	MOVWF       FARG_mapInverse_angle+2 
	MOVLW       133
	MOVWF       FARG_mapInverse_angle+3 
	MOVLW       0
	MOVWF       FARG_mapInverse_min+0 
	MOVLW       0
	MOVWF       FARG_mapInverse_min+1 
	MOVLW       52
	MOVWF       FARG_mapInverse_min+2 
	MOVLW       132
	MOVWF       FARG_mapInverse_min+3 
	MOVLW       0
	MOVWF       FARG_mapInverse_max+0 
	MOVLW       0
	MOVWF       FARG_mapInverse_max+1 
	MOVLW       7
	MOVWF       FARG_mapInverse_max+2 
	MOVLW       134
	MOVWF       FARG_mapInverse_max+3 
	CALL        _mapInverse+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	MOVLW       1
	MOVWF       FARG_ServoWrite_srv_id+0 
	CALL        _ServoWrite+0, 0
;BracoRobotico.c,46 :: 		ServoWrite(ELBOW, mapInverse(-20, ELBOW_MIN, ELBOW_MAX));
	MOVLW       0
	MOVWF       FARG_mapInverse_angle+0 
	MOVLW       0
	MOVWF       FARG_mapInverse_angle+1 
	MOVLW       160
	MOVWF       FARG_mapInverse_angle+2 
	MOVLW       131
	MOVWF       FARG_mapInverse_angle+3 
	MOVLW       0
	MOVWF       FARG_mapInverse_min+0 
	MOVLW       0
	MOVWF       FARG_mapInverse_min+1 
	MOVLW       180
	MOVWF       FARG_mapInverse_min+2 
	MOVLW       132
	MOVWF       FARG_mapInverse_min+3 
	MOVLW       0
	MOVWF       FARG_mapInverse_max+0 
	MOVLW       0
	MOVWF       FARG_mapInverse_max+1 
	MOVLW       52
	MOVWF       FARG_mapInverse_max+2 
	MOVLW       134
	MOVWF       FARG_mapInverse_max+3 
	CALL        _mapInverse+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	MOVLW       2
	MOVWF       FARG_ServoWrite_srv_id+0 
	CALL        _ServoWrite+0, 0
;BracoRobotico.c,47 :: 		ServoWrite(GRIPPER, mapInverse(56, GRIPPER_MIN, GRIPPER_MAX));
	MOVLW       0
	MOVWF       FARG_mapInverse_angle+0 
	MOVLW       0
	MOVWF       FARG_mapInverse_angle+1 
	MOVLW       96
	MOVWF       FARG_mapInverse_angle+2 
	MOVLW       132
	MOVWF       FARG_mapInverse_angle+3 
	MOVLW       0
	MOVWF       FARG_mapInverse_min+0 
	MOVLW       0
	MOVWF       FARG_mapInverse_min+1 
	MOVLW       96
	MOVWF       FARG_mapInverse_min+2 
	MOVLW       132
	MOVWF       FARG_mapInverse_min+3 
	MOVLW       0
	MOVWF       FARG_mapInverse_max+0 
	MOVLW       0
	MOVWF       FARG_mapInverse_max+1 
	MOVLW       32
	MOVWF       FARG_mapInverse_max+2 
	MOVLW       133
	MOVWF       FARG_mapInverse_max+3 
	CALL        _mapInverse+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	MOVLW       3
	MOVWF       FARG_ServoWrite_srv_id+0 
	CALL        _ServoWrite+0, 0
;BracoRobotico.c,103 :: 		}
L_main3:
;BracoRobotico.c,104 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_parser:

;BracoRobotico.c,107 :: 		int parser(char* input, char* commands, int* params, int max)
;BracoRobotico.c,109 :: 		int i = 0;
	CLRF        parser_i_L0+0 
	CLRF        parser_i_L0+1 
;BracoRobotico.c,110 :: 		char* token = strtok (input, ";");
	MOVF        FARG_parser_input+0, 0 
	MOVWF       FARG_strtok_s1+0 
	MOVF        FARG_parser_input+1, 0 
	MOVWF       FARG_strtok_s1+1 
	MOVLW       ?lstr7_BracoRobotico+0
	MOVWF       FARG_strtok_s2+0 
	MOVLW       hi_addr(?lstr7_BracoRobotico+0)
	MOVWF       FARG_strtok_s2+1 
	CALL        _strtok+0, 0
	MOVF        R0, 0 
	MOVWF       parser_token_L0+0 
	MOVF        R1, 0 
	MOVWF       parser_token_L0+1 
;BracoRobotico.c,112 :: 		while (token && i < max){
L_parser22:
	MOVF        parser_token_L0+0, 0 
	IORWF       parser_token_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_parser23
	MOVLW       128
	XORWF       parser_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_parser_max+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__parser29
	MOVF        FARG_parser_max+0, 0 
	SUBWF       parser_i_L0+0, 0 
L__parser29:
	BTFSC       STATUS+0, 0 
	GOTO        L_parser23
L__parser26:
;BracoRobotico.c,113 :: 		commands[i] = token[1];
	MOVF        parser_i_L0+0, 0 
	ADDWF       FARG_parser_commands+0, 0 
	MOVWF       FSR1 
	MOVF        parser_i_L0+1, 0 
	ADDWFC      FARG_parser_commands+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       parser_token_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      parser_token_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;BracoRobotico.c,114 :: 		params[i++] = atoi(&token[2]);
	MOVF        parser_i_L0+0, 0 
	MOVWF       R0 
	MOVF        parser_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_parser_params+0, 0 
	MOVWF       FLOC__parser+0 
	MOVF        R1, 0 
	ADDWFC      FARG_parser_params+1, 0 
	MOVWF       FLOC__parser+1 
	MOVLW       2
	ADDWF       parser_token_L0+0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVLW       0
	ADDWFC      parser_token_L0+1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVFF       FLOC__parser+0, FSR1
	MOVFF       FLOC__parser+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      parser_i_L0+0, 1 
	INCF        parser_i_L0+1, 1 
;BracoRobotico.c,115 :: 		token = strtok (0, ";");
	CLRF        FARG_strtok_s1+0 
	CLRF        FARG_strtok_s1+1 
	MOVLW       ?lstr8_BracoRobotico+0
	MOVWF       FARG_strtok_s2+0 
	MOVLW       hi_addr(?lstr8_BracoRobotico+0)
	MOVWF       FARG_strtok_s2+1 
	CALL        _strtok+0, 0
	MOVF        R0, 0 
	MOVWF       parser_token_L0+0 
	MOVF        R1, 0 
	MOVWF       parser_token_L0+1 
;BracoRobotico.c,116 :: 		}
	GOTO        L_parser22
L_parser23:
;BracoRobotico.c,118 :: 		return i;
	MOVF        parser_i_L0+0, 0 
	MOVWF       R0 
	MOVF        parser_i_L0+1, 0 
	MOVWF       R1 
;BracoRobotico.c,119 :: 		}
L_end_parser:
	RETURN      0
; end of _parser

_mapInverse:

;BracoRobotico.c,122 :: 		float mapInverse(float angle, float min, float max)
;BracoRobotico.c,124 :: 		return ((angle - min)/(max - min)) * 180;
	MOVF        FARG_mapInverse_min+0, 0 
	MOVWF       R4 
	MOVF        FARG_mapInverse_min+1, 0 
	MOVWF       R5 
	MOVF        FARG_mapInverse_min+2, 0 
	MOVWF       R6 
	MOVF        FARG_mapInverse_min+3, 0 
	MOVWF       R7 
	MOVF        FARG_mapInverse_angle+0, 0 
	MOVWF       R0 
	MOVF        FARG_mapInverse_angle+1, 0 
	MOVWF       R1 
	MOVF        FARG_mapInverse_angle+2, 0 
	MOVWF       R2 
	MOVF        FARG_mapInverse_angle+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__mapInverse+0 
	MOVF        R1, 0 
	MOVWF       FLOC__mapInverse+1 
	MOVF        R2, 0 
	MOVWF       FLOC__mapInverse+2 
	MOVF        R3, 0 
	MOVWF       FLOC__mapInverse+3 
	MOVF        FARG_mapInverse_min+0, 0 
	MOVWF       R4 
	MOVF        FARG_mapInverse_min+1, 0 
	MOVWF       R5 
	MOVF        FARG_mapInverse_min+2, 0 
	MOVWF       R6 
	MOVF        FARG_mapInverse_min+3, 0 
	MOVWF       R7 
	MOVF        FARG_mapInverse_max+0, 0 
	MOVWF       R0 
	MOVF        FARG_mapInverse_max+1, 0 
	MOVWF       R1 
	MOVF        FARG_mapInverse_max+2, 0 
	MOVWF       R2 
	MOVF        FARG_mapInverse_max+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__mapInverse+0, 0 
	MOVWF       R0 
	MOVF        FLOC__mapInverse+1, 0 
	MOVWF       R1 
	MOVF        FLOC__mapInverse+2, 0 
	MOVWF       R2 
	MOVF        FLOC__mapInverse+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       52
	MOVWF       R6 
	MOVLW       134
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
;BracoRobotico.c,125 :: 		}
L_end_mapInverse:
	RETURN      0
; end of _mapInverse
