#line 1 "C:/Users/profb/Documents/Projetos/Programação Aplicada 2/Módulo Serial RS-232/Serial_Basic - por função mikroc/6. Controle de pressão via RS232/Pres_sensor.c"






unsigned char sText[16];
float rAN0;
float rPres;

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
 rAN0 = ADC_Read(0);
 rPres = rAN0/40.92;
 FloatToStr(rPres,sText);
 UART1_Write_Text(sText );
 UART1_Write_Text("  ");
 delay_ms(500);

 if (rPres < 5)
 {
  PORTC.RC0 =1;
  PORTC.RC1 =1;
  PORTC.RC2 =1;
 }
 else if (rPres >= 5 && rPres < 12.5)
 {
  PORTC.RC0 =0;
  PORTC.RC1 =1;
  PORTC.RC2 =1;
 }
 else if (rPres >= 12.5 && rPres < 22.5)
 {
  PORTC.RC0 =0;
  PORTC.RC1 =0;
  PORTC.RC2 =1;
 }
 else if (rPres >= 22.5)
 {
  PORTC.RC0 =0;
  PORTC.RC1 =0;
  PORTC.RC2 =0;
 }
 }
}
