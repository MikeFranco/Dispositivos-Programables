


; DECODIFICADOR DE NÚMERO DE 2 BITS A DIS´LAY DE 7 SEGMENTOS DE CÁTODO COMÚN

#include "p18f4550.inc"

  ; CONFIG1L
  CONFIG  PLLDIV = 1            ; PLL Prescaler Selection bits (No prescale (4 MHz oscillator input drives PLL directly))
  CONFIG  CPUDIV = OSC1_PLL2    ; System Clock Postscaler Selection bits ([Primary Oscillator Src: /1][96 MHz PLL Src: /2])
  CONFIG  USBDIV = 1            ; USB Clock Selection bit (used in Full-Speed USB mode only; UCFG:FSEN = 1) (USB clock source comes directly from the primary oscillator block with no postscale)

; CONFIG1H
  CONFIG  FOSC = INTOSCIO_EC    ; Oscillator Selection bits (Internal oscillator, port function on RA6, EC used by USB (INTIO))
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)

; CONFIG2L
  CONFIG  PWRT = ON             ; Power-up Timer Enable bit (PWRT enabled)
  CONFIG  BOR = OFF             ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
  CONFIG  BORV = 3              ; Brown-out Reset Voltage bits (Minimum setting 2.05V)
  CONFIG  VREGEN = OFF          ; USB Voltage Regulator Enable bit (USB voltage regulator disabled)

; CONFIG2H
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
  CONFIG  WDTPS = 32768         ; Watchdog Timer Postscale Select bits (1:32768)

; CONFIG3H
  CONFIG  CCP2MX = ON           ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
  CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
  CONFIG  LPT1OSC = OFF         ; Low-Power Timer 1 Oscillator Enable bit (Timer1 configured for higher power operation)
  CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)

; CONFIG4L
  CONFIG  STVREN = ON           ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will cause Reset)
  CONFIG  LVP = OFF              ; Single-Supply ICSP Enable bit (Single-Supply ICSP enabled)
  CONFIG  ICPRT = OFF           ; Dedicated In-Circuit Debug/Programming Port (ICPORT) Enable bit (ICPORT disabled)
  CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled (Legacy mode))

; CONFIG5L
  CONFIG  CP0 = OFF             ; Code Protection bit (Block 0 (000800-001FFFh) is not code-protected)
  CONFIG  CP1 = OFF             ; Code Protection bit (Block 1 (002000-003FFFh) is not code-protected)
  CONFIG  CP2 = OFF             ; Code Protection bit (Block 2 (004000-005FFFh) is not code-protected)
  CONFIG  CP3 = OFF             ; Code Protection bit (Block 3 (006000-007FFFh) is not code-protected)

; CONFIG5H
  CONFIG  CPB = OFF             ; Boot Block Code Protection bit (Boot block (000000-0007FFh) is not code-protected)
  CONFIG  CPD = OFF             ; Data EEPROM Code Protection bit (Data EEPROM is not code-protected)

; CONFIG6L
  CONFIG  WRT0 = OFF            ; Write Protection bit (Block 0 (000800-001FFFh) is not write-protected)
  CONFIG  WRT1 = OFF            ; Write Protection bit (Block 1 (002000-003FFFh) is not write-protected)
  CONFIG  WRT2 = OFF            ; Write Protection bit (Block 2 (004000-005FFFh) is not write-protected)
  CONFIG  WRT3 = OFF            ; Write Protection bit (Block 3 (006000-007FFFh) is not write-protected)

; CONFIG6H
  CONFIG  WRTC = OFF            ; Configuration Register Write Protection bit (Configuration registers (300000-3000FFh) are not write-protected)
  CONFIG  WRTB = OFF            ; Boot Block Write Protection bit (Boot block (000000-0007FFh) is not write-protected)
  CONFIG  WRTD = OFF            ; Data EEPROM Write Protection bit (Data EEPROM is not write-protected)

; CONFIG7L
  CONFIG  EBTR0 = OFF           ; Table Read Protection bit (Block 0 (000800-001FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR1 = OFF           ; Table Read Protection bit (Block 1 (002000-003FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR2 = OFF           ; Table Read Protection bit (Block 2 (004000-005FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR3 = OFF           ; Table Read Protection bit (Block 3 (006000-007FFFh) is not protected from table reads executed in other blocks)

; CONFIG7H
  CONFIG  EBTRB = OFF           ; Boot Block Table Read Protection bit (Boot block (000000-0007FFh) is not protected from table reads executed in other blocks)

;PORTD -GFABECD
#DEFINE CERO B'00111111'
#DEFINE UNO  B'00001010'
#DEFINE DOS  B'01011101'
#DEFINE TRES B'01011011'
#DEFINE CUATRO B'1101010'
#DEFINE CINCO B'1110011'
#DEFINE SEIS B'1110111'
#DEFINE SIETE B'0011010'
#DEFINE OCHO B'11111111'
#DEFINE NUEVE B'1111010'
#DEFINE COPIA B'00000000'

ORG 0
GOTO INICIO
  
TABLA ; TODO ESTO ES POSIBLE POR EL PC
  ADDWF PCL,F,0 ; PC 40
  DT CERO,UNO,DOS,TRES,CUATRO,CINCO,SEIS,SIETE,OCHO,NUEVE
  ;RETLW CERO ; PC 42
  ;RETLW UNO ; PC 44
  ;RETLW DOS ; PC 46
  ;RETLW TRES ; PC 48
  ;RETLW CUATRO ;PC 50
  ;RETLW CINCO ; PC 52
  ;RETLW SEIS ; PC 54
  ;RETLW SIETE ; PC 56
  ;RETLW OCHO ; PC 58
  ;RETLW NUEVE ; PC 60

INICIO
  MOVLW B'00001111' ;PC 2
  MOVWF TRISA,0 ; PC 4
  CLRF PORTA,0 ; PC 6
  MOVLW .7 ; PC 8
  MOVWF CMCON,0 ; PC 10
  MOVLW .15 ; PC 12
  MOVWF ADCON1,0 ; PC 14
  CLRF TRISD,0 ; PC 16
  CLRF PORTD,0 ; PC18

MAIN
  MOVFF PORTA,COPIA ; PC 20
  MOVLW B'00001111' ; PC=22 MÁSCARA
  ANDWF COPIA,W,1 ; PC=24 W TIENE LA ENTRADA ENMASCARADA Y ES EL DATO QUE SE BUSCARÁ EN LA TABLA
                  ; PARA ESTE PROGRAMA ES EL DATO A DECODIFICAR
  MULLW .2 ; PC= 26
  MOVF PRODL,W,0 ; PC = 28 AQUÍ W YA ES PAR
  CALL TABLA ; PC = 30 TV ES UNA SUBRUTINA, AQUÍ SE LLAMA
  MOVWF PORTD,0 ; PC = 34 W TRAE LA DECODIFICACION
  GOTO MAIN ; PC = 36
  END