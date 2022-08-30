#define D1 PORTD.RD0
#define D2 PORTD.RD1
#define D3 PORTD.RD2

/***********************************************************Variaveis globais*******************************************************************/
unsigned char cCaracter; // recepção dos caracteres

void config_io()
{
     TRISD=0X00;
     PORTD=0XFF;

}
/****************************Programa Principal*****************************************/
void main()
{
     config_io();
     UART1_Init(9600); // inicia a comunicação serial 9600 bits/segundo
     while(1)
     {
         if(UART1_Data_Ready()) // verifica se tem dado valido na porta
         {
             cCaracter= UART1_Read(); // faz a leitura de dados na porta
             UART1_Write(cCaracter); // imprime na serial o caracter recebido
         }
         
         switch(cCaracter)
         {
            case 'A':
            D1 = 1;
            D2 = 1;
            D3 = 1;
            break;
            
            case 'B':
            D1 = 0;
            D2 = 1;
            D3 = 1;
            break;
            
            case 'C':
            D1 = 0;
            D2 = 0;
            D3 = 1;
            break;
            
            case 'D':
            D1 = 0;
            D2 = 0;
            D3 = 0;
            break;
         }
     } // fim While(1)
} // fim Main