
_main:

;BracoRobotico.c,68 :: 		void main()
;BracoRobotico.c,73 :: 		char delimiter[] = "end";
	MOVLW       101
	MOVWF       main_delimiter_L0+0 
	MOVLW       110
	MOVWF       main_delimiter_L0+1 
	MOVLW       100
	MOVWF       main_delimiter_L0+2 
	CLRF        main_delimiter_L0+3 
	CLRF        main_numberOfCommandsRead_L0+0 
	CLRF        main_numberOfCommandsRead_L0+1 
;BracoRobotico.c,81 :: 		ADCON1 = 0x06;
	MOVLW       6
	MOVWF       ADCON1+0 
;BracoRobotico.c,82 :: 		trisd = 0;
	CLRF        TRISD+0 
;BracoRobotico.c,83 :: 		portd = 0;
	CLRF        PORTD+0 
;BracoRobotico.c,86 :: 		ServoInit();
	CALL        _ServoInit+0, 0
;BracoRobotico.c,87 :: 		Delay_ms(200);
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
;BracoRobotico.c,88 :: 		ServoAttach(BASE, &PORTD, BASE);
	CLRF        FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	CLRF        FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,89 :: 		ServoAttach(SHOULDER, &PORTD, SHOULDER);
	MOVLW       1
	MOVWF       FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	MOVLW       1
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,90 :: 		ServoAttach(ELBOW, &PORTD, ELBOW);
	MOVLW       2
	MOVWF       FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	MOVLW       2
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,91 :: 		ServoAttach(GRIPPER, &PORTD, GRIPPER);
	MOVLW       3
	MOVWF       FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	MOVLW       3
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,94 :: 		ServoWrite(BASE, limitAngle(anglesMatrix[0][BASE], BASE));
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
;BracoRobotico.c,95 :: 		ServoWrite(SHOULDER, limitAngle(anglesMatrix[0][SHOULDER], SHOULDER));
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
;BracoRobotico.c,96 :: 		ServoWrite(ELBOW, limitAngle(anglesMatrix[0][ELBOW], ELBOW));
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
;BracoRobotico.c,99 :: 		UART1_Init(57600);
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;BracoRobotico.c,100 :: 		Delay_ms(200);
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
;BracoRobotico.c,101 :: 		writeStr("Start:");
	MOVLW       ?lstr1_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr1_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,102 :: 		while(TRUE)
L_main2:
;BracoRobotico.c,104 :: 		if(!UART1_Data_Ready())
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
;BracoRobotico.c,106 :: 		continue;
	GOTO        L_main2
;BracoRobotico.c,107 :: 		}
L_main4:
;BracoRobotico.c,109 :: 		UART1_Read_Text(input, delimiter, ATTEMPTS);
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
;BracoRobotico.c,110 :: 		numberOfCommandsRead = parser(input, commands, params);
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
;BracoRobotico.c,112 :: 		for(i = 0; i < numberOfCommandsRead; i++)
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
	GOTO        L__main41
	MOVF        main_numberOfCommandsRead_L0+0, 0 
	SUBWF       main_i_L0+0, 0 
