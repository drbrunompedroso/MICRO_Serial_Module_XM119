#line 1 "C:/Users/Bruno Medina Pedroso/Documents/Projetos/Programação Aplicada 2/Módulo Serial RS-232/Serial_Basic - por função mikroc/3. Controle de ponte H via RS232/H_BRIDGE_RS232.c"






unsigned char cCaracter;

void config_io()
{
 TRISD=0X00;
 PORTD=0X00;
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
 switch(cCaracter)
 {
 case 'H':
  PORTD.RD0  = 1;
  PORTD.RD1  = 0;
  PORTD.RD2  = 0;
  PORTD.RD3  = 1;
 UART1_Write_Text("HORÁRIO");
 UART1_Write(13);
 UART1_Write(10);
 break;

 case 'A':
  PORTD.RD0  = 0;
  PORTD.RD1  = 1;
  PORTD.RD2  = 1;
  PORTD.RD3  = 0;
 UART1_Write_Text(" ANTI-HORÁRIO");
 UART1_Write(13);
 UART1_Write(10);
 break;

 case 'P':
  PORTD.RD0  = 0;
  PORTD.RD1  = 0;
  PORTD.RD2  = 0;
  PORTD.RD3  = 0;
 UART1_Write_Text(" PARADO");
 UART1_Write(13);
 UART1_Write(10);
 break;
 }
 }

 }
}
