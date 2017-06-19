
_main:

;BracoRobotico.c,10 :: 		void main()
;BracoRobotico.c,14 :: 		char delimiter[] = "end";
	MOVLW       101
	MOVWF       main_delimiter_L0+0 
	MOVLW       110
	MOVWF       main_delimiter_L0+1 
	MOVLW       100
	MOVWF       main_delimiter_L0+2 
	CLRF        main_delimiter_L0+3 
	MOVLW       255
	MOVWF       main_attempts_L0+0 
;BracoRobotico.c,18 :: 		ADCON1 = 0x06;
	MOVLW       6
	MOVWF       ADCON1+0 
;BracoRobotico.c,19 :: 		trisd = 0;
	CLRF        TRISD+0 
;BracoRobotico.c,20 :: 		portd = 0;
	CLRF        PORTD+0 
;BracoRobotico.c,22 :: 		ServoInit(); //Inicializa Servo
	CALL        _ServoInit+0, 0
;BracoRobotico.c,23 :: 		UART1_Init(57600);
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;BracoRobotico.c,24 :: 		Delay_ms(200);
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
;BracoRobotico.c,25 :: 		UART1_Write_Text("Start\r\n");
	MOVLW       ?lstr1_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,27 :: 		ServoAttach(BASE, &PORTD, BASE);
	CLRF        FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	CLRF        FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,28 :: 		ServoAttach(SHOULDER, &PORTD, SHOULDER);
	MOVLW       1
	MOVWF       FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	MOVLW       1
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,29 :: 		ServoAttach(ELBOW, &PORTD, ELBOW);
	MOVLW       2
	MOVWF       FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	MOVLW       2
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,30 :: 		ServoAttach(GRIPPER, &PORTD, GRIPPER);
	MOVLW       3
	MOVWF       FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	MOVLW       3
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,32 :: 		while(1)
L_main1:
;BracoRobotico.c,34 :: 		if(UART1_Data_Ready())
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
;BracoRobotico.c,38 :: 		int i, max = 80;
	MOVLW       80
	MOVWF       main_max_L2+0 
	MOVLW       0
	MOVWF       main_max_L2+1 
;BracoRobotico.c,40 :: 		UART1_Read_Text(output, delimiter, attempts);
	MOVLW       main_output_L0+0
	MOVWF       FARG_UART1_Read_Text_Output+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_UART1_Read_Text_Output+1 
	MOVLW       main_delimiter_L0+0
	MOVWF       FARG_UART1_Read_Text_Delimiter+0 
	MOVLW       hi_addr(main_delimiter_L0+0)
	MOVWF       FARG_UART1_Read_Text_Delimiter+1 
	MOVF        main_attempts_L0+0, 0 
	MOVWF       FARG_UART1_Read_Text_Attempts+0 
	CALL        _UART1_Read_Text+0, 0
;BracoRobotico.c,41 :: 		max = parser(output, commands, params, max);
	MOVLW       main_output_L0+0
	MOVWF       FARG_parser_input+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_parser_input+1 
	MOVLW       main_commands_L2+0
	MOVWF       FARG_parser_commands+0 
	MOVLW       hi_addr(main_commands_L2+0)
	MOVWF       FARG_parser_commands+1 
	MOVLW       main_params_L2+0
	MOVWF       FARG_parser_params+0 
	MOVLW       hi_addr(main_params_L2+0)
	MOVWF       FARG_parser_params+1 
	MOVF        main_max_L2+0, 0 
	MOVWF       FARG_parser_max+0 
	MOVF        main_max_L2+1, 0 
	MOVWF       FARG_parser_max+1 
	CALL        _parser+0, 0
	MOVF        R0, 0 
	MOVWF       main_max_L2+0 
	MOVF        R1, 0 
	MOVWF       main_max_L2+1 
;BracoRobotico.c,43 :: 		for(i = 0; i < max; i++)
	CLRF        main_i_L2+0 
	CLRF        main_i_L2+1 
