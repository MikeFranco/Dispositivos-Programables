; Si RC0 y RC1 apagados = PORTB apagado
; RC1=1 Y RC=0 = SUMA
; RC1=0 Y RC0=1 = RESTA
; AMBOS PRENDIDOS = MULTIPLICACION
; Las entradas se realizan por PORTA, 2 catidades de 3 bits c/u
; El resultado se visualiza en leds por portb
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

#DEFINE DATO H'03' ;PONER ETIQUETAS A CARACTERES, ESTO LEE H'03'
;DATO EQU H'03' ;ESTO LEE SOLO EL 03
#DEFINE QUINCE H'0F'
#DEFINE MASK H'25' ; REGISTRO 37 BANCO 0
#DEFINE DIGITOUNO H'26' ; REGISTRO 38 BANCO 0
#DEFINE DIGITODOS H'27' ; REGISTRO 39 BANCO 0

ORG 0
CONFIGURACION
  MOVLW B'01111110'
  MOVWF TRISA,0 
  CLRF PORTA,0 ;MOVLW B'0000000' MOVWF PORTA,0
  MOVLW QUINCE ;W=15
  MOVWF ADCON1,0 ;ADCON1=15 POR LO QUE LAS ENTRADAS DE LOS PUERTOS A,B,E SON DIGITALES
  MOVLW H'07' ;W=07
  MOVWF CMCON,0 ;EL COMPRADOR DEL PORTA A Y E SE APAGA
  CLRF PORTB,0
  MOVLW B'00000000'
  MOVWF TRISB,0 ;TRISB=0, ENTONCES PB=SSSS SSSS
  MOVLW B'00000011'
  MOVWF TRISC,0 ;TRISB=0, ENTONCES PB=SSSS SSEE
  CLRF PORTC,0
MAIN
  BTFSS PORTC,0,0
  GOTO VERIFYSECONDIMPUTNEGATIVE
  GOTO VERIFYSECONDIMPUTPOSITIVE

VERIFYSECONDIMPUTNEGATIVE
  BTFSS PORTC,1,0
  GOTO ALLCLEAR
  GOTO SUMA

VERIFYSECONDIMPUTPOSITIVE
  BTFSS PORTA,1,0
  GOTO RESTA
  GOTO MULTIPLICACION

SUMA
  MOVLW B'00001110' ; W=6 que es la máscara que quiero crear
  MOVWF MASK,1 ;MASK=14, aquí oculto el sumando 2, leeré de izquierda a derecha
               ;Por lo tanto, el sumando 1 es el de la izquierda y el segundo es el de la derecha
  MOVFF PORTA,DIGITOUNO ;PA=W (0||1||2||4)
  MOVF DIGITOUNO,W,1
  ANDWF MASK,W,1 ;Enmascarar a wreg, solo dejé a ra3, RA2 y RA1
  RRNCF DIGITOUNO,W,0 ;PUEDE SER 0 O W EN DESTINATION
  MOVFF WREG,DIGITOUNO
  MOVLW B'01110000'
  MOVWF MASK,1 ;aquí oculto el sumando 1
  MOVFF PORTA,DIGITODOS
  MOVF DIGITODOS,W,1
  ANDWF MASK,W,1 ;Enmascarar a wreg, solo dejé a ra3, RA2 y RA1
  SWAPF WREG,W,0 ;PUEDE SER 0 O W EN DESTINATION
  MOVFF WREG,DIGITODOS
  ADDWF DIGITOUNO,W,1 ;W+DATO=W
  MOVFF WREG,PORTB ;PORTB TIENE EL RESULTADO
  GOTO MAIN

ALLCLEAR
  CLRF PORTB,0


RESTA
  MOVLW B'00001110' ; W=6 que es la máscara que quiero crear
  MOVWF MASK,1 ;MASK=14, aquí oculto el sumando 2, leeré de izquierda a derecha
               ;Por lo tanto, el sumando 1 es el de la izquierda y el segundo es el de la derecha
  MOVFF PORTA,DIGITOUNO ;PA=W (0||1||2||4)
  MOVF DIGITOUNO,W,1
  ANDWF MASK,W,1 ;Enmascarar a wreg, solo dejé a ra3, RA2 y RA1
  RRNCF DIGITOUNO,W,0 ;PUEDE SER 0 O W EN DESTINATION
  MOVFF WREG,DIGITOUNO
  MOVLW B'01110000'
  MOVWF MASK,1 ;aquí oculto el sumando 1
  MOVFF PORTA,DIGITODOS
  MOVF DIGITODOS,W,1
  ANDWF MASK,W,1 ;Enmascarar a wreg, solo dejé a ra3, RA2 y RA1
  SWAPF WREG,W,0 ;PUEDE SER 0 O W EN DESTINATION
  MOVFF WREG,DIGITODOS
  SUBWFB DIGITOUNO,W,1 ;W+DATO=W
  MOVFF WREG,PORTB ;PORTB TIENE EL RESULTADO
  GOTO MAIN

MULTIPLICACION
  MOVLW B'00001110' ; W=6 que es la máscara que quiero crear
  MOVWF MASK,1 ;MASK=14, aquí oculto el DIGITO 2, leeré de izquierda a derecha
               ;Por lo tanto, el DIGITO 1 es el de la izquierda y el segundo es el de la derecha
  MOVFF PORTA,DIGITOUNO ;PA=W (0||1||2||4)
  MOVF DIGITOUNO,W,1
  ANDWF MASK,W,1 ;Enmascarar a wreg, solo dejé a ra3, RA2 y RA1
  RRNCF DIGITOUNO,W,0 ;PUEDE SER 0 O W EN DESTINATION
  MOVFF WREG,DIGITOUNO
  MOVLW B'01110000'
  MOVWF MASK,1 ;aquí oculto el DIGITO 1
  MOVFF PORTA,DIGITODOS
  MOVF DIGITODOS,W,1
  ANDWF MASK,W,1 ;Enmascarar a wreg, solo dejé a ra3, RA2 y RA1
  SWAPF WREG,W,0 ;PUEDE SER 0 O W EN DESTINATION
  MOVFF WREG,DIGITODOS
  MULWF DIGITOUNO,1 ;W+DATO=W
  MOVFF PRODL,PORTB ;PORTB TIENE EL RESULTADO
  GOTO MAIN
  END
