
_config_io:

;Leitura_tensao.c,11 :: 		void config_io()
;Leitura_tensao.c,13 :: 		ADCON1=0x0E;
	MOVLW       14
	MOVWF       ADCON1+0 
;Leitura_tensao.c,14 :: 		TRISC.RC0=0;
	BCF         TRISC+0, 0 
;Leitura_tensao.c,15 :: 		TRISC.RC1=0;
	BCF         TRISC+0, 1 
;Leitura_tensao.c,16 :: 		TRISC.RC2=0;
	BCF         TRISC+0, 2 
;Leitura_tensao.c,17 :: 		}
L_end_config_io:
	RETURN      0
; end of _config_io

_main:

;Leitura_tensao.c,19 :: 		void main()
;Leitura_tensao.c,21 :: 		ADC_Init(); // Inicia o canal analógico
	CALL        _ADC_Init+0, 0
;Leitura_tensao.c,22 :: 		config_io();
	CALL        _config_io+0, 0
;Leitura_tensao.c,23 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Leitura_tensao.c,24 :: 		while(1)
L_main0:
;Leitura_tensao.c,26 :: 		iAN0 = ADC_Read(0); // realiza a leitura do canal analógico AN0
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       _iAN0+0 
	MOVF        R1, 0 
	MOVWF       _iAN0+1 
	MOVF        R2, 0 
	MOVWF       _iAN0+2 
	MOVF        R3, 0 
	MOVWF       _iAN0+3 
;Leitura_tensao.c,27 :: 		iTensao = iAN0/204.5;
	MOVLW       0
	MOVWF       R4 
	MOVLW       128
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       134
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _iTensao+0 
	MOVF        R1, 0 
	MOVWF       _iTensao+1 
	MOVF        R2, 0 
	MOVWF       _iTensao+2 
	MOVF        R3, 0 
	MOVWF       _iTensao+3 
;Leitura_tensao.c,28 :: 		FloatToStr(iTensao,sText); // converte a variável do tipo inteiro para string
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _sText+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_sText+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Leitura_tensao.c,29 :: 		UART1_Write_Text(sText); // imprimi na serial
	MOVLW       _sText+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_sText+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Leitura_tensao.c,30 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
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
;Leitura_tensao.c,32 :: 		if (iTensao < 1)
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	MOVF        _iTensao+0, 0 
	MOVWF       R0 
	MOVF        _iTensao+1, 0 
	MOVWF       R1 
	MOVF        _iTensao+2, 0 
	MOVWF       R2 
	MOVF        _iTensao+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
;Leitura_tensao.c,34 :: 		D1=1;
	BSF         PORTC+0, 0 
;Leitura_tensao.c,35 :: 		D2=1;
	BSF         PORTC+0, 1 
;Leitura_tensao.c,36 :: 		D3=1;
	BSF         PORTC+0, 2 
;Leitura_tensao.c,37 :: 		}
	GOTO        L_main4
L_main3:
;Leitura_tensao.c,38 :: 		else if (iTensao >= 1 && iTensao <= 3)
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	MOVF        _iTensao+0, 0 
	MOVWF       R0 
	MOVF        _iTensao+1, 0 
	MOVWF       R1 
	MOVF        _iTensao+2, 0 
	MOVWF       R2 
	MOVF        _iTensao+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
	MOVF        _iTensao+0, 0 
	MOVWF       R4 
	MOVF        _iTensao+1, 0 
	MOVWF       R5 
	MOVF        _iTensao+2, 0 
	MOVWF       R6 
	MOVF        _iTensao+3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       64
	MOVWF       R2 
	MOVLW       128
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
L__main15:
;Leitura_tensao.c,40 :: 		D1=0;
	BCF         PORTC+0, 0 
;Leitura_tensao.c,41 :: 		D2=1;
	BSF         PORTC+0, 1 
;Leitura_tensao.c,42 :: 		D3=1;
	BSF         PORTC+0, 2 
;Leitura_tensao.c,43 :: 		}
	GOTO        L_main8
L_main7:
;Leitura_tensao.c,44 :: 		else if (iTensao >= 3 && iTensao <= 4)
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       64
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	MOVF        _iTensao+0, 0 
	MOVWF       R0 
	MOVF        _iTensao+1, 0 
	MOVWF       R1 
	MOVF        _iTensao+2, 0 
	MOVWF       R2 
	MOVF        _iTensao+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
	MOVF        _iTensao+0, 0 
	MOVWF       R4 
	MOVF        _iTensao+1, 0 
	MOVWF       R5 
	MOVF        _iTensao+2, 0 
	MOVWF       R6 
	MOVF        _iTensao+3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       129
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
L__main14:
;Leitura_tensao.c,46 :: 		D1=0;
	BCF         PORTC+0, 0 
;Leitura_tensao.c,47 :: 		D2=0;
	BCF         PORTC+0, 1 
;Leitura_tensao.c,48 :: 		D3=1;
	BSF         PORTC+0, 2 
;Leitura_tensao.c,49 :: 		}
	GOTO        L_main12
L_main11:
;Leitura_tensao.c,50 :: 		else if (iTensao > 4)
	MOVF        _iTensao+0, 0 
	MOVWF       R4 
	MOVF        _iTensao+1, 0 
	MOVWF       R5 
	MOVF        _iTensao+2, 0 
	MOVWF       R6 
	MOVF        _iTensao+3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       129
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
;Leitura_tensao.c,52 :: 		D1=0;
	BCF         PORTC+0, 0 
;Leitura_tensao.c,53 :: 		D2=0;
	BCF         PORTC+0, 1 
;Leitura_tensao.c,54 :: 		D3=0;
	BCF         PORTC+0, 2 
;Leitura_tensao.c,55 :: 		}
L_main13:
L_main12:
L_main8:
L_main4:
;Leitura_tensao.c,56 :: 		}
	GOTO        L_main0
;Leitura_tensao.c,57 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