L__main41:
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;BracoRobotico.c,114 :: 		switch(commands[i])
	MOVLW       main_commands_L0+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(main_commands_L0+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FLOC__main+1 
	GOTO        L_main8
;BracoRobotico.c,116 :: 		case 'b': case 'B':
L_main10:
L_main11:
;BracoRobotico.c,117 :: 		ServoWrite(BASE, limitAngle(params[i], BASE));
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
;BracoRobotico.c,118 :: 		writeStr("write to base");
	MOVLW       ?lstr2_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr2_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,119 :: 		break;
	GOTO        L_main9
;BracoRobotico.c,121 :: 		case 'o': case 'O':
L_main12:
L_main13:
;BracoRobotico.c,122 :: 		ServoWrite(SHOULDER, limitAngle(params[i], SHOULDER));
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
;BracoRobotico.c,123 :: 		writeStr("write to shoulder");
	MOVLW       ?lstr3_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr3_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,124 :: 		break;
	GOTO        L_main9
;BracoRobotico.c,126 :: 		case 'c': case 'C':
L_main14:
L_main15:
;BracoRobotico.c,127 :: 		ServoWrite(ELBOW, limitAngle(params[i], ELBOW));
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
;BracoRobotico.c,128 :: 		writeStr("write to elbow");
	MOVLW       ?lstr4_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr4_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,129 :: 		break;
	GOTO        L_main9
;BracoRobotico.c,131 :: 		case 'p': case 'P':
L_main16:
L_main17:
;BracoRobotico.c,133 :: 		int pos = (int)params[i] >= 0 && (int)params[i] < POSITIONS ? (int)params[i] : 0;
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
	GOTO        L__main42
	MOVLW       0
	SUBWF       R0, 0 
L__main42:
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
	GOTO        L__main43
	MOVLW       3
	SUBWF       R0, 0 
L__main43:
	BTFSC       STATUS+0, 0 
	GOTO        L_main20
L__main38:
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
;BracoRobotico.c,134 :: 		writeStr("begin moving to position");
	MOVLW       ?lstr5_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr5_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,135 :: 		setServosPosition(pos);
	MOVF        main_pos_L4+0, 0 
	MOVWF       FARG_setServosPosition_position+0 
	MOVF        main_pos_L4+1, 0 
	MOVWF       FARG_setServosPosition_position+1 
	CALL        _setServosPosition+0, 0
;BracoRobotico.c,136 :: 		writeStr("end moving to position");
	MOVLW       ?lstr6_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr6_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,138 :: 		break;
	GOTO        L_main9
;BracoRobotico.c,140 :: 		case 'g': case 'G':
L_main22:
L_main23:
;BracoRobotico.c,142 :: 		float gripperAngle = (int)params[i] ? servos[GRIPPER].max : servos[GRIPPER].min;
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
	MOVWF       ?FLOC___mainT68+0 
	MOVF        _servos+29, 0 
	MOVWF       ?FLOC___mainT68+1 
	MOVF        _servos+30, 0 
	MOVWF       ?FLOC___mainT68+2 
	MOVF        _servos+31, 0 
	MOVWF       ?FLOC___mainT68+3 
	GOTO        L_main25
L_main24:
	MOVF        _servos+24, 0 
	MOVWF       ?FLOC___mainT68+0 
	MOVF        _servos+25, 0 
	MOVWF       ?FLOC___mainT68+1 
	MOVF        _servos+26, 0 
	MOVWF       ?FLOC___mainT68+2 
	MOVF        _servos+27, 0 
	MOVWF       ?FLOC___mainT68+3 
L_main25:
	MOVF        ?FLOC___mainT68+0, 0 
	MOVWF       main_gripperAngle_L4+0 
	MOVF        ?FLOC___mainT68+1, 0 
	MOVWF       main_gripperAngle_L4+1 
	MOVF        ?FLOC___mainT68+2, 0 
	MOVWF       main_gripperAngle_L4+2 
	MOVF        ?FLOC___mainT68+3, 0 
	MOVWF       main_gripperAngle_L4+3 
;BracoRobotico.c,143 :: 		ServoWrite(GRIPPER, gripperAngle);
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
;BracoRobotico.c,144 :: 		writeStr("write to gripper");
	MOVLW       ?lstr7_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr7_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,146 :: 		break;
	GOTO        L_main9
;BracoRobotico.c,148 :: 		default:
L_main26:
;BracoRobotico.c,149 :: 		writeStr("");
	MOVLW       ?lstr8_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr8_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,151 :: 		}
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
;BracoRobotico.c,112 :: 		for(i = 0; i < numberOfCommandsRead; i++)
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;BracoRobotico.c,152 :: 		}
	GOTO        L_main5
L_main6:
;BracoRobotico.c,153 :: 		}
	GOTO        L_main2
;BracoRobotico.c,154 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_parser:

;BracoRobotico.c,157 :: 		int parser(char* input, char* commands, float* params)
;BracoRobotico.c,159 :: 		int i = 0;
	CLRF        parser_i_L0+0 
	CLRF        parser_i_L0+1 
;BracoRobotico.c,160 :: 		char* token = strtok (input, ";");
	MOVF        FARG_parser_input+0, 0 
	MOVWF       FARG_strtok_s1+0 
	MOVF        FARG_parser_input+1, 0 
	MOVWF       FARG_strtok_s1+1 
	MOVLW       ?lstr9_BracoRobotico+0
	MOVWF       FARG_strtok_s2+0 
	MOVLW       hi_addr(?lstr9_BracoRobotico+0)
	MOVWF       FARG_strtok_s2+1 
	CALL        _strtok+0, 0
	MOVF        R0, 0 
	MOVWF       parser_token_L0+0 
	MOVF        R1, 0 
	MOVWF       parser_token_L0+1 
