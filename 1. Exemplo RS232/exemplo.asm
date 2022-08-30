
_main:

;exemplo.c,5 :: 		void main()
;exemplo.c,7 :: 		UART1_Init(9600); // inicia a comunicação serial 9600 bits/segundo
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;exemplo.c,8 :: 		while(1)
L_main0:
;exemplo.c,10 :: 		if(UART1_Data_Ready()) // verifica se tem dado valido na porta
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main2
;exemplo.c,12 :: 		cCaracter= UART1_Read(); // faz a leitura de dados na porta
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _cCaracter+0 
;exemplo.c,13 :: 		UART1_Write(cCaracter); // imprime na serial o caracter recebido
	MOVF        R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;exemplo.c,14 :: 		}
L_main2:
;exemplo.c,15 :: 		}
	GOTO        L_main0
;exemplo.c,16 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
