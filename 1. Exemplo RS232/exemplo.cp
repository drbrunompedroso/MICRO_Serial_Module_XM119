#line 1 "C:/Users/Bruno Medina Pedroso/Documents/Projetos/Programa��o Aplicada 2/M�dulo Serial RS-232/Serial_Basic - por fun��o mikroc/1. Exemplo RS232/exemplo.c"

unsigned char cCaracter;


void main()
{
 UART1_Init(9600);
 while(1)
 {
 if(UART1_Data_Ready())
 {
 cCaracter= UART1_Read();
 UART1_Write(cCaracter);
 }
 }
}
