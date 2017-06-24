
_main:

;BracoRobotico.c,61 :: 		void main()
;BracoRobotico.c,66 :: 		char delimiter[] = "end";
	MOVLW       101
	MOVWF       main_delimiter_L0+0 
	MOVLW       110
	MOVWF       main_delimiter_L0+1 
	MOVLW       100
	MOVWF       main_delimiter_L0+2 
	CLRF        main_delimiter_L0+3 
	CLRF        main_numberOfCommandsRead_L0+0 
	CLRF        main_numberOfCommandsRead_L0+1 
;BracoRobotico.c,74 :: 		ADCON1 = 0x06;
	MOVLW       6
	MOVWF       ADCON1+0 
;BracoRobotico.c,75 :: 		trisd = 0;
	CLRF        TRISD+0 
;BracoRobotico.c,76 :: 		portd = 0;
	CLRF        PORTD+0 
;BracoRobotico.c,79 :: 		ServoInit();
	CALL        _ServoInit+0, 0
;BracoRobotico.c,80 :: 		Delay_ms(200);
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
;BracoRobotico.c,81 :: 		ServoAttach(BASE, &PORTD, BASE);
	CLRF        FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	CLRF        FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,82 :: 		ServoAttach(SHOULDER, &PORTD, SHOULDER);
	MOVLW       1
	MOVWF       FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	MOVLW       1
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,83 :: 		ServoAttach(ELBOW, &PORTD, ELBOW);
	MOVLW       2
	MOVWF       FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	MOVLW       2
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,84 :: 		ServoAttach(GRIPPER, &PORTD, GRIPPER);
	MOVLW       3
	MOVWF       FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	MOVLW       3
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,87 :: 		ServoWrite(BASE, limitAngle(anglesMatrix[0][BASE], BASE));
	MOVF        _anglesMatrix+0, 0 
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        _anglesMatrix+1, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        _anglesMatrix+2, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        _anglesMatrix+3, 0 
	MOVWF       FARG_limitAngle_angle+3 
	CLRF        FARG_limitAngle_servoId+0 
	CLRF        FARG_limitAngle_servoId+1 
	CALL        _limitAngle+0, 0
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
;BracoRobotico.c,88 :: 		ServoWrite(SHOULDER, limitAngle(anglesMatrix[0][SHOULDER], SHOULDER));
	MOVF        _anglesMatrix+4, 0 
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        _anglesMatrix+5, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        _anglesMatrix+6, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        _anglesMatrix+7, 0 
	MOVWF       FARG_limitAngle_angle+3 
	MOVLW       1
	MOVWF       FARG_limitAngle_servoId+0 
	MOVLW       0
	MOVWF       FARG_limitAngle_servoId+1 
	CALL        _limitAngle+0, 0
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
;BracoRobotico.c,89 :: 		ServoWrite(ELBOW, limitAngle(anglesMatrix[0][ELBOW], ELBOW));
	MOVF        _anglesMatrix+8, 0 
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        _anglesMatrix+9, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        _anglesMatrix+10, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        _anglesMatrix+11, 0 
	MOVWF       FARG_limitAngle_angle+3 
	MOVLW       2
	MOVWF       FARG_limitAngle_servoId+0 
	MOVLW       0
	MOVWF       FARG_limitAngle_servoId+1 
	CALL        _limitAngle+0, 0
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
;BracoRobotico.c,92 :: 		UART1_Init(57600);
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;BracoRobotico.c,93 :: 		Delay_ms(200);
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
;BracoRobotico.c,94 :: 		writeStr("Start:");
	MOVLW       ?lstr1_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr1_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,95 :: 		while(TRUE)
L_main2:
;BracoRobotico.c,97 :: 		if(!UART1_Data_Ready())
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
;BracoRobotico.c,99 :: 		continue;
	GOTO        L_main2
;BracoRobotico.c,100 :: 		}
L_main4:
;BracoRobotico.c,102 :: 		UART1_Read_Text(input, delimiter, ATTEMPTS);
	MOVLW       main_input_L0+0
	MOVWF       FARG_UART1_Read_Text_Output+0 
	MOVLW       hi_addr(main_input_L0+0)
	MOVWF       FARG_UART1_Read_Text_Output+1 
	MOVLW       main_delimiter_L0+0
	MOVWF       FARG_UART1_Read_Text_Delimiter+0 
	MOVLW       hi_addr(main_delimiter_L0+0)
	MOVWF       FARG_UART1_Read_Text_Delimiter+1 
	MOVLW       255
	MOVWF       FARG_UART1_Read_Text_Attempts+0 
	CALL        _UART1_Read_Text+0, 0
