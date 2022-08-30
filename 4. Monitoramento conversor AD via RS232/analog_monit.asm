
_config_ad:

;analog_monit.c,6 :: 		void config_ad()
;analog_monit.c,8 :: 		ADCON1=0x0E; // Configura o Pino (AN0) como canal analógico e o restante com digital
	MOVLW       14
	MOVWF       ADCON1+0 
;analog_monit.c,9 :: 		}
L_end_config_ad:
	RETURN      0
; end of _config_ad

_main:

;analog_monit.c,11 :: 		void main()
;analog_monit.c,13 :: 		ADC_Init(); // Inicia o canal analógico
	CALL        _ADC_Init+0, 0
;analog_monit.c,14 :: 		config_ad();
	CALL        _config_ad+0, 0
;analog_monit.c,15 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;analog_monit.c,16 :: 		while(1)
L_main0:
;analog_monit.c,18 :: 		iAN0= ADC_Read(0); // realiza a leitura do canal analógico AN0
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _iAN0+0 
	MOVF        R1, 0 
	MOVWF       _iAN0+1 
;analog_monit.c,19 :: 		IntToStr(iAN0,sText); // converte a variável do tipo inteiro para string
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _sText+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_sText+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;analog_monit.c,20 :: 		UART1_Write_Text(sText); // imprimi na serial
	MOVLW       _sText+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_sText+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;analog_monit.c,21 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
	NOP
;analog_monit.c,23 :: 		}
	GOTO        L_main0
;analog_monit.c,24 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