;BracoRobotico.c,162 :: 		while (token && i < MAX_COMMANDS){
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
	GOTO        L__parser45
	MOVLW       10
	SUBWF       parser_i_L0+0, 0 
L__parser45:
	BTFSC       STATUS+0, 0 
	GOTO        L_parser28
L__parser39:
;BracoRobotico.c,163 :: 		commands[i] = token[1];
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
;BracoRobotico.c,164 :: 		params[i++] = atof(&token[2]);
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
;BracoRobotico.c,165 :: 		token = strtok (0, ";");
	CLRF        FARG_strtok_s1+0 
	CLRF        FARG_strtok_s1+1 
	MOVLW       ?lstr10_BracoRobotico+0
	MOVWF       FARG_strtok_s2+0 
	MOVLW       hi_addr(?lstr10_BracoRobotico+0)
	MOVWF       FARG_strtok_s2+1 
	CALL        _strtok+0, 0
	MOVF        R0, 0 
	MOVWF       parser_token_L0+0 
	MOVF        R1, 0 
	MOVWF       parser_token_L0+1 
;BracoRobotico.c,166 :: 		}
	GOTO        L_parser27
L_parser28:
;BracoRobotico.c,168 :: 		return i;
	MOVF        parser_i_L0+0, 0 
	MOVWF       R0 
	MOVF        parser_i_L0+1, 0 
	MOVWF       R1 
;BracoRobotico.c,169 :: 		}
L_end_parser:
	RETURN      0
; end of _parser

_limitAngle:

;BracoRobotico.c,172 :: 		float limitAngle(float angle, int id)
;BracoRobotico.c,174 :: 		if(angle > servos[id].max)
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
;BracoRobotico.c,175 :: 		return servos[id].max;
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
;BracoRobotico.c,176 :: 		else if(angle < servos[id].min)
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_limitAngle_id+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_id+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__limitAngle51:
	BZ          L__limitAngle52
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__limitAngle51
L__limitAngle52:
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
;BracoRobotico.c,177 :: 		return servos[id].min;
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_limitAngle_id+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_id+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__limitAngle53:
	BZ          L__limitAngle54
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__limitAngle53
L__limitAngle54:
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
;BracoRobotico.c,178 :: 		return angle;
	MOVF        FARG_limitAngle_angle+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_angle+1, 0 
	MOVWF       R1 
	MOVF        FARG_limitAngle_angle+2, 0 
	MOVWF       R2 
	MOVF        FARG_limitAngle_angle+3, 0 
	MOVWF       R3 
;BracoRobotico.c,179 :: 		}
L_end_limitAngle:
	RETURN      0
; end of _limitAngle

_writeFloat:

;BracoRobotico.c,182 :: 		void writeFloat(float f)
;BracoRobotico.c,185 :: 		FloatToStr(f, str);
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
;BracoRobotico.c,186 :: 		UART1_Write_Text("\r\n");
	MOVLW       ?lstr11_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr11_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,187 :: 		UART1_Write_Text(str);
	MOVLW       writeFloat_str_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(writeFloat_str_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,188 :: 		UART1_Write_Text("\r\n");
	MOVLW       ?lstr12_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr12_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,189 :: 		}
L_end_writeFloat:
	RETURN      0
; end of _writeFloat

_writeStr:

;BracoRobotico.c,192 :: 		void writeStr(char* str)
;BracoRobotico.c,194 :: 		UART1_Write_Text("\r\n");
	MOVLW       ?lstr13_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr13_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,195 :: 		UART1_Write_Text(str);
	MOVF        FARG_writeStr_str+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_writeStr_str+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,196 :: 		UART1_Write_Text("\r\n");
	MOVLW       ?lstr14_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr14_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,197 :: 		}
L_end_writeStr:
	RETURN      0
; end of _writeStr

_setServosPosition:

