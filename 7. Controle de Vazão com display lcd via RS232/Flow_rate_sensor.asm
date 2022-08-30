
_config_io:

;Flow_rate_sensor.c,30 :: 		void config_io()
;Flow_rate_sensor.c,32 :: 		ADCON1=0x0E;
	MOVLW       14
	MOVWF       ADCON1+0 
;Flow_rate_sensor.c,33 :: 		TRISC.RC0=0;
	BCF         TRISC+0, 0 
;Flow_rate_sensor.c,34 :: 		TRISC.RC1=0;
	BCF         TRISC+0, 1 
;Flow_rate_sensor.c,35 :: 		TRISC.RC2=0;
	BCF         TRISC+0, 2 
;Flow_rate_sensor.c,36 :: 		TRISC.RC3=0;
	BCF         TRISC+0, 3 
;Flow_rate_sensor.c,37 :: 		TRISE=0x00;
	CLRF        TRISE+0 
;Flow_rate_sensor.c,38 :: 		PORTE.RE1=0;
	BCF         PORTE+0, 1 
;Flow_rate_sensor.c,39 :: 		}
L_end_config_io:
	RETURN      0
; end of _config_io

_convert:

;Flow_rate_sensor.c,41 :: 		void convert()
;Flow_rate_sensor.c,43 :: 		rAN0 = ADC_Read(0); // realiza a leitura do canal analógico AN0
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
;Flow_rate_sensor.c,44 :: 		rFlow = rAN0/12.78;  // 0 - 1023 : 0 L/min - 80 L/min
	MOVLW       225
	MOVWF       R4 
	MOVLW       122
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _rFlow+0 
	MOVF        R1, 0 
	MOVWF       _rFlow+1 
	MOVF        R2, 0 
	MOVWF       _rFlow+2 
	MOVF        R3, 0 
	MOVWF       _rFlow+3 
;Flow_rate_sensor.c,45 :: 		FloatToStr(rFlow,sText); // converte a variável do tipo inteiro para string
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
;Flow_rate_sensor.c,46 :: 		}
L_end_convert:
	RETURN      0
; end of _convert

_serial:

;Flow_rate_sensor.c,48 :: 		void serial()
;Flow_rate_sensor.c,50 :: 		UART1_Write_Text("vazao:");
	MOVLW       ?lstr1_Flow_rate_sensor+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_Flow_rate_sensor+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Flow_rate_sensor.c,51 :: 		UART1_Write_Text(sText );
	MOVLW       _sText+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_sText+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Flow_rate_sensor.c,52 :: 		UART1_Write_Text("  ");
	MOVLW       ?lstr2_Flow_rate_sensor+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_Flow_rate_sensor+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Flow_rate_sensor.c,53 :: 		UART1_Write_Text("D1:");
	MOVLW       ?lstr3_Flow_rate_sensor+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_Flow_rate_sensor+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Flow_rate_sensor.c,54 :: 		UART1_Write(sD1);
	MOVF        _sD1+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Flow_rate_sensor.c,55 :: 		UART1_Write_Text("  ");
	MOVLW       ?lstr4_Flow_rate_sensor+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_Flow_rate_sensor+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Flow_rate_sensor.c,56 :: 		UART1_Write_Text("D2:");
	MOVLW       ?lstr5_Flow_rate_sensor+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_Flow_rate_sensor+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Flow_rate_sensor.c,57 :: 		UART1_Write(sD2);
	MOVF        _sD2+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Flow_rate_sensor.c,58 :: 		UART1_Write_Text("  ");
	MOVLW       ?lstr6_Flow_rate_sensor+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_Flow_rate_sensor+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Flow_rate_sensor.c,59 :: 		UART1_Write_Text("D3:");
	MOVLW       ?lstr7_Flow_rate_sensor+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr7_Flow_rate_sensor+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Flow_rate_sensor.c,60 :: 		UART1_Write(sD3);
	MOVF        _sD3+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Flow_rate_sensor.c,61 :: 		UART1_Write_Text("  ");
	MOVLW       ?lstr8_Flow_rate_sensor+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr8_Flow_rate_sensor+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Flow_rate_sensor.c,62 :: 		UART1_Write_Text("D4:");
	MOVLW       ?lstr9_Flow_rate_sensor+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr9_Flow_rate_sensor+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Flow_rate_sensor.c,63 :: 		UART1_Write(sD4);
	MOVF        _sD4+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Flow_rate_sensor.c,64 :: 		UART1_Write_Text("  ");
	MOVLW       ?lstr10_Flow_rate_sensor+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr10_Flow_rate_sensor+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Flow_rate_sensor.c,65 :: 		}
