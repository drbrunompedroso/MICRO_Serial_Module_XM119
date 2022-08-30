#line 1 "C:/Users/Bruno/Documents/Projetos/Programação Aplicada 2/Módulo Serial RS-232/Serial_Basic - por função mikroc/2. Acionamento de leds via RS232/Serial_basic.c"





unsigned char cCaracter;

void config_io()
{
 TRISD=0X00;
 PORTD=0XFF;

}

void main()
{
 config_io();
 UART1_Init(9600);
 while(1)
 {
 if(UART1_Data_Ready())
 {
 cCaracter= UART1_Read();
 UART1_Write(cCaracter);
 }

 switch(cCaracter)
 {
 case 'A':
  PORTD.RD0  = 1;
  PORTD.RD1  = 1;
  PORTD.RD2  = 1;
 break;

 case 'B':
  PORTD.RD0  = 0;
  PORTD.RD1  = 1;
  PORTD.RD2  = 1;
 break;

 case 'C':
  PORTD.RD0  = 0;
  PORTD.RD1  = 0;
  PORTD.RD2  = 1;
 break;

 case 'D':
  PORTD.RD0  = 0;
  PORTD.RD1  = 0;
  PORTD.RD2  = 0;
 break;
 }
 }
}
