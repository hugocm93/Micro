
_main:

;BracoRobotico.c,76 :: 		void main()
;BracoRobotico.c,81 :: 		char delimiter[] = "end";
	MOVLW       101
	MOVWF       main_delimiter_L0+0 
	MOVLW       110
	MOVWF       main_delimiter_L0+1 
	MOVLW       100
	MOVWF       main_delimiter_L0+2 
	CLRF        main_delimiter_L0+3 
	CLRF        main_numberOfCommandsRead_L0+0 
	CLRF        main_numberOfCommandsRead_L0+1 
;BracoRobotico.c,89 :: 		ADCON1 = 0x06;
	MOVLW       6
	MOVWF       ADCON1+0 
;BracoRobotico.c,90 :: 		trisd = 0;
	CLRF        TRISD+0 
;BracoRobotico.c,91 :: 		portd = 0;
	CLRF        PORTD+0 
;BracoRobotico.c,94 :: 		meArm_calib(armData);
	MOVLW       _armData+0
	MOVWF       FARG_meArm_calib_calib+0 
	MOVLW       hi_addr(_armData+0)
	MOVWF       FARG_meArm_calib_calib+1 
	CALL        _meArm_calib+0, 0
;BracoRobotico.c,95 :: 		meArm_begin(&PORTD, BASE, SHOULDER, ELBOW, GRIPPER);
	MOVLW       PORTD+0
	MOVWF       FARG_meArm_begin_portAddr+0 
	CLRF        FARG_meArm_begin_pinBase+0 
	CLRF        FARG_meArm_begin_pinBase+1 
	MOVLW       1
	MOVWF       FARG_meArm_begin_pinShoulder+0 
	MOVLW       0
	MOVWF       FARG_meArm_begin_pinShoulder+1 
	MOVLW       2
	MOVWF       FARG_meArm_begin_pinElbow+0 
	MOVLW       0
	MOVWF       FARG_meArm_begin_pinElbow+1 
	MOVLW       3
	MOVWF       FARG_meArm_begin_pinGripper+0 
	MOVLW       0
	MOVWF       FARG_meArm_begin_pinGripper+1 
	CALL        _meArm_begin+0, 0
;BracoRobotico.c,98 :: 		meArm_goDirectlyTo(xyzMatrix[3][0],xyzMatrix[3][1],xyzMatrix[3][2]);
	MOVF        _xyzMatrix+36, 0 
	MOVWF       FARG_meArm_goDirectlyTo_x+0 
	MOVF        _xyzMatrix+37, 0 
	MOVWF       FARG_meArm_goDirectlyTo_x+1 
	MOVF        _xyzMatrix+38, 0 
	MOVWF       FARG_meArm_goDirectlyTo_x+2 
	MOVF        _xyzMatrix+39, 0 
	MOVWF       FARG_meArm_goDirectlyTo_x+3 
	MOVF        _xyzMatrix+40, 0 
	MOVWF       FARG_meArm_goDirectlyTo_y+0 
	MOVF        _xyzMatrix+41, 0 
	MOVWF       FARG_meArm_goDirectlyTo_y+1 
	MOVF        _xyzMatrix+42, 0 
	MOVWF       FARG_meArm_goDirectlyTo_y+2 
	MOVF        _xyzMatrix+43, 0 
	MOVWF       FARG_meArm_goDirectlyTo_y+3 
	MOVF        _xyzMatrix+44, 0 
	MOVWF       FARG_meArm_goDirectlyTo_z+0 
	MOVF        _xyzMatrix+45, 0 
	MOVWF       FARG_meArm_goDirectlyTo_z+1 
	MOVF        _xyzMatrix+46, 0 
	MOVWF       FARG_meArm_goDirectlyTo_z+2 
	MOVF        _xyzMatrix+47, 0 
	MOVWF       FARG_meArm_goDirectlyTo_z+3 
	CALL        _meArm_goDirectlyTo+0, 0
;BracoRobotico.c,115 :: 		UART1_Init(57600);
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;BracoRobotico.c,116 :: 		Delay_ms(200);
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
;BracoRobotico.c,117 :: 		writeStr("Start:");
	MOVLW       ?lstr1_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr1_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,118 :: 		while(TRUE)
