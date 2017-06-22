
_main:

;BracoRobotico.c,33 :: 		void main()
;BracoRobotico.c,37 :: 		char delimiter[] = "end";
	MOVLW       101
	MOVWF       main_delimiter_L0+0 
	MOVLW       110
	MOVWF       main_delimiter_L0+1 
	MOVLW       100
	MOVWF       main_delimiter_L0+2 
	CLRF        main_delimiter_L0+3 
	MOVLW       255
	MOVWF       main_attempts_L0+0 
;BracoRobotico.c,41 :: 		ADCON1 = 0x06;
	MOVLW       6
	MOVWF       ADCON1+0 
;BracoRobotico.c,42 :: 		trisd = 0;
	CLRF        TRISD+0 
;BracoRobotico.c,43 :: 		portd = 0;
	CLRF        PORTD+0 
;BracoRobotico.c,45 :: 		ServoInit(); //Inicializa Servo
	CALL        _ServoInit+0, 0
;BracoRobotico.c,46 :: 		Delay_ms(200);
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
;BracoRobotico.c,47 :: 		UART1_Init(57600);
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;BracoRobotico.c,48 :: 		Delay_ms(200);
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
;BracoRobotico.c,49 :: 		UART1_Write_Text("Start:\r\n");
	MOVLW       ?lstr1_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,51 :: 		ServoAttach(BASE, &PORTD, BASE);
	CLRF        FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	CLRF        FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,52 :: 		ServoAttach(SHOULDER, &PORTD, SHOULDER);
	MOVLW       1
	MOVWF       FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	MOVLW       1
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,53 :: 		ServoAttach(ELBOW, &PORTD, ELBOW);
	MOVLW       2
	MOVWF       FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	MOVLW       2
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,54 :: 		ServoAttach(GRIPPER, &PORTD, GRIPPER);
	MOVLW       3
	MOVWF       FARG_ServoAttach_servo+0 
	MOVLW       PORTD+0
	MOVWF       FARG_ServoAttach_out+0 
	MOVLW       3
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;BracoRobotico.c,56 :: 		ServoWrite(BASE, limitAngle(58, BASE));
	MOVLW       0
	MOVWF       FARG_limitAngle_angle+0 
	MOVLW       0
	MOVWF       FARG_limitAngle_angle+1 
	MOVLW       104
	MOVWF       FARG_limitAngle_angle+2 
	MOVLW       132
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
;BracoRobotico.c,57 :: 		ServoWrite(SHOULDER, limitAngle(72, SHOULDER));
	MOVLW       0
	MOVWF       FARG_limitAngle_angle+0 
	MOVLW       0
	MOVWF       FARG_limitAngle_angle+1 
	MOVLW       16
	MOVWF       FARG_limitAngle_angle+2 
	MOVLW       133
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
;BracoRobotico.c,58 :: 		ServoWrite(ELBOW, limitAngle(-20, ELBOW));
	MOVLW       0
	MOVWF       FARG_limitAngle_angle+0 
	MOVLW       0
	MOVWF       FARG_limitAngle_angle+1 
	MOVLW       160
	MOVWF       FARG_limitAngle_angle+2 
	MOVLW       131
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
;BracoRobotico.c,59 :: 		ServoWrite(GRIPPER, limitAngle(56, GRIPPER));
	MOVLW       0
	MOVWF       FARG_limitAngle_angle+0 
	MOVLW       0
	MOVWF       FARG_limitAngle_angle+1 
	MOVLW       96
	MOVWF       FARG_limitAngle_angle+2 
	MOVLW       132
	MOVWF       FARG_limitAngle_angle+3 
	MOVLW       3
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
	MOVLW       3
	MOVWF       FARG_ServoWrite_srv_id+0 
	CALL        _ServoWrite+0, 0
;BracoRobotico.c,61 :: 		while(1)
L_main2:
;BracoRobotico.c,63 :: 		if(UART1_Data_Ready())
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main4
;BracoRobotico.c,67 :: 		int i, max = 80;
	MOVLW       80
	MOVWF       main_max_L2+0 
	MOVLW       0
	MOVWF       main_max_L2+1 
