
_config_io:

;H_BRIDGE_RS232.c,9 :: 		void config_io()
;H_BRIDGE_RS232.c,11 :: 		TRISD=0X00;
	CLRF        TRISD+0 
;H_BRIDGE_RS232.c,12 :: 		PORTD=0X00;
	CLRF        PORTD+0 
;H_BRIDGE_RS232.c,13 :: 		}
L_end_config_io:
	RETURN      0
; end of _config_io

_main:

;H_BRIDGE_RS232.c,15 :: 		void main()
;H_BRIDGE_RS232.c,17 :: 		config_io();
	CALL        _config_io+0, 0
;H_BRIDGE_RS232.c,18 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;H_BRIDGE_RS232.c,19 :: 		while(1)
L_main0:
;H_BRIDGE_RS232.c,21 :: 		if(UART1_Data_Ready()) // verifica se tem dado valido na porta
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main2
;H_BRIDGE_RS232.c,23 :: 		cCaracter= UART1_Read(); // faz a leitura de dados na porta
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _cCaracter+0 
;H_BRIDGE_RS232.c,24 :: 		switch(cCaracter)
	GOTO        L_main3
;H_BRIDGE_RS232.c,26 :: 		case 'H':
L_main5:
;H_BRIDGE_RS232.c,27 :: 		M1_1 = 1;
	BSF         PORTD+0, 0 
;H_BRIDGE_RS232.c,28 :: 		M1_2 = 0;
	BCF         PORTD+0, 1 
;H_BRIDGE_RS232.c,29 :: 		M1_3 = 0;
	BCF         PORTD+0, 2 
;H_BRIDGE_RS232.c,30 :: 		M1_4 = 1;
	BSF         PORTD+0, 3 
;H_BRIDGE_RS232.c,31 :: 		UART1_Write_Text("HORÁRIO");
	MOVLW       ?lstr1_H_BRIDGE_RS232+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_H_BRIDGE_RS232+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;H_BRIDGE_RS232.c,32 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;H_BRIDGE_RS232.c,33 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;H_BRIDGE_RS232.c,34 :: 		break;
	GOTO        L_main4
;H_BRIDGE_RS232.c,36 :: 		case 'A':
L_main6:
;H_BRIDGE_RS232.c,37 :: 		M1_1 = 0;
	BCF         PORTD+0, 0 
;H_BRIDGE_RS232.c,38 :: 		M1_2 = 1;
	BSF         PORTD+0, 1 
;H_BRIDGE_RS232.c,39 :: 		M1_3 = 1;
	BSF         PORTD+0, 2 
;H_BRIDGE_RS232.c,40 :: 		M1_4 = 0;
	BCF         PORTD+0, 3 
;H_BRIDGE_RS232.c,41 :: 		UART1_Write_Text(" ANTI-HORÁRIO");
	MOVLW       ?lstr2_H_BRIDGE_RS232+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_H_BRIDGE_RS232+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;H_BRIDGE_RS232.c,42 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;H_BRIDGE_RS232.c,43 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;H_BRIDGE_RS232.c,44 :: 		break;
	GOTO        L_main4
;H_BRIDGE_RS232.c,46 :: 		case 'P':
L_main7:
;H_BRIDGE_RS232.c,47 :: 		M1_1 = 0;
	BCF         PORTD+0, 0 
;H_BRIDGE_RS232.c,48 :: 		M1_2 = 0;
	BCF         PORTD+0, 1 
;H_BRIDGE_RS232.c,49 :: 		M1_3 = 0;
	BCF         PORTD+0, 2 
;H_BRIDGE_RS232.c,50 :: 		M1_4 = 0;
	BCF         PORTD+0, 3 
;H_BRIDGE_RS232.c,51 :: 		UART1_Write_Text(" PARADO");
	MOVLW       ?lstr3_H_BRIDGE_RS232+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_H_BRIDGE_RS232+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;H_BRIDGE_RS232.c,52 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;H_BRIDGE_RS232.c,53 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;H_BRIDGE_RS232.c,54 :: 		break;
	GOTO        L_main4
;H_BRIDGE_RS232.c,55 :: 		}
L_main3:
	MOVF        _cCaracter+0, 0 
	XORLW       72
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
	MOVF        _cCaracter+0, 0 
	XORLW       65
	BTFSC       STATUS+0, 2 
	GOTO        L_main6
	MOVF        _cCaracter+0, 0 
	XORLW       80
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
L_main4:
;H_BRIDGE_RS232.c,56 :: 		}
L_main2:
;H_BRIDGE_RS232.c,58 :: 		}
	GOTO        L_main0
;H_BRIDGE_RS232.c,59 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