L_main4:
	MOVLW       128
	XORWF       main_i_L2+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       main_max_L2+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main27
	MOVF        main_max_L2+0, 0 
	SUBWF       main_i_L2+0, 0 
L__main27:
	BTFSC       STATUS+0, 0 
	GOTO        L_main5
;BracoRobotico.c,45 :: 		switch(commands[i])
	MOVLW       main_commands_L2+0
	ADDWF       main_i_L2+0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(main_commands_L2+0)
	ADDWFC      main_i_L2+1, 0 
	MOVWF       FLOC__main+1 
	GOTO        L_main7
;BracoRobotico.c,47 :: 		case 'b':
L_main9:
;BracoRobotico.c,48 :: 		case 'B':
L_main10:
;BracoRobotico.c,49 :: 		ServoWrite(BASE, params[i]);
	CLRF        FARG_ServoWrite_srv_id+0 
	MOVLW       main_params_L2+0
	ADDWF       main_i_L2+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(main_params_L2+0)
	ADDWFC      main_i_L2+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	CALL        _ServoWrite+0, 0
;BracoRobotico.c,50 :: 		UART1_Write_Text("write base\r\n");
	MOVLW       ?lstr2_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,51 :: 		break;
	GOTO        L_main8
;BracoRobotico.c,53 :: 		case 'o':
L_main11:
;BracoRobotico.c,54 :: 		case 'O':
L_main12:
;BracoRobotico.c,55 :: 		ServoWrite(SHOULDER, params[i]);
	MOVLW       1
	MOVWF       FARG_ServoWrite_srv_id+0 
	MOVLW       main_params_L2+0
	ADDWF       main_i_L2+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(main_params_L2+0)
	ADDWFC      main_i_L2+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	CALL        _ServoWrite+0, 0
;BracoRobotico.c,56 :: 		UART1_Write_Text("write shoulder\r\n");
	MOVLW       ?lstr3_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,57 :: 		break;
	GOTO        L_main8
;BracoRobotico.c,59 :: 		case 'c':
L_main13:
;BracoRobotico.c,60 :: 		case 'C':
L_main14:
;BracoRobotico.c,61 :: 		ServoWrite(ELBOW, params[i]);
	MOVLW       2
	MOVWF       FARG_ServoWrite_srv_id+0 
	MOVLW       main_params_L2+0
	ADDWF       main_i_L2+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(main_params_L2+0)
	ADDWFC      main_i_L2+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	CALL        _ServoWrite+0, 0
;BracoRobotico.c,62 :: 		UART1_Write_Text("write elbow\r\n");
	MOVLW       ?lstr4_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,63 :: 		break;
	GOTO        L_main8
;BracoRobotico.c,65 :: 		case 'p':
L_main15:
;BracoRobotico.c,66 :: 		case 'P':
L_main16:
;BracoRobotico.c,67 :: 		ServoWrite(BASE, params[i]);
	CLRF        FARG_ServoWrite_srv_id+0 
	MOVLW       main_params_L2+0
	ADDWF       main_i_L2+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(main_params_L2+0)
	ADDWFC      main_i_L2+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	CALL        _ServoWrite+0, 0
;BracoRobotico.c,68 :: 		ServoWrite(SHOULDER, params[i]);
	MOVLW       1
	MOVWF       FARG_ServoWrite_srv_id+0 
	MOVLW       main_params_L2+0
	ADDWF       main_i_L2+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(main_params_L2+0)
	ADDWFC      main_i_L2+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	CALL        _ServoWrite+0, 0
;BracoRobotico.c,69 :: 		ServoWrite(ELBOW, params[i]);
	MOVLW       2
	MOVWF       FARG_ServoWrite_srv_id+0 
	MOVLW       main_params_L2+0
	ADDWF       main_i_L2+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(main_params_L2+0)
	ADDWFC      main_i_L2+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	CALL        _ServoWrite+0, 0
;BracoRobotico.c,70 :: 		UART1_Write_Text("write all\r\n");
	MOVLW       ?lstr5_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,71 :: 		break;
	GOTO        L_main8