;BracoRobotico.c,199 :: 		void setServosPosition(int pos)
;BracoRobotico.c,203 :: 		it[BASE].stepSize = (anglesMatrix[pos][BASE] - it[BASE].beginAngle) / NUMBER_OF_STEPS;
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_setServosPosition_pos+0, 0 
	MOVWF       R4 
	MOVF        FARG_setServosPosition_pos+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _anglesMatrix+0
	ADDWF       R0, 0 
	MOVWF       FLOC__setServosPosition+0 
	MOVLW       hi_addr(_anglesMatrix+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__setServosPosition+1 
	MOVFF       FLOC__setServosPosition+0, FSR0
	MOVFF       FLOC__setServosPosition+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        _it+0, 0 
	MOVWF       R4 
	MOVF        _it+1, 0 
	MOVWF       R5 
	MOVF        _it+2, 0 
	MOVWF       R6 
	MOVF        _it+3, 0 
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _it+4 
	MOVF        R1, 0 
	MOVWF       _it+5 
	MOVF        R2, 0 
	MOVWF       _it+6 
	MOVF        R3, 0 
	MOVWF       _it+7 
;BracoRobotico.c,204 :: 		it[SHOULDER].stepSize = (anglesMatrix[pos][SHOULDER] - it[SHOULDER].beginAngle) / NUMBER_OF_STEPS;
	MOVLW       4
	ADDWF       FLOC__setServosPosition+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FLOC__setServosPosition+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        _it+8, 0 
	MOVWF       R4 
	MOVF        _it+9, 0 
	MOVWF       R5 
	MOVF        _it+10, 0 
	MOVWF       R6 
	MOVF        _it+11, 0 
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _it+12 
	MOVF        R1, 0 
	MOVWF       _it+13 
	MOVF        R2, 0 
	MOVWF       _it+14 
	MOVF        R3, 0 
	MOVWF       _it+15 
;BracoRobotico.c,205 :: 		it[ELBOW].stepSize = (anglesMatrix[pos][ELBOW] - it[ELBOW].beginAngle) / NUMBER_OF_STEPS;
	MOVLW       8
	ADDWF       FLOC__setServosPosition+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FLOC__setServosPosition+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        _it+16, 0 
	MOVWF       R4 
	MOVF        _it+17, 0 
	MOVWF       R5 
	MOVF        _it+18, 0 
	MOVWF       R6 
	MOVF        _it+19, 0 
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _it+20 
	MOVF        R1, 0 
	MOVWF       _it+21 
	MOVF        R2, 0 
	MOVWF       _it+22 
	MOVF        R3, 0 
	MOVWF       _it+23 
;BracoRobotico.c,207 :: 		for(i = 1; i <= NUMBER_OF_STEPS; i++)
	MOVLW       1
	MOVWF       setServosPosition_i_L0+0 
	MOVLW       0
	MOVWF       setServosPosition_i_L0+1 
L_setServosPosition34:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       setServosPosition_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__setServosPosition58
	MOVF        setServosPosition_i_L0+0, 0 
	SUBLW       10
L__setServosPosition58:
	BTFSS       STATUS+0, 0 
	GOTO        L_setServosPosition35
;BracoRobotico.c,209 :: 		ServoWrite(BASE, limitAngle(it[BASE].beginAngle + i*it[BASE].stepSize, BASE));
	MOVF        setServosPosition_i_L0+0, 0 
	MOVWF       R0 
	MOVF        setServosPosition_i_L0+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        _it+4, 0 
	MOVWF       R4 
	MOVF        _it+5, 0 
	MOVWF       R5 
	MOVF        _it+6, 0 
	MOVWF       R6 
	MOVF        _it+7, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        _it+0, 0 
	MOVWF       R4 
	MOVF        _it+1, 0 
	MOVWF       R5 
	MOVF        _it+2, 0 
	MOVWF       R6 
	MOVF        _it+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_limitAngle_angle+3 
	CLRF        FARG_limitAngle_id+0 
	CLRF        FARG_limitAngle_id+1 
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
;BracoRobotico.c,210 :: 		ServoWrite(SHOULDER, limitAngle(it[SHOULDER].beginAngle + i*it[SHOULDER].stepSize, SHOULDER));
	MOVF        setServosPosition_i_L0+0, 0 
	MOVWF       R0 
	MOVF        setServosPosition_i_L0+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        _it+12, 0 
	MOVWF       R4 
	MOVF        _it+13, 0 
	MOVWF       R5 
	MOVF        _it+14, 0 
	MOVWF       R6 
	MOVF        _it+15, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        _it+8, 0 
	MOVWF       R4 
	MOVF        _it+9, 0 
	MOVWF       R5 
	MOVF        _it+10, 0 
	MOVWF       R6 
	MOVF        _it+11, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_limitAngle_angle+3 
	MOVLW       1
	MOVWF       FARG_limitAngle_id+0 
	MOVLW       0
	MOVWF       FARG_limitAngle_id+1 
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
;BracoRobotico.c,211 :: 		ServoWrite(ELBOW, limitAngle(it[ELBOW].beginAngle + i*it[ELBOW].stepSize, ELBOW));
	MOVF        setServosPosition_i_L0+0, 0 
	MOVWF       R0 
	MOVF        setServosPosition_i_L0+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        _it+20, 0 
	MOVWF       R4 
	MOVF        _it+21, 0 
	MOVWF       R5 
	MOVF        _it+22, 0 
	MOVWF       R6 
	MOVF        _it+23, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        _it+16, 0 
	MOVWF       R4 
	MOVF        _it+17, 0 
	MOVWF       R5 
	MOVF        _it+18, 0 
	MOVWF       R6 
	MOVF        _it+19, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_limitAngle_angle+3 
	MOVLW       2
	MOVWF       FARG_limitAngle_id+0 
	MOVLW       0
	MOVWF       FARG_limitAngle_id+1 
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
;BracoRobotico.c,213 :: 		Delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_setServosPosition37:
	DECFSZ      R13, 1, 1
	BRA         L_setServosPosition37
	DECFSZ      R12, 1, 1
	BRA         L_setServosPosition37
	DECFSZ      R11, 1, 1
	BRA         L_setServosPosition37
;BracoRobotico.c,207 :: 		for(i = 1; i <= NUMBER_OF_STEPS; i++)
	INFSNZ      setServosPosition_i_L0+0, 1 
	INCF        setServosPosition_i_L0+1, 1 
;BracoRobotico.c,214 :: 		}
	GOTO        L_setServosPosition34