;BracoRobotico.c,69 :: 		UART1_Read_Text(output, delimiter, attempts);
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
;BracoRobotico.c,70 :: 		max = parser(output, commands, params, max);
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
;BracoRobotico.c,72 :: 		for(i = 0; i < max; i++)
	CLRF        main_i_L2+0 
	CLRF        main_i_L2+1 
L_main5:
	MOVLW       128
	XORWF       main_i_L2+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       main_max_L2+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main31
	MOVF        main_max_L2+0, 0 
	SUBWF       main_i_L2+0, 0 
L__main31:
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;BracoRobotico.c,74 :: 		switch(commands[i])
	MOVLW       main_commands_L2+0
	ADDWF       main_i_L2+0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(main_commands_L2+0)
	ADDWFC      main_i_L2+1, 0 
	MOVWF       FLOC__main+1 
	GOTO        L_main8
;BracoRobotico.c,76 :: 		case 'b':
L_main10:
;BracoRobotico.c,77 :: 		case 'B':
L_main11:
;BracoRobotico.c,78 :: 		ServoWrite(BASE, limitAngle(params[i], BASE));
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
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        R3, 0 
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
;BracoRobotico.c,79 :: 		UART1_Write_Text("write base\r\n");
	MOVLW       ?lstr2_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,80 :: 		break;
	GOTO        L_main9
;BracoRobotico.c,82 :: 		case 'o':
L_main12:
;BracoRobotico.c,83 :: 		case 'O':
L_main13:
;BracoRobotico.c,84 :: 		ServoWrite(SHOULDER, limitAngle(params[i], SHOULDER));
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
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        R3, 0 
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
;BracoRobotico.c,85 :: 		UART1_Write_Text("write shoulder\r\n");
	MOVLW       ?lstr3_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,86 :: 		break;
	GOTO        L_main9
;BracoRobotico.c,88 :: 		case 'c':
L_main14:
;BracoRobotico.c,89 :: 		case 'C':
L_main15:
;BracoRobotico.c,90 :: 		ServoWrite(ELBOW, limitAngle(params[i], ELBOW));
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
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        R3, 0 
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
;BracoRobotico.c,91 :: 		UART1_Write_Text("write elbow\r\n");
	MOVLW       ?lstr4_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,92 :: 		break;
	GOTO        L_main9
;BracoRobotico.c,94 :: 		case 'p':
L_main16:
;BracoRobotico.c,95 :: 		case 'P':
L_main17:
;BracoRobotico.c,96 :: 		ServoWrite(BASE, limitAngle(params[i], BASE));
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
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        R3, 0 
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
;BracoRobotico.c,97 :: 		ServoWrite(SHOULDER, limitAngle(params[i], SHOULDER));
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
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        R3, 0 
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
;BracoRobotico.c,98 :: 		ServoWrite(ELBOW, limitAngle(params[i], ELBOW));
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
	MOVWF       FARG_limitAngle_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_limitAngle_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_limitAngle_angle+2 
	MOVF        R3, 0 
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
;BracoRobotico.c,99 :: 		UART1_Write_Text("write all\r\n");
	MOVLW       ?lstr5_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,100 :: 		break;
	GOTO        L_main9
;BracoRobotico.c,102 :: 		case 'g':
L_main18:
;BracoRobotico.c,103 :: 		case 'G':
L_main19:
;BracoRobotico.c,104 :: 		if(params[i])
	MOVLW       main_params_L2+0
	ADDWF       main_i_L2+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(main_params_L2+0)
	ADDWFC      main_i_L2+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main20
;BracoRobotico.c,105 :: 		ServoWrite(GRIPPER, servos[GRIPPER].max);
	MOVLW       3
	MOVWF       FARG_ServoWrite_srv_id+0 
	MOVF        _servos+28, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        _servos+29, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        _servos+30, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        _servos+31, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	CALL        _ServoWrite+0, 0
	GOTO        L_main21