;BracoRobotico.c,103 :: 		numberOfCommandsRead = parser(input, commands, params);
	MOVLW       main_input_L0+0
	MOVWF       FARG_parser_input+0 
	MOVLW       hi_addr(main_input_L0+0)
	MOVWF       FARG_parser_input+1 
	MOVLW       main_commands_L0+0
	MOVWF       FARG_parser_commands+0 
	MOVLW       hi_addr(main_commands_L0+0)
	MOVWF       FARG_parser_commands+1 
	MOVLW       main_params_L0+0
	MOVWF       FARG_parser_params+0 
	MOVLW       hi_addr(main_params_L0+0)
	MOVWF       FARG_parser_params+1 
	CALL        _parser+0, 0
	MOVF        R0, 0 
	MOVWF       main_numberOfCommandsRead_L0+0 
	MOVF        R1, 0 
	MOVWF       main_numberOfCommandsRead_L0+1 
;BracoRobotico.c,105 :: 		for(i = 0; i < numberOfCommandsRead; i++)
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main5:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       main_numberOfCommandsRead_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main37
	MOVF        main_numberOfCommandsRead_L0+0, 0 
	SUBWF       main_i_L0+0, 0 
L__main37:
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;BracoRobotico.c,107 :: 		switch(commands[i])
	MOVLW       main_commands_L0+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(main_commands_L0+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FLOC__main+1 
	GOTO        L_main8
;BracoRobotico.c,109 :: 		case 'b': case 'B':
L_main10:
L_main11:
;BracoRobotico.c,110 :: 		ServoWrite(BASE, limitAngle(params[i], BASE));
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       main_params_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(main_params_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+3 
	CLRF        FARG_limitAngle_servoId+0 
	CLRF        FARG_limitAngle_servoId+1 
	CALL        _limitAngle+0, 0
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
;BracoRobotico.c,111 :: 		writeStr("write to base");
	MOVLW       ?lstr2_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr2_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,112 :: 		break;
	GOTO        L_main9
;BracoRobotico.c,114 :: 		case 'o': case 'O':
L_main12:
L_main13:
;BracoRobotico.c,115 :: 		ServoWrite(SHOULDER, limitAngle(params[i], SHOULDER));
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       main_params_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(main_params_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+3 
	MOVLW       1
	MOVWF       FARG_limitAngle_servoId+0 
	MOVLW       0
	MOVWF       FARG_limitAngle_servoId+1 
	CALL        _limitAngle+0, 0
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
;BracoRobotico.c,116 :: 		writeStr("write to shoulder");
	MOVLW       ?lstr3_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr3_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,117 :: 		break;
	GOTO        L_main9
;BracoRobotico.c,119 :: 		case 'c': case 'C':
L_main14:
L_main15:
;BracoRobotico.c,120 :: 		ServoWrite(ELBOW, limitAngle(params[i], ELBOW));
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       main_params_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(main_params_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+3 
	MOVLW       2
	MOVWF       FARG_limitAngle_servoId+0 
	MOVLW       0
	MOVWF       FARG_limitAngle_servoId+1 
	CALL        _limitAngle+0, 0
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
;BracoRobotico.c,121 :: 		writeStr("write to elbow");
	MOVLW       ?lstr4_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr4_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,122 :: 		break;
	GOTO        L_main9
;BracoRobotico.c,124 :: 		case 'p': case 'P':
L_main16:
L_main17:
;BracoRobotico.c,126 :: 		int pos = (int)params[i] >= 0 && (int)params[i] < POSITIONS ? (int)params[i] : 0;
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       main_params_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(main_params_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R2 
	MOVLW       128
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main38
	MOVLW       0
	SUBWF       R0, 0 
L__main38:
	BTFSS       STATUS+0, 0 
	GOTO        L_main20
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       main_params_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(main_params_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R2 
	MOVLW       128
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main39
	MOVLW       3
	SUBWF       R0, 0 
L__main39:
	BTFSC       STATUS+0, 0 
	GOTO        L_main20
L__main34:
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       main_params_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(main_params_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       ?FLOC___mainT58+0 
	MOVF        R1, 0 
	MOVWF       ?FLOC___mainT58+1 
	GOTO        L_main21
L_main20:
	CLRF        ?FLOC___mainT58+0 
	CLRF        ?FLOC___mainT58+1 
L_main21:
	MOVF        ?FLOC___mainT58+0, 0 
	MOVWF       main_pos_L4+0 
	MOVF        ?FLOC___mainT58+1, 0 
	MOVWF       main_pos_L4+1 
;BracoRobotico.c,127 :: 		ServoWrite(BASE, limitAngle(anglesMatrix[pos][BASE], BASE));
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ?FLOC___mainT58+0, 0 
	MOVWF       R4 
	MOVF        ?FLOC___mainT58+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _anglesMatrix+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_anglesMatrix+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+3 
	CLRF        FARG_limitAngle_servoId+0 
	CLRF        FARG_limitAngle_servoId+1 
	CALL        _limitAngle+0, 0
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
;BracoRobotico.c,128 :: 		ServoWrite(SHOULDER, limitAngle(anglesMatrix[pos][SHOULDER], SHOULDER));
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        main_pos_L4+0, 0 
	MOVWF       R4 
	MOVF        main_pos_L4+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _anglesMatrix+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_anglesMatrix+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+3 
	MOVLW       1
	MOVWF       FARG_limitAngle_servoId+0 
	MOVLW       0
	MOVWF       FARG_limitAngle_servoId+1 
	CALL        _limitAngle+0, 0
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
;BracoRobotico.c,129 :: 		ServoWrite(ELBOW, limitAngle(anglesMatrix[pos][ELBOW], ELBOW));
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        main_pos_L4+0, 0 
	MOVWF       R4 
	MOVF        main_pos_L4+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _anglesMatrix+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_anglesMatrix+0)
	ADDWFC      R1, 1 
	MOVLW       8
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_limitAngle_angle+3 
	MOVLW       2
	MOVWF       FARG_limitAngle_servoId+0 
	MOVLW       0
	MOVWF       FARG_limitAngle_servoId+1 
	CALL        _limitAngle+0, 0
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
;BracoRobotico.c,130 :: 		writeStr("write position");
	MOVLW       ?lstr5_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr5_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,131 :: 		writeFloat(anglesMatrix[pos][BASE]);
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        main_pos_L4+0, 0 
	MOVWF       R4 
	MOVF        main_pos_L4+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _anglesMatrix+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_anglesMatrix+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_writeFloat_f+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_writeFloat_f+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_writeFloat_f+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_writeFloat_f+3 
	CALL        _writeFloat+0, 0
;BracoRobotico.c,132 :: 		writeFloat(anglesMatrix[pos][SHOULDER]);
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        main_pos_L4+0, 0 
	MOVWF       R4 
	MOVF        main_pos_L4+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _anglesMatrix+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_anglesMatrix+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_writeFloat_f+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_writeFloat_f+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_writeFloat_f+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_writeFloat_f+3 
	CALL        _writeFloat+0, 0
;BracoRobotico.c,133 :: 		writeFloat(anglesMatrix[pos][ELBOW]);
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        main_pos_L4+0, 0 
	MOVWF       R4 
	MOVF        main_pos_L4+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _anglesMatrix+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_anglesMatrix+0)
	ADDWFC      R1, 1 
	MOVLW       8
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_writeFloat_f+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_writeFloat_f+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_writeFloat_f+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_writeFloat_f+3 
	CALL        _writeFloat+0, 0
;BracoRobotico.c,135 :: 		break;
	GOTO        L_main9
;BracoRobotico.c,137 :: 		case 'g': case 'G':
L_main22:
L_main23:
;BracoRobotico.c,139 :: 		float gripperAngle = (int)params[i] ? servos[GRIPPER].max : servos[GRIPPER].min;
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       main_params_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(main_params_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main24
	MOVF        _servos+28, 0 
	MOVWF       ?FLOC___mainT109+0 
	MOVF        _servos+29, 0 
	MOVWF       ?FLOC___mainT109+1 
	MOVF        _servos+30, 0 
	MOVWF       ?FLOC___mainT109+2 
	MOVF        _servos+31, 0 
	MOVWF       ?FLOC___mainT109+3 
	GOTO        L_main25
L_main24:
	MOVF        _servos+24, 0 
	MOVWF       ?FLOC___mainT109+0 
	MOVF        _servos+25, 0 
	MOVWF       ?FLOC___mainT109+1 
	MOVF        _servos+26, 0 
	MOVWF       ?FLOC___mainT109+2 
	MOVF        _servos+27, 0 
	MOVWF       ?FLOC___mainT109+3 
L_main25:
	MOVF        ?FLOC___mainT109+0, 0 
	MOVWF       main_gripperAngle_L4+0 
	MOVF        ?FLOC___mainT109+1, 0 
	MOVWF       main_gripperAngle_L4+1 
	MOVF        ?FLOC___mainT109+2, 0 
	MOVWF       main_gripperAngle_L4+2 
	MOVF        ?FLOC___mainT109+3, 0 
	MOVWF       main_gripperAngle_L4+3 
;BracoRobotico.c,140 :: 		ServoWrite(GRIPPER, gripperAngle);
	MOVLW       3
	MOVWF       FARG_ServoWrite_srv_id+0 
	MOVF        main_gripperAngle_L4+0, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        main_gripperAngle_L4+1, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        main_gripperAngle_L4+2, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        main_gripperAngle_L4+3, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	CALL        _ServoWrite+0, 0
;BracoRobotico.c,141 :: 		writeStr("write to gripper");
	MOVLW       ?lstr6_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr6_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,143 :: 		break;
	GOTO        L_main9
;BracoRobotico.c,145 :: 		default:
L_main26:
;BracoRobotico.c,146 :: 		writeStr("");
	MOVLW       ?lstr7_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr7_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,148 :: 		}
	GOTO        L_main9
L_main8:
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       98
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       66
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       111
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       79
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       99
	BTFSC       STATUS+0, 2 
	GOTO        L_main14
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       67
	BTFSC       STATUS+0, 2 
	GOTO        L_main15
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       112
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       80
	BTFSC       STATUS+0, 2 
	GOTO        L_main17
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       103
	BTFSC       STATUS+0, 2 
	GOTO        L_main22
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       71
	BTFSC       STATUS+0, 2 
	GOTO        L_main23
	GOTO        L_main26
L_main9:
;BracoRobotico.c,105 :: 		for(i = 0; i < numberOfCommandsRead; i++)
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;BracoRobotico.c,149 :: 		}
	GOTO        L_main5
L_main6:
;BracoRobotico.c,150 :: 		}
	GOTO        L_main2
;BracoRobotico.c,151 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_parser:

;BracoRobotico.c,154 :: 		int parser(char* input, char* commands, float* params)
;BracoRobotico.c,156 :: 		int i = 0;
	CLRF        parser_i_L0+0 
	CLRF        parser_i_L0+1 
;BracoRobotico.c,157 :: 		char* token = strtok (input, ";");
	MOVF        FARG_parser_input+0, 0 
	MOVWF       FARG_strtok_s1+0 
	MOVF        FARG_parser_input+1, 0 
	MOVWF       FARG_strtok_s1+1 
	MOVLW       ?lstr8_BracoRobotico+0
	MOVWF       FARG_strtok_s2+0 
	MOVLW       hi_addr(?lstr8_BracoRobotico+0)
	MOVWF       FARG_strtok_s2+1 
	CALL        _strtok+0, 0
	MOVF        R0, 0 
	MOVWF       parser_token_L0+0 
	MOVF        R1, 0 
	MOVWF       parser_token_L0+1 
;BracoRobotico.c,159 :: 		while (token && i < MAX_COMMANDS){
L_parser27:
	MOVF        parser_token_L0+0, 0 
	IORWF       parser_token_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_parser28
	MOVLW       128
	XORWF       parser_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__parser41
	MOVLW       10
	SUBWF       parser_i_L0+0, 0 
L__parser41:
	BTFSC       STATUS+0, 0 
	GOTO        L_parser28
L__parser35:
;BracoRobotico.c,160 :: 		commands[i] = token[1];
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
;BracoRobotico.c,161 :: 		params[i++] = atof(&token[2]);
	MOVF        parser_i_L0+0, 0 
	MOVWF       R0 
	MOVF        parser_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
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
	MOVWF       FARG_atof_s+0 
	MOVLW       0
	ADDWFC      parser_token_L0+1, 0 
	MOVWF       FARG_atof_s+1 
	CALL        _atof+0, 0
	MOVFF       FLOC__parser+0, FSR1
	MOVFF       FLOC__parser+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      parser_i_L0+0, 1 
	INCF        parser_i_L0+1, 1 
;BracoRobotico.c,162 :: 		token = strtok (0, ";");
	CLRF        FARG_strtok_s1+0 
	CLRF        FARG_strtok_s1+1 
	MOVLW       ?lstr9_BracoRobotico+0
	MOVWF       FARG_strtok_s2+0 
	MOVLW       hi_addr(?lstr9_BracoRobotico+0)
	MOVWF       FARG_strtok_s2+1 
	CALL        _strtok+0, 0
	MOVF        R0, 0 
	MOVWF       parser_token_L0+0 
	MOVF        R1, 0 
	MOVWF       parser_token_L0+1 
;BracoRobotico.c,163 :: 		}
	GOTO        L_parser27
L_parser28:
;BracoRobotico.c,165 :: 		return i;
	MOVF        parser_i_L0+0, 0 
	MOVWF       R0 
	MOVF        parser_i_L0+1, 0 
	MOVWF       R1 
;BracoRobotico.c,166 :: 		}
L_end_parser:
	RETURN      0
; end of _parser

_limitAngle:

;BracoRobotico.c,169 :: 		float limitAngle(float angle, int id)
;BracoRobotico.c,171 :: 		if(angle > servos[id].max)
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_limitAngle_id+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_id+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__limitAngle43:
	BZ          L__limitAngle44
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__limitAngle43
L__limitAngle44:
	MOVLW       _servos+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_servos+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        POSTINC2+0, 0 
	MOVWF       R3 
	MOVF        FARG_limitAngle_angle+0, 0 
	MOVWF       R4 
	MOVF        FARG_limitAngle_angle+1, 0 
	MOVWF       R5 
	MOVF        FARG_limitAngle_angle+2, 0 
	MOVWF       R6 
	MOVF        FARG_limitAngle_angle+3, 0 
	MOVWF       R7 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_limitAngle31
;BracoRobotico.c,172 :: 		return servos[id].max;
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_limitAngle_id+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_id+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__limitAngle45:
	BZ          L__limitAngle46
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__limitAngle45
L__limitAngle46:
	MOVLW       _servos+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_servos+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	GOTO        L_end_limitAngle
L_limitAngle31:
;BracoRobotico.c,173 :: 		else if(angle < servos[id].min)
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_limitAngle_id+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_id+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__limitAngle47:
	BZ          L__limitAngle48
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__limitAngle47
L__limitAngle48:
	MOVLW       _servos+0
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_servos+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R4 
	MOVF        POSTINC2+0, 0 
	MOVWF       R5 
	MOVF        POSTINC2+0, 0 
	MOVWF       R6 
	MOVF        POSTINC2+0, 0 
	MOVWF       R7 
	MOVF        FARG_limitAngle_angle+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_angle+1, 0 
	MOVWF       R1 
	MOVF        FARG_limitAngle_angle+2, 0 
	MOVWF       R2 
	MOVF        FARG_limitAngle_angle+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_limitAngle33
;BracoRobotico.c,174 :: 		return servos[id].min;
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_limitAngle_id+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_id+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__limitAngle49:
	BZ          L__limitAngle50
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__limitAngle49
L__limitAngle50:
	MOVLW       _servos+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_servos+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	GOTO        L_end_limitAngle
L_limitAngle33:
;BracoRobotico.c,175 :: 		return angle;
	MOVF        FARG_limitAngle_angle+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_angle+1, 0 
	MOVWF       R1 
	MOVF        FARG_limitAngle_angle+2, 0 
	MOVWF       R2 
	MOVF        FARG_limitAngle_angle+3, 0 
	MOVWF       R3 
;BracoRobotico.c,176 :: 		}
L_end_limitAngle:
	RETURN      0
; end of _limitAngle

_writeFloat:

;BracoRobotico.c,179 :: 		void writeFloat(float f)
;BracoRobotico.c,182 :: 		FloatToStr(f, str);
	MOVF        FARG_writeFloat_f+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        FARG_writeFloat_f+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        FARG_writeFloat_f+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        FARG_writeFloat_f+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       writeFloat_str_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(writeFloat_str_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;BracoRobotico.c,183 :: 		UART1_Write_Text("\r\n");
	MOVLW       ?lstr10_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr10_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,184 :: 		UART1_Write_Text(str);
	MOVLW       writeFloat_str_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(writeFloat_str_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,185 :: 		UART1_Write_Text("\r\n");
	MOVLW       ?lstr11_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr11_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,186 :: 		}
L_end_writeFloat:
	RETURN      0
; end of _writeFloat

_writeStr:

;BracoRobotico.c,189 :: 		void writeStr(char* str)
;BracoRobotico.c,191 :: 		UART1_Write_Text("\r\n");
	MOVLW       ?lstr12_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr12_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,192 :: 		UART1_Write_Text(str);
	MOVF        FARG_writeStr_str+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_writeStr_str+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,193 :: 		UART1_Write_Text("\r\n");
	MOVLW       ?lstr13_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr13_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,194 :: 		}
L_end_writeStr:
	RETURN      0
; end of _writeStr
