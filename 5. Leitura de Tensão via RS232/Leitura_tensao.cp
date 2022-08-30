#line 1 "C:/Users/profb/Documents/Projetos/Programação Aplicada 2/Módulo Serial RS-232/Serial_Basic - por função mikroc/Leitura de Tensão via RS232/Leitura_tensao.c"






unsigned char sText[16];
float iAN0;
float iTensao;

void config_io()
{
 ADCON1=0x0E;
 TRISC.RC0=0;
 TRISC.RC1=0;
 TRISC.RC2=0;
}

void main()
{
 ADC_Init();
 config_io();
 UART1_Init(9600);
 while(1)
 {
 iAN0 = ADC_Read(0);
 iTensao = iAN0/204.5;
 FloatToStr(iTensao,sText);
 UART1_Write_Text(sText);
 delay_ms(1000);

 if (iTensao < 1)
 {
  PORTC.RC0 =1;
  PORTC.RC1 =1;
  PORTC.RC2 =1;
 }
 else if (iTensao >= 1 && iTensao <= 3)
 {
  PORTC.RC0 =0;
  PORTC.RC1 =1;
  PORTC.RC2 =1;
 }
 else if (iTensao >= 3 && iTensao <= 4)
 {
  PORTC.RC0 =0;
  PORTC.RC1 =0;
  PORTC.RC2 =1;
 }
 else if (iTensao > 4)
 {
  PORTC.RC0 =0;
  PORTC.RC1 =0;
  PORTC.RC2 =0;
 }
 }
}