L_setServosPosition35:
;BracoRobotico.c,216 :: 		it[BASE].beginAngle = it[BASE].beginAngle + NUMBER_OF_STEPS*it[BASE].stepSize;
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       32
	MOVWF       R2 
	MOVLW       130
	MOVWF       R3 
	MOVF        _it+4, 0 
	MOVWF       R4 
	MOVF        _it+5, 0 
	MOVWF       R5 
	MOVF        _it+6, 0 
	MOVWF       R6 
	MOVF        _it+7, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        _it+0, 0 
	MOVWF       R4 
	MOVF        _it+1, 0 
	MOVWF       R5 
	MOVF        _it+2, 0 
	MOVWF       R6 
	MOVF        _it+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _it+0 
	MOVF        R1, 0 
	MOVWF       _it+1 
	MOVF        R2, 0 
	MOVWF       _it+2 
	MOVF        R3, 0 
	MOVWF       _it+3 
;BracoRobotico.c,217 :: 		it[SHOULDER].beginAngle = it[SHOULDER].beginAngle + NUMBER_OF_STEPS*it[SHOULDER].stepSize;
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       32
	MOVWF       R2 
	MOVLW       130
	MOVWF       R3 
	MOVF        _it+12, 0 
	MOVWF       R4 
	MOVF        _it+13, 0 
	MOVWF       R5 
	MOVF        _it+14, 0 
	MOVWF       R6 
	MOVF        _it+15, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        _it+8, 0 
	MOVWF       R4 
	MOVF        _it+9, 0 
	MOVWF       R5 
	MOVF        _it+10, 0 
	MOVWF       R6 
	MOVF        _it+11, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _it+8 
	MOVF        R1, 0 
	MOVWF       _it+9 
	MOVF        R2, 0 
	MOVWF       _it+10 
	MOVF        R3, 0 
	MOVWF       _it+11 
;BracoRobotico.c,218 :: 		it[ELBOW].beginAngle = it[ELBOW].beginAngle + NUMBER_OF_STEPS*it[ELBOW].stepSize;
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       32
	MOVWF       R2 
	MOVLW       130
	MOVWF       R3 
	MOVF        _it+20, 0 
	MOVWF       R4 
	MOVF        _it+21, 0 
	MOVWF       R5 
	MOVF        _it+22, 0 
	MOVWF       R6 
	MOVF        _it+23, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        _it+16, 0 
	MOVWF       R4 
	MOVF        _it+17, 0 
	MOVWF       R5 
	MOVF        _it+18, 0 
	MOVWF       R6 
	MOVF        _it+19, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _it+16 
	MOVF        R1, 0 
	MOVWF       _it+17 
	MOVF        R2, 0 
	MOVWF       _it+18 
	MOVF        R3, 0 
	MOVWF       _it+19 
;BracoRobotico.c,219 :: 		}
L_end_setServosPosition:
	RETURN      0
; end of _setServosPosition