L_end_serial:
	RETURN      0
; end of _serial

_lcd:

;Flow_rate_sensor.c,67 :: 		void lcd()
;Flow_rate_sensor.c,69 :: 		LCD_Out(1,1,"CONTROLE VAZAO");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr11_Flow_rate_sensor+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_Flow_rate_sensor+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Flow_rate_sensor.c,70 :: 		LCD_Out(2,1,"VAZAO:");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr12_Flow_rate_sensor+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr12_Flow_rate_sensor+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Flow_rate_sensor.c,71 :: 		LCD_Out(2,7,sText);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _sText+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_sText+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Flow_rate_sensor.c,72 :: 		LCD_Out(2,12,"L/min    ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr13_Flow_rate_sensor+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr13_Flow_rate_sensor+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Flow_rate_sensor.c,73 :: 		delay_ms(600);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       23
	MOVWF       R12, 0
	MOVLW       106
	MOVWF       R13, 0
L_lcd0:
	DECFSZ      R13, 1, 1
	BRA         L_lcd0
	DECFSZ      R12, 1, 1
	BRA         L_lcd0
	DECFSZ      R11, 1, 1
	BRA         L_lcd0
	NOP
;Flow_rate_sensor.c,74 :: 		}
L_end_lcd:
	RETURN      0
; end of _lcd

_main:

;Flow_rate_sensor.c,76 :: 		void main()
;Flow_rate_sensor.c,78 :: 		ADC_Init(); // Inicia o canal analógico
	CALL        _ADC_Init+0, 0
;Flow_rate_sensor.c,79 :: 		config_io();
	CALL        _config_io+0, 0
;Flow_rate_sensor.c,80 :: 		Lcd_Init(); // Inicia o LCD
	CALL        _Lcd_Init+0, 0
;Flow_rate_sensor.c,81 :: 		Lcd_Cmd(_LCD_CLEAR); // Limpa o Display de LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Flow_rate_sensor.c,82 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Desliga o cursor do LCD
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Flow_rate_sensor.c,83 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Flow_rate_sensor.c,84 :: 		while(1)
L_main1:
;Flow_rate_sensor.c,86 :: 		convert();
	CALL        _convert+0, 0
;Flow_rate_sensor.c,87 :: 		serial();
	CALL        _serial+0, 0
;Flow_rate_sensor.c,88 :: 		lcd();
	CALL        _lcd+0, 0
;Flow_rate_sensor.c,89 :: 		if (rFlow < 18.0)
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       16
	MOVWF       R6 
	MOVLW       131
	MOVWF       R7 
	MOVF        _rFlow+0, 0 
	MOVWF       R0 
	MOVF        _rFlow+1, 0 
	MOVWF       R1 
	MOVF        _rFlow+2, 0 
	MOVWF       R2 
	MOVF        _rFlow+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
;Flow_rate_sensor.c,91 :: 		sD1= '1';
	MOVLW       49
	MOVWF       _sD1+0 
;Flow_rate_sensor.c,92 :: 		sD2= '0';
	MOVLW       48
	MOVWF       _sD2+0 
;Flow_rate_sensor.c,93 :: 		sD3= '0';
	MOVLW       48
	MOVWF       _sD3+0 
;Flow_rate_sensor.c,94 :: 		sD4= '0';
	MOVLW       48
	MOVWF       _sD4+0 
;Flow_rate_sensor.c,95 :: 		D1= 0;
	BCF         PORTC+0, 0 
;Flow_rate_sensor.c,96 :: 		D2= 1;
	BSF         PORTC+0, 1 
;Flow_rate_sensor.c,97 :: 		D3= 1;
	BSF         PORTC+0, 2 
;Flow_rate_sensor.c,98 :: 		D4= 1;
	BSF         PORTC+0, 3 
;Flow_rate_sensor.c,99 :: 		}
	GOTO        L_main4
L_main3:
;Flow_rate_sensor.c,100 :: 		else if (rFlow >= 18.0 && rFlow < 32.0)
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       16
	MOVWF       R6 
	MOVLW       131
	MOVWF       R7 
	MOVF        _rFlow+0, 0 
	MOVWF       R0 
	MOVF        _rFlow+1, 0 
	MOVWF       R1 
	MOVF        _rFlow+2, 0 
	MOVWF       R2 
	MOVF        _rFlow+3, 0 
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
	MOVLW       0
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	MOVF        _rFlow+0, 0 
	MOVWF       R0 
	MOVF        _rFlow+1, 0 
	MOVWF       R1 
	MOVF        _rFlow+2, 0 
	MOVWF       R2 
	MOVF        _rFlow+3, 0 
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
;Flow_rate_sensor.c,102 :: 		sD1= '1';
	MOVLW       49
	MOVWF       _sD1+0 
