sbit lcd_rs at RE0_bit;
sbit lcd_en at RE2_bit;
sbit lcd_d7 at RD7_bit;
sbit lcd_d6 at RD6_bit;
sbit lcd_d5 at RD5_bit;
sbit lcd_d4 at RD4_bit;
//LCD: direcionamento dos pinos
sbit lcd_rs_direction at TRISE0_bit;
sbit lcd_en_direction at TRISE2_bit;
sbit lcd_d7_direction at TRISD7_bit;
sbit lcd_d6_direction at TRISD6_bit;
sbit lcd_d5_direction at TRISD5_bit;
sbit lcd_d4_direction at TRISD4_bit;
 
#define D1 PORTC.RC0
#define D2 PORTC.RC1
#define D3 PORTC.RC2
#define D4 PORTC.RC3


/***********************************************************Variaveis globais*******************************************************************/
unsigned char sText[16];
float rAN0;
float rFlow;
char sD1;
char sD2;
char sD3;
char sD4;

void config_io()
{
     ADCON1=0x0E;
     TRISC.RC0=0;
     TRISC.RC1=0;
     TRISC.RC2=0;
     TRISC.RC3=0;
     TRISE=0x00;
     PORTE.RE1=0;
}

void convert()
{
         rAN0 = ADC_Read(0); // realiza a leitura do canal analógico AN0
         rFlow = rAN0/12.78;  // 0 - 1023 : 0 L/min - 80 L/min
         FloatToStr(rFlow,sText); // converte a variável do tipo inteiro para string
}

void serial()
{
         UART1_Write_Text("vazao:");
         UART1_Write_Text(sText );
         UART1_Write_Text("  ");
         UART1_Write_Text("D1:");
         UART1_Write(sD1);
         UART1_Write_Text("  ");
         UART1_Write_Text("D2:");
         UART1_Write(sD2);
         UART1_Write_Text("  ");
         UART1_Write_Text("D3:");
         UART1_Write(sD3);
         UART1_Write_Text("  ");
         UART1_Write_Text("D4:");
         UART1_Write(sD4);
         UART1_Write_Text("  ");
}

void lcd()
{
         LCD_Out(1,1,"CONTROLE VAZAO");
         LCD_Out(2,1,"VAZAO:");
         LCD_Out(2,7,sText);
         LCD_Out(2,12,"L/min    ");
         delay_ms(600);
}
/****************************Programa Principal*****************************************/
void main()
{
     ADC_Init(); // Inicia o canal analógico
     config_io();
     Lcd_Init(); // Inicia o LCD
     Lcd_Cmd(_LCD_CLEAR); // Limpa o Display de LCD
     Lcd_Cmd(_LCD_CURSOR_OFF); // Desliga o cursor do LCD
     UART1_Init(9600);
     while(1)
     {
         convert();
         serial();
         lcd();
         if (rFlow < 18.0)
         {
                sD1= '1';
                sD2= '0';
                sD3= '0';
                sD4= '0';
                D1= 0;
                D2= 1;
                D3= 1;
                D4= 1;
         }
         else if (rFlow >= 18.0 && rFlow < 32.0)
         {
                sD1= '1';
                sD2= '1';
                sD3= '0';
                sD4= '0';
                D1= 0;
                D2= 0;
                D3= 1;
                D4= 1;
         }
         else if (rFlow >= 32.0 && rFlow < 50.0)
         {
                sD1= '1';
                sD2= '1';
                sD3= '1';
                sD4= '0';
                D1= 0;
                D2= 0;
                D3= 0;
                D4= 1;
         }
         else if (rFlow >= 50.0)
         {
                sD1= '1';
                sD2= '1';
                sD3= '1';
                sD4= '1';
                D1= 0;
                D2= 0;
                D3= 0;
                D4= 0;
         }
     }
}

         