L_main1:
;BracoRobotico.c,120 :: 		if(!UART1_Data_Ready())
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
;BracoRobotico.c,122 :: 		continue;
	GOTO        L_main1
;BracoRobotico.c,123 :: 		}
L_main3:
;BracoRobotico.c,125 :: 		UART1_Read_Text(input, delimiter, ATTEMPTS);
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
;BracoRobotico.c,126 :: 		numberOfCommandsRead = parser(input, commands, params);
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
;BracoRobotico.c,128 :: 		for(i = 0; i < numberOfCommandsRead; i++)
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main4:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       main_numberOfCommandsRead_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main36
	MOVF        main_numberOfCommandsRead_L0+0, 0 
	SUBWF       main_i_L0+0, 0 
L__main36:
	BTFSC       STATUS+0, 0 
	GOTO        L_main5
;BracoRobotico.c,130 :: 		switch(commands[i])
	MOVLW       main_commands_L0+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(main_commands_L0+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FLOC__main+1 
	GOTO        L_main7
;BracoRobotico.c,132 :: 		case 'b': case 'B':
L_main9:
L_main10:
;BracoRobotico.c,133 :: 		setServoAngle(BASE, params[i]);
	CLRF        FARG_setServoAngle_id+0 
	CLRF        FARG_setServoAngle_id+1 
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
	MOVWF       FARG_setServoAngle_angle+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_setServoAngle_angle+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_setServoAngle_angle+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_setServoAngle_angle+3 
	CALL        _setServoAngle+0, 0
;BracoRobotico.c,134 :: 		writeStr("write to base");
	MOVLW       ?lstr2_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr2_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,135 :: 		break;
	GOTO        L_main8
;BracoRobotico.c,137 :: 		case 'o': case 'O':
L_main11:
L_main12:
;BracoRobotico.c,138 :: 		setServoAngle(SHOULDER, params[i]);
	MOVLW       1
	MOVWF       FARG_setServoAngle_id+0 
	MOVLW       0
	MOVWF       FARG_setServoAngle_id+1 
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
	MOVWF       FARG_setServoAngle_angle+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_setServoAngle_angle+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_setServoAngle_angle+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_setServoAngle_angle+3 
	CALL        _setServoAngle+0, 0
;BracoRobotico.c,139 :: 		writeStr("write to shoulder");
	MOVLW       ?lstr3_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr3_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,140 :: 		break;
	GOTO        L_main8
;BracoRobotico.c,142 :: 		case 'c': case 'C':
L_main13:
L_main14:
;BracoRobotico.c,143 :: 		setServoAngle(ELBOW, params[i]);
	MOVLW       2
	MOVWF       FARG_setServoAngle_id+0 
	MOVLW       0
	MOVWF       FARG_setServoAngle_id+1 
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
	MOVWF       FARG_setServoAngle_angle+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_setServoAngle_angle+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_setServoAngle_angle+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_setServoAngle_angle+3 
	CALL        _setServoAngle+0, 0
;BracoRobotico.c,144 :: 		writeStr("write to elbow");
	MOVLW       ?lstr4_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr4_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,145 :: 		break;
	GOTO        L_main8
;BracoRobotico.c,147 :: 		case 'p': case 'P':
L_main15:
L_main16:
;BracoRobotico.c,149 :: 		int pos = (params[i] >= 0 && params[i] < POSITIONS) ? (int)params[i] : 0;
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
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main19
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
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       64
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main19
L__main33:
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
	CALL        _Double2Int+0, 0
	GOTO        L_main20
L_main19:
	CLRF        R0 
	CLRF        R1 
L_main20:
	MOVF        R0, 0 
	MOVWF       main_pos_L4+0 
	MOVF        R1, 0 
	MOVWF       main_pos_L4+1 
;BracoRobotico.c,150 :: 		writeStr("begin moving to position");
	MOVLW       ?lstr5_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr5_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,151 :: 		setServosPosition(pos);
	MOVF        main_pos_L4+0, 0 
	MOVWF       FARG_setServosPosition_position+0 
	MOVF        main_pos_L4+1, 0 
	MOVWF       FARG_setServosPosition_position+1 
	CALL        _setServosPosition+0, 0
;BracoRobotico.c,152 :: 		writeStr("end moving to position");
	MOVLW       ?lstr6_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr6_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,154 :: 		break;
	GOTO        L_main8
;BracoRobotico.c,156 :: 		case 'g': case 'G':
L_main21:
L_main22:
;BracoRobotico.c,159 :: 		if((int)params[i])
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
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main23
;BracoRobotico.c,160 :: 		meArm_openGripper();
	CALL        _meArm_openGripper+0, 0
	GOTO        L_main24
L_main23:
;BracoRobotico.c,162 :: 		meArm_closeGripper();
	CALL        _meArm_closeGripper+0, 0
L_main24:
;BracoRobotico.c,167 :: 		writeStr("write to gripper");
	MOVLW       ?lstr7_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr7_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,169 :: 		break;
	GOTO        L_main8
;BracoRobotico.c,171 :: 		default:
L_main25:
;BracoRobotico.c,172 :: 		writeStr("");
	MOVLW       ?lstr8_BracoRobotico+0
	MOVWF       FARG_writeStr_str+0 
	MOVLW       hi_addr(?lstr8_BracoRobotico+0)
	MOVWF       FARG_writeStr_str+1 
	CALL        _writeStr+0, 0
;BracoRobotico.c,174 :: 		}
	GOTO        L_main8
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
	GOTO        L_main21
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       71
	BTFSC       STATUS+0, 2 
	GOTO        L_main22
	GOTO        L_main25
