 #define D1 PORTC.RC0
 #define D2 PORTC.RC1
 #define D3 PORTC.RC2
 

/***********************************************************Variaveis globais*******************************************************************/
unsigned char sText[16];
float iAN0;
float iTensao;

void config_io()
{
     ADCON1=0x0E;
}    TRISC.RC0=0;
     TRISC.RC1=0;
     TRISC.RC2=0;

/****************************Programa Principal*****************************************/
void main()
{
     ADC_Init(); // Inicia o canal analógico
     config_io();
     UART1_Init(9600);
     while(1)
     {
         iAN0 = ADC_Read(0); // realiza a leitura do canal analógico AN0
         iTensao = iAN0/204.5;
         FloatToStr(iTensao,sText); // converte a variável do tipo inteiro para string
         UART1_Write_Text(sText); // imprime na serial
         UART1_Write_Text("  ");  // imprime espaço
         delay_ms(500);
         
         if (iTensao < 1.80)
         {
            D1=1;
            D2=1;
            D3=1;
         }
         else if (iTensao >= 1.80 && iTensao < 3.25)
         {
            D1=0;
            D2=1;
            D3=1;
         }
         else if (iTensao >= 3.25 && iTensao < 4.40)
         {
            D1=0;
            D2=0;
            D3=1;
         }
         else if (iTensao >= 4.40)
         {
            D1=0;
            D2=0;
            D3=0;
         }
     }
}
