
_config_io:

;Pres_sensor.c,11 :: 		void config_io()
;Pres_sensor.c,13 :: 		ADCON1=0x0E;
	MOVLW       14
	MOVWF       ADCON1+0 
;Pres_sensor.c,14 :: 		TRISC.RC0=0;
	BCF         TRISC+0, 0 
;Pres_sensor.c,15 :: 		TRISC.RC1=0;
	BCF         TRISC+0, 1 
;Pres_sensor.c,16 :: 		TRISC.RC2=0;
	BCF         TRISC+0, 2 
;Pres_sensor.c,17 :: 		}
L_end_config_io:
	RETURN      0
; end of _config_io

_main:

;Pres_sensor.c,19 :: 		void main()
;Pres_sensor.c,21 :: 		ADC_Init(); // Inicia o canal analógico
	CALL        _ADC_Init+0, 0
;Pres_sensor.c,22 :: 		config_io();
	CALL        _config_io+0, 0
;Pres_sensor.c,23 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Pres_sensor.c,24 :: 		while(1)
L_main0:
;Pres_sensor.c,26 :: 		rAN0 = ADC_Read(0); // realiza a leitura do canal analógico AN0
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       _rAN0+0 
	MOVF        R1, 0 
	MOVWF       _rAN0+1 
	MOVF        R2, 0 
	MOVWF       _rAN0+2 
	MOVF        R3, 0 
	MOVWF       _rAN0+3 
;Pres_sensor.c,27 :: 		rPres = rAN0/40.92;  // 0V - 5V : 0 BAR - 25 BAR
	MOVLW       20
	MOVWF       R4 
	MOVLW       174
	MOVWF       R5 
	MOVLW       35
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _rPres+0 
	MOVF        R1, 0 
	MOVWF       _rPres+1 
	MOVF        R2, 0 
	MOVWF       _rPres+2 
	MOVF        R3, 0 
	MOVWF       _rPres+3 
;Pres_sensor.c,28 :: 		FloatToStr(rPres,sText); // converte a variável do tipo inteiro para string
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
;Pres_sensor.c,29 :: 		UART1_Write_Text(sText ); // imprimi na serial
	MOVLW       _sText+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_sText+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Pres_sensor.c,30 :: 		UART1_Write_Text("  "); // imprimi na serial
	MOVLW       ?lstr1_Pres_sensor+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_Pres_sensor+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Pres_sensor.c,31 :: 		delay_ms(500);
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
;Pres_sensor.c,33 :: 		if (rPres < 5)
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	MOVF        _rPres+0, 0 
	MOVWF       R0 
	MOVF        _rPres+1, 0 
	MOVWF       R1 
	MOVF        _rPres+2, 0 
	MOVWF       R2 
	MOVF        _rPres+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
;Pres_sensor.c,35 :: 		D1=1;
	BSF         PORTC+0, 0 
;Pres_sensor.c,36 :: 		D2=1;
	BSF         PORTC+0, 1 
;Pres_sensor.c,37 :: 		D3=1;
	BSF         PORTC+0, 2 
;Pres_sensor.c,38 :: 		}
	GOTO        L_main4
L_main3:
;Pres_sensor.c,39 :: 		else if (rPres >= 5 && rPres < 12.5)
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	MOVF        _rPres+0, 0 
	MOVWF       R0 
	MOVF        _rPres+1, 0 
	MOVWF       R1 
	MOVF        _rPres+2, 0 
	MOVWF       R2 
	MOVF        _rPres+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	MOVF        _rPres+0, 0 
	MOVWF       R0 
	MOVF        _rPres+1, 0 
	MOVWF       R1 
	MOVF        _rPres+2, 0 
	MOVWF       R2 
	MOVF        _rPres+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
L__main15:
;Pres_sensor.c,41 :: 		D1=0;
	BCF         PORTC+0, 0 
;Pres_sensor.c,42 :: 		D2=1;
	BSF         PORTC+0, 1 
;Pres_sensor.c,43 :: 		D3=1;
	BSF         PORTC+0, 2 
;Pres_sensor.c,44 :: 		}
	GOTO        L_main8
L_main7:
;Pres_sensor.c,45 :: 		else if (rPres >= 12.5 && rPres < 22.5)
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	MOVF        _rPres+0, 0 
	MOVWF       R0 
	MOVF        _rPres+1, 0 
	MOVWF       R1 
	MOVF        _rPres+2, 0 
	MOVWF       R2 
	MOVF        _rPres+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       52
	MOVWF       R6 
	MOVLW       131
	MOVWF       R7 
	MOVF        _rPres+0, 0 
	MOVWF       R0 
	MOVF        _rPres+1, 0 
	MOVWF       R1 
	MOVF        _rPres+2, 0 
	MOVWF       R2 
	MOVF        _rPres+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
L__main14:
;Pres_sensor.c,47 :: 		D1=0;
	BCF         PORTC+0, 0 
;Pres_sensor.c,48 :: 		D2=0;
	BCF         PORTC+0, 1 
;Pres_sensor.c,49 :: 		D3=1;
	BSF         PORTC+0, 2 
;Pres_sensor.c,50 :: 		}
	GOTO        L_main12
L_main11:
;Pres_sensor.c,51 :: 		else if (rPres >= 22.5)
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       52
	MOVWF       R6 
	MOVLW       131
	MOVWF       R7 
	MOVF        _rPres+0, 0 
	MOVWF       R0 
	MOVF        _rPres+1, 0 
	MOVWF       R1 
	MOVF        _rPres+2, 0 
	MOVWF       R2 
	MOVF        _rPres+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
;Pres_sensor.c,53 :: 		D1=0;
	BCF         PORTC+0, 0 
;Pres_sensor.c,54 :: 		D2=0;
	BCF         PORTC+0, 1 
;Pres_sensor.c,55 :: 		D3=0;
	BCF         PORTC+0, 2 
;Pres_sensor.c,56 :: 		}
L_main13:
L_main12:
L_main8:
L_main4:
;Pres_sensor.c,57 :: 		}
	GOTO        L_main0
;Pres_sensor.c,58 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
