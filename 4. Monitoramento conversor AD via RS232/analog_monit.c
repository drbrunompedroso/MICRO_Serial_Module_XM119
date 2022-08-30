
/***********************************************************Variaveis globais*******************************************************************/
unsigned char sText[16];
unsigned int iAN0;

void config_ad()
{
     ADCON1=0x0E; // Configura o Pino (AN0) como canal anal�gico e o restante com digital
}
/****************************Programa Principal*****************************************/
void main()
{
     ADC_Init(); // Inicia o canal anal�gico
     config_ad();
     UART1_Init(9600);
     while(1)
     {
         iAN0= ADC_Read(0); // realiza a leitura do canal anal�gico AN0
         IntToStr(iAN0,sText); // converte a vari�vel do tipo inteiro para string
         UART1_Write_Text(sText); // imprimi na serial
         delay_ms(500);

     }
}
