 #define D1 PORTC.RC0
 #define D2 PORTC.RC1
 #define D3 PORTC.RC2


/***********************************************************Variaveis globais*******************************************************************/
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
/****************************Programa Principal*****************************************/
void main()
{
     ADC_Init(); // Inicia o canal analógico
     config_io();
     UART1_Init(9600);
     while(1)
     {
         rAN0 = ADC_Read(0); // realiza a leitura do canal analógico AN0
         rPres = rAN0/40.92;  // 0V - 5V : 0 BAR - 25 BAR
         FloatToStr(rPres,sText); // converte a variável do tipo inteiro para string
         UART1_Write_Text(sText ); // imprime na serial
         UART1_Write_Text("  "); // imprime na serial
         delay_ms(500);

         if (rPres < 5)
         {
            D1=1;
            D2=1;
            D3=1;
         }
         else if (rPres >= 5 && rPres < 12.5)
         {
            D1=0;
            D2=1;
            D3=1;
         }
         else if (rPres >= 12.5 && rPres < 22.5)
         {
            D1=0;
            D2=0;
            D3=1;
         }
         else if (rPres >= 22.5)
         {
            D1=0;
            D2=0;
            D3=0;
         }
     }
}