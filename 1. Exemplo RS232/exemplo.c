/***********************************************************Variaveis globais*******************************************************************/
unsigned char cCaracter; // recep��o dos caracteres

/****************************Programa Principal*****************************************/
void main()
{
     UART1_Init(9600); // inicia a comunica��o serial 9600 bits/segundo
     while(1)
     {
         if(UART1_Data_Ready()) // verifica se tem dado valido na porta
         {
             cCaracter= UART1_Read(); // faz a leitura de dados na porta
             UART1_Write(cCaracter); // imprime na serial o caracter recebido
         }
     }
}