L_main20:
;BracoRobotico.c,107 :: 		ServoWrite(GRIPPER, servos[GRIPPER].min);
	MOVLW       3
	MOVWF       FARG_ServoWrite_srv_id+0 
	MOVF        _servos+24, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        _servos+25, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        _servos+26, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        _servos+27, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	CALL        _ServoWrite+0, 0
L_main21:
;BracoRobotico.c,109 :: 		UART1_Write_Text("write gripper\r\n");
	MOVLW       ?lstr6_BracoRobotico+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_BracoRobotico+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BracoRobotico.c,110 :: 		break;
	GOTO        L_main9
;BracoRobotico.c,111 :: 		}
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
	GOTO        L_main18
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       71
	BTFSC       STATUS+0, 2 
	GOTO        L_main19
L_main9:
;BracoRobotico.c,72 :: 		for(i = 0; i < max; i++)
	INFSNZ      main_i_L2+0, 1 
	INCF        main_i_L2+1, 1 
;BracoRobotico.c,112 :: 		}
	GOTO        L_main5
L_main6:
;BracoRobotico.c,113 :: 		}
L_main4:
;BracoRobotico.c,114 :: 		}
	GOTO        L_main2
;BracoRobotico.c,115 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_parser:

;BracoRobotico.c,118 :: 		int parser(char* input, char* commands, int* params, int max)
;BracoRobotico.c,120 :: 		int i = 0;
	CLRF        parser_i_L0+0 
	CLRF        parser_i_L0+1 
;BracoRobotico.c,121 :: 		char* token = strtok (input, ";");
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
;BracoRobotico.c,123 :: 		while (token && i < max){
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
	GOTO        L__parser33
	MOVF        FARG_parser_max+0, 0 
	SUBWF       parser_i_L0+0, 0 
L__parser33:
	BTFSC       STATUS+0, 0 
	GOTO        L_parser23
L__parser29:
;BracoRobotico.c,124 :: 		commands[i] = token[1];
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
;BracoRobotico.c,125 :: 		params[i++] = atoi(&token[2]);
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
;BracoRobotico.c,126 :: 		token = strtok (0, ";");
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
;BracoRobotico.c,127 :: 		}
	GOTO        L_parser22
L_parser23:
;BracoRobotico.c,129 :: 		return i;
	MOVF        parser_i_L0+0, 0 
	MOVWF       R0 
	MOVF        parser_i_L0+1, 0 
	MOVWF       R1 
;BracoRobotico.c,130 :: 		}
L_end_parser:
	RETURN      0
; end of _parser

_limitAngle:

;BracoRobotico.c,133 :: 		float limitAngle(float angle, int id)
;BracoRobotico.c,135 :: 		if(angle > servos[id].max)
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_limitAngle_id+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_id+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__limitAngle35:
	BZ          L__limitAngle36
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__limitAngle35
L__limitAngle36:
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
	GOTO        L_limitAngle26
;BracoRobotico.c,136 :: 		return servos[id].max;
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_limitAngle_id+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_id+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__limitAngle37:
	BZ          L__limitAngle38
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__limitAngle37
L__limitAngle38:
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
L_limitAngle26:
;BracoRobotico.c,137 :: 		else if(angle < servos[id].min)
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_limitAngle_id+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_id+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__limitAngle39:
	BZ          L__limitAngle40
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__limitAngle39
L__limitAngle40:
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
	GOTO        L_limitAngle28
;BracoRobotico.c,138 :: 		return servos[id].min;
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_limitAngle_id+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_id+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__limitAngle41:
	BZ          L__limitAngle42
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__limitAngle41
L__limitAngle42:
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
L_limitAngle28:
;BracoRobotico.c,139 :: 		return angle;
	MOVF        FARG_limitAngle_angle+0, 0 
	MOVWF       R0 
	MOVF        FARG_limitAngle_angle+1, 0 
	MOVWF       R1 
	MOVF        FARG_limitAngle_angle+2, 0 
	MOVWF       R2 
	MOVF        FARG_limitAngle_angle+3, 0 
	MOVWF       R3 
;BracoRobotico.c,140 :: 		}
L_end_limitAngle:
	RETURN      0
; end of _limitAngle