L_main8:
;BracoRobotico.c,128 :: 		for(i = 0; i < numberOfCommandsRead; i++)
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;BracoRobotico.c,175 :: 		}
	GOTO        L_main4
L_main5:
;BracoRobotico.c,176 :: 		}
	GOTO        L_main1
;BracoRobotico.c,177 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_parser:

;BracoRobotico.c,180 :: 		int parser(char* input, char* commands, float* params)
;BracoRobotico.c,182 :: 		int i = 0;
	CLRF        parser_i_L0+0 
	CLRF        parser_i_L0+1 
;BracoRobotico.c,183 :: 		char* token = strtok (input, ";");
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
;BracoRobotico.c,185 :: 		while (token && i < MAX_COMMANDS){
L_parser26:
	MOVF        parser_token_L0+0, 0 
	IORWF       parser_token_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_parser27
	MOVLW       128
	XORWF       parser_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__parser38
	MOVLW       20
	SUBWF       parser_i_L0+0, 0 
L__parser38:
	BTFSC       STATUS+0, 0 
	GOTO        L_parser27
L__parser34:
;BracoRobotico.c,186 :: 		commands[i] = token[1];
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
;BracoRobotico.c,187 :: 		params[i++] = atof(&token[2]);
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
;BracoRobotico.c,188 :: 		token = strtok (0, ";");
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
;BracoRobotico.c,189 :: 		}
	GOTO        L_parser26
L_parser27:
;BracoRobotico.c,191 :: 		return i;
	MOVF        parser_i_L0+0, 0 
	MOVWF       R0 
	MOVF        parser_i_L0+1, 0 
	MOVWF       R1 
;BracoRobotico.c,192 :: 		}
L_end_parser:
	RETURN      0
; end of _parser

_limitAngle:

;BracoRobotico.c,195 :: 		float limitAngle(float angle, int id)
;BracoRobotico.c,197 :: 		if(angle > servos[id].max)
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_limitAngle_id+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_id+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__limitAngle40:
	BZ          L__limitAngle41
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__limitAngle40
L__limitAngle41:
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
	GOTO        L_limitAngle30
;BracoRobotico.c,198 :: 		return servos[id].max;
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_limitAngle_id+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_id+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__limitAngle42:
	BZ          L__limitAngle43
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__limitAngle42
L__limitAngle43:
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
L_limitAngle30:
;BracoRobotico.c,199 :: 		else if(angle < servos[id].min)
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_limitAngle_id+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_id+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__limitAngle44:
	BZ          L__limitAngle45
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__limitAngle44
L__limitAngle45:
	MOVLW       _servos+0
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_servos+0)
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
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
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
	GOTO        L_limitAngle32