;Flow_rate_sensor.c,103 :: 		sD2= '1';
	MOVLW       49
	MOVWF       _sD2+0 
;Flow_rate_sensor.c,104 :: 		sD3= '0';
	MOVLW       48
	MOVWF       _sD3+0 
;Flow_rate_sensor.c,105 :: 		sD4= '0';
	MOVLW       48
	MOVWF       _sD4+0 
;Flow_rate_sensor.c,106 :: 		D1= 0;
	BCF         PORTC+0, 0 
;Flow_rate_sensor.c,107 :: 		D2= 0;
	BCF         PORTC+0, 1 
;Flow_rate_sensor.c,108 :: 		D3= 1;
	BSF         PORTC+0, 2 
;Flow_rate_sensor.c,109 :: 		D4= 1;
	BSF         PORTC+0, 3 
;Flow_rate_sensor.c,110 :: 		}
	GOTO        L_main8
L_main7:
;Flow_rate_sensor.c,111 :: 		else if (rFlow >= 32.0 && rFlow < 50.0)
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	MOVF        _rFlow+0, 0 
	MOVWF       R0 
	MOVF        _rFlow+1, 0 
	MOVWF       R1 
	MOVF        _rFlow+2, 0 
	MOVWF       R2 
	MOVF        _rFlow+3, 0 
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
	MOVLW       72
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	MOVF        _rFlow+0, 0 
	MOVWF       R0 
	MOVF        _rFlow+1, 0 
	MOVWF       R1 
	MOVF        _rFlow+2, 0 
	MOVWF       R2 
	MOVF        _rFlow+3, 0 
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
;Flow_rate_sensor.c,113 :: 		sD1= '1';
	MOVLW       49
	MOVWF       _sD1+0 
;Flow_rate_sensor.c,114 :: 		sD2= '1';
	MOVLW       49
	MOVWF       _sD2+0 
;Flow_rate_sensor.c,115 :: 		sD3= '1';
	MOVLW       49
	MOVWF       _sD3+0 
;Flow_rate_sensor.c,116 :: 		sD4= '0';
	MOVLW       48
	MOVWF       _sD4+0 
;Flow_rate_sensor.c,117 :: 		D1= 0;
	BCF         PORTC+0, 0 
;Flow_rate_sensor.c,118 :: 		D2= 0;
	BCF         PORTC+0, 1 
;Flow_rate_sensor.c,119 :: 		D3= 0;
	BCF         PORTC+0, 2 
;Flow_rate_sensor.c,120 :: 		D4= 1;
	BSF         PORTC+0, 3 
;Flow_rate_sensor.c,121 :: 		}
	GOTO        L_main12
L_main11:
;Flow_rate_sensor.c,122 :: 		else if (rFlow >= 50.0)
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	MOVF        _rFlow+0, 0 
	MOVWF       R0 
	MOVF        _rFlow+1, 0 
	MOVWF       R1 
	MOVF        _rFlow+2, 0 
	MOVWF       R2 
	MOVF        _rFlow+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
;Flow_rate_sensor.c,124 :: 		sD1= '1';
	MOVLW       49
	MOVWF       _sD1+0 
;Flow_rate_sensor.c,125 :: 		sD2= '1';
	MOVLW       49
	MOVWF       _sD2+0 
;Flow_rate_sensor.c,126 :: 		sD3= '1';
	MOVLW       49
	MOVWF       _sD3+0 
;Flow_rate_sensor.c,127 :: 		sD4= '1';
	MOVLW       49
	MOVWF       _sD4+0 
;Flow_rate_sensor.c,128 :: 		D1= 0;
	BCF         PORTC+0, 0 
;Flow_rate_sensor.c,129 :: 		D2= 0;
	BCF         PORTC+0, 1 
;Flow_rate_sensor.c,130 :: 		D3= 0;
	BCF         PORTC+0, 2 
;Flow_rate_sensor.c,131 :: 		D4= 0;
	BCF         PORTC+0, 3 
;Flow_rate_sensor.c,132 :: 		}
L_main13:
L_main12:
L_main8:
L_main4:
;Flow_rate_sensor.c,133 :: 		}
	GOTO        L_main1
;Flow_rate_sensor.c,134 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