;BracoRobotico.c,73 :: 		case 'g':
L_main17:
;BracoRobotico.c,74 :: 		case 'G':
L_main18:
;BracoRobotico.c,75 :: 		if(params[i])
	MOVLW       main_params_L2+0
	ADDWF       main_i_L2+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(main_params_L2+0)
	ADDWFC      main_i_L2+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main19
;BracoRobotico.c,76 :: 		ServoWrite(GRIPPER, 80);
	MOVLW       3
	MOVWF       FARG_ServoWrite_srv_id+0 
	MOVLW       0
	MOVWF       FARG_ServoWrite_angle+0 
	MOVLW       0
	MOVWF       FARG_ServoWrite_angle+1 
	MOVLW       32
	MOVWF       FARG_ServoWrite_angle+2 
	MOVLW       133
	MOVWF       FARG_ServoWrite_angle+3 
	CALL        _ServoWrite+0, 0
	GOTO        L_main20
L_main19:
;BracoRobotico.c,78 :: 		ServoWrite(GRIPPER, 56);
	MOVLW       3
	MOVWF       FARG_ServoWrite_srv_id+0 
	MOVLW       0
	MOVWF       FARG_ServoWrite_angle+0 
	MOVLW       0
	MOVWF       FARG_ServoWrite_angle+1 
	MOVLW       96
	MOVWF       FARG_ServoWrite_angle+2 
	MOVLW       132
	MOVWF       FARG_ServoWrite_angle+3 
	CALL        _ServoWrite+0, 0
L_main20:
;BracoRobotico.c,80 :: 		UART1_Write_Text("write gripper\r\n");
	MOVLW       ?lstr6_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,81 :: 		break;
	GOTO        L_main8
;BracoRobotico.c,82 :: 		}
L_main7:
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       98
	BTFSC       STATUS+0, 2 
	GOTO        L_main9
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       66
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       111
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       79
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       99
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       67
	BTFSC       STATUS+0, 2 
	GOTO        L_main14
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       112
	BTFSC       STATUS+0, 2 
	GOTO        L_main15
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       80
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       103
	BTFSC       STATUS+0, 2 
	GOTO        L_main17
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       71
	BTFSC       STATUS+0, 2 
	GOTO        L_main18
L_main8:
;BracoRobotico.c,43 :: 		for(i = 0; i < max; i++)
	INFSNZ      main_i_L2+0, 1 
	INCF        main_i_L2+1, 1 
;BracoRobotico.c,83 :: 		}
	GOTO        L_main4
L_main5:
;BracoRobotico.c,84 :: 		}
L_main3:
;BracoRobotico.c,85 :: 		}
	GOTO        L_main1
;BracoRobotico.c,86 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_parser:

;BracoRobotico.c,89 :: 		int parser(char* input, char* commands, int* params, int max)
;BracoRobotico.c,91 :: 		int i = 0;
	CLRF        parser_i_L0+0 
	CLRF        parser_i_L0+1 
;BracoRobotico.c,92 :: 		char* token = strtok (input, ";");
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
;BracoRobotico.c,94 :: 		while (token && i < max){
L_parser21:
	MOVF        parser_token_L0+0, 0 
	IORWF       parser_token_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_parser22
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
	GOTO        L_parser22
L__parser25:
;BracoRobotico.c,95 :: 		commands[i] = token[1];
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
;BracoRobotico.c,96 :: 		params[i++] = atoi(&token[2]);
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
;BracoRobotico.c,97 :: 		token = strtok (0, ";");
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
;BracoRobotico.c,98 :: 		}
	GOTO        L_parser21
L_parser22:
;BracoRobotico.c,100 :: 		return i;
	MOVF        parser_i_L0+0, 0 
	MOVWF       R0 
	MOVF        parser_i_L0+1, 0 
	MOVWF       R1 
;BracoRobotico.c,101 :: 		}
L_end_parser:
	RETURN      0
; end of _parser
