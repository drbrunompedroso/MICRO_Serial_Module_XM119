#line 1 "C:/Users/profb/Documents/Projetos/Programação Aplicada 2/Módulo Serial RS-232/Serial_Basic - por função mikroc/Monitoramento analogico/analog_monit.c"


unsigned char sText[16];
unsigned int iAN0;

void config_ad()
{
 ADCON1=0x0E;
}

void main()
{
 ADC_Init();
 config_ad();
 UART1_Init(9600);
 while(1)
 {
 iAN0= ADC_Read(0);
 IntToStr(iAN0,sText);
 UART1_Write_Text(sText);
 delay_ms(500);

 }
}
