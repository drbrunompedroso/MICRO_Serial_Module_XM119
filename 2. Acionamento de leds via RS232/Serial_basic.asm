
_config_io:

;Serial_basic.c,8 :: 		void config_io()
;Serial_basic.c,10 :: 		TRISD=0X00;
	CLRF        TRISD+0 
;Serial_basic.c,11 :: 		PORTD=0XFF;
	MOVLW       255
	MOVWF       PORTD+0 
;Serial_basic.c,13 :: 		}
L_end_config_io:
	RETURN      0
; end of _config_io

_main:

;Serial_basic.c,15 :: 		void main()
;Serial_basic.c,17 :: 		config_io();
	CALL        _config_io+0, 0
;Serial_basic.c,18 :: 		UART1_Init(9600); // inicia a comunicação serial 9600 bits/segundo
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Serial_basic.c,19 :: 		while(1)
L_main0:
;Serial_basic.c,21 :: 		if(UART1_Data_Ready()) // verifica se tem dado valido na porta
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main2
;Serial_basic.c,23 :: 		cCaracter= UART1_Read(); // faz a leitura de dados na porta
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _cCaracter+0 
;Serial_basic.c,24 :: 		UART1_Write(cCaracter); // imprime na serial o caracter recebido
	MOVF        R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Serial_basic.c,25 :: 		}
L_main2:
;Serial_basic.c,27 :: 		switch(cCaracter)
	GOTO        L_main3
;Serial_basic.c,29 :: 		case 'A':
L_main5:
;Serial_basic.c,30 :: 		D1 = 1;
	BSF         PORTD+0, 0 
;Serial_basic.c,31 :: 		D2 = 1;
	BSF         PORTD+0, 1 
;Serial_basic.c,32 :: 		D3 = 1;
	BSF         PORTD+0, 2 
;Serial_basic.c,33 :: 		break;
	GOTO        L_main4
;Serial_basic.c,35 :: 		case 'B':
L_main6:
;Serial_basic.c,36 :: 		D1 = 0;
	BCF         PORTD+0, 0 
;Serial_basic.c,37 :: 		D2 = 1;
	BSF         PORTD+0, 1 
;Serial_basic.c,38 :: 		D3 = 1;
	BSF         PORTD+0, 2 
;Serial_basic.c,39 :: 		break;
	GOTO        L_main4
;Serial_basic.c,41 :: 		case 'C':
L_main7:
;Serial_basic.c,42 :: 		D1 = 0;
	BCF         PORTD+0, 0 
;Serial_basic.c,43 :: 		D2 = 0;
	BCF         PORTD+0, 1 
;Serial_basic.c,44 :: 		D3 = 1;
	BSF         PORTD+0, 2 
;Serial_basic.c,45 :: 		break;
	GOTO        L_main4
;Serial_basic.c,47 :: 		case 'D':
L_main8:
;Serial_basic.c,48 :: 		D1 = 0;
	BCF         PORTD+0, 0 
;Serial_basic.c,49 :: 		D2 = 0;
	BCF         PORTD+0, 1 
;Serial_basic.c,50 :: 		D3 = 0;
	BCF         PORTD+0, 2 
;Serial_basic.c,51 :: 		break;
	GOTO        L_main4
;Serial_basic.c,52 :: 		}
L_main3:
	MOVF        _cCaracter+0, 0 
	XORLW       65
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
	MOVF        _cCaracter+0, 0 
	XORLW       66
	BTFSC       STATUS+0, 2 
	GOTO        L_main6
	MOVF        _cCaracter+0, 0 
	XORLW       67
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
	MOVF        _cCaracter+0, 0 
	XORLW       68
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
L_main4:
;Serial_basic.c,53 :: 		} // fim While(1)
	GOTO        L_main0
;Serial_basic.c,54 :: 		} // fim Main
L_end_main:
	GOTO        $+0
; end of _main