;BracoRobotico.c,200 :: 		return servos[id].min;
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_limitAngle_id+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_id+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__limitAngle46:
	BZ          L__limitAngle47
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__limitAngle46
L__limitAngle47:
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
L_limitAngle32:
;BracoRobotico.c,201 :: 		return angle;
	MOVF        FARG_limitAngle_angle+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_angle+1, 0 
	MOVWF       R1 
	MOVF        FARG_limitAngle_angle+2, 0 
	MOVWF       R2 
	MOVF        FARG_limitAngle_angle+3, 0 
	MOVWF       R3 
;BracoRobotico.c,202 :: 		}
L_end_limitAngle:
	RETURN      0
; end of _limitAngle

_writeFloat:

;BracoRobotico.c,205 :: 		void writeFloat(float f)
;BracoRobotico.c,208 :: 		FloatToStr(f, str);
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
;BracoRobotico.c,209 :: 		UART1_Write_Text("\r\n");
	MOVLW       ?lstr11_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr11_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,210 :: 		UART1_Write_Text(str);
	MOVLW       writeFloat_str_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(writeFloat_str_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,211 :: 		UART1_Write_Text("\r\n");
	MOVLW       ?lstr12_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr12_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,212 :: 		}
L_end_writeFloat:
	RETURN      0
; end of _writeFloat

_writeStr:

;BracoRobotico.c,215 :: 		void writeStr(char* str)
;BracoRobotico.c,217 :: 		UART1_Write_Text("\r\n");
	MOVLW       ?lstr13_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr13_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,218 :: 		UART1_Write_Text(str);
	MOVF        FARG_writeStr_str+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_writeStr_str+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,219 :: 		UART1_Write_Text("\r\n");
	MOVLW       ?lstr14_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr14_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,220 :: 		}
L_end_writeStr:
	RETURN      0
; end of _writeStr

_setServosPosition:

;BracoRobotico.c,223 :: 		void setServosPosition(int pos)
;BracoRobotico.c,226 :: 		meArm_gotoPoint(xyzMatrix[pos][0],xyzMatrix[pos][1],xyzMatrix[pos][2]);
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_setServosPosition_pos+0, 0 
	MOVWF       R4 
	MOVF        FARG_setServosPosition_pos+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _xyzMatrix+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_xyzMatrix+0)
	ADDWFC      R1, 1 
	MOVFF       R0, FSR0
	MOVFF       R1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_meArm_gotoPoint_x+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_meArm_gotoPoint_x+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_meArm_gotoPoint_x+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_meArm_gotoPoint_x+3 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_meArm_gotoPoint_y+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_meArm_gotoPoint_y+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_meArm_gotoPoint_y+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_meArm_gotoPoint_y+3 
	MOVLW       8
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_meArm_gotoPoint_z+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_meArm_gotoPoint_z+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_meArm_gotoPoint_z+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_meArm_gotoPoint_z+3 
	CALL        _meArm_gotoPoint+0, 0
;BracoRobotico.c,247 :: 		}
L_end_setServosPosition:
	RETURN      0
; end of _setServosPosition

_setServoAngle:

;BracoRobotico.c,250 :: 		void setServoAngle(int id, float angle)
;BracoRobotico.c,253 :: 		meArm_servo((char)id, limitAngle(angle, id));
	MOVF        FARG_setServoAngle_angle+0, 0 
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        FARG_setServoAngle_angle+1, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        FARG_setServoAngle_angle+2, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        FARG_setServoAngle_angle+3, 0 
	MOVWF       FARG_limitAngle_angle+3 
	MOVF        FARG_setServoAngle_id+0, 0 
	MOVWF       FARG_limitAngle_id+0 
	MOVF        FARG_setServoAngle_id+1, 0 
	MOVWF       FARG_limitAngle_id+1 
	CALL        _limitAngle+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_meArm_servo_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_meArm_servo_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_meArm_servo_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_meArm_servo_angle+3 
	MOVF        FARG_setServoAngle_id+0, 0 
	MOVWF       FARG_meArm_servo_id+0 
	CALL        _meArm_servo+0, 0
;BracoRobotico.c,257 :: 		}
L_end_setServoAngle:
	RETURN      0
; end of _setServoAngle
