#define M1_1 PORTD.RD0
#define M1_2 PORTD.RD1
#define M1_3 PORTD.RD2
#define M1_4 PORTD.RD3

/***********************************************************Variaveis globais*******************************************************************/
unsigned char cCaracter;

void config_io()
{
     TRISD=0X00;
     PORTD=0X00;
}
/****************************Programa Principal*****************************************/
void main()
{
     config_io();
     UART1_Init(9600);
     while(1)
     {
         if(UART1_Data_Ready()) // verifica se tem dado valido na porta
         {
           cCaracter= UART1_Read(); // faz a leitura de dados na porta
           switch(cCaracter)
           {
              case 'H':
              M1_1 = 1;
              M1_2 = 0;
              M1_3 = 0;
              M1_4 = 1;
              UART1_Write_Text("HORÁRIO");
              UART1_Write(13);
              UART1_Write(10);
              break;

              case 'A':
              M1_1 = 0;
              M1_2 = 1;
              M1_3 = 1;
              M1_4 = 0;
              UART1_Write_Text(" ANTI-HORÁRIO");
              UART1_Write(13);
              UART1_Write(10);
              break;

              case 'P':
              M1_1 = 0;
              M1_2 = 0;
              M1_3 = 0;
              M1_4 = 0;
              UART1_Write_Text(" PARADO");
              UART1_Write(13);
              UART1_Write(10);
              break;
           }
         }

     }
}