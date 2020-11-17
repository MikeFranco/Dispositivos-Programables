; SWITCHES
; Si RC2 y RC1 apagados = PORTB apagado
; Si RC2=0 y RC1=1 = SUMA
; Si RC2=1 y RC1=0 = RESTA
; Si RC2=1 y RC1=1 = MULTIPLICACIÓN
; Las entradas se realizan por PORTA, 2 catidades de 3 bits c/u
; El resultado se visualiza en leds por portb
#include "p18f4550.inc"

#DEFINE DATO H'03' ;PONER ETIQUETAS A CARACTERES, ESTO LEE H'03'
;DATO EQU H'03' ;ESTO LEE SOLO EL 03
#DEFINE QUINCE H'0F'
#DEFINE MASK H'25' ; REGISTRO 37 BANCO 0
#DEFINE DIGITOUNO H'26' ; REGISTRO 38 BANCO 0
#DEFINE DIGITODOS H'27' ; REGISTRO 39 BANCO 0

ORG 0
CONFIGURACION
  MOVLW B'00000110'
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
  BFTSS PORTC,1,0
  GOTO SUMA
  GOTO ALLCLEAR

SUMA
  MOVLW B'00000111' ; W=6 que es la máscara que quiero crear
  MOVWF MASK,1 ;MASK=14, aquí oculto el sumando 2, leeré de izquierda a derecha
               ;Por lo tanto, el sumando 1 es el de la izquierda y el segundo es el de la derecha
  MOVFF PORTA,DIGITOUNO ;PA=W (0||1||2||4)
  MOVF DIGITOUNO,WREG,0
  ANDWF MASK,W,1 ;Enmascarar a wreg, solo dejé a ra3, RA2 y RA1
  RRNCF DIGITOUNO,W,0 ;PUEDE SER 0 O W EN DESTINATION
  MOVFF WREG,DIGITOUNO
  MOVLW B'00111000'
  MOVWF MASK,1 ;aquí oculto el sumando 1
  MOVFF PORTA,DIGITODOS
  MOVF DIGITODOS,WREG,0
  ANDWF MASK,W,1 ;Enmascarar a wreg, solo dejé a ra3, RA2 y RA1
  SWAPF DIGITODOS,W,0 ;PUEDE SER 0 O W EN DESTINATION
  MOVFF DIGITOUNO,WREG
  ADDWF DIGITODOS,WREG,1 ;W+DATO=W
  MOVFF WREG,PORTB ;PORTB TIENE EL RESULTADO 

ALLCLEAR
  CLEARF PORTB,0

VERIFYSECONDIMPUTPOSITIVE
  BFTSS PORTA,1,0
  GOTO RESTA
  GOTO MULTIPLICACION

RESTA
  MOVLW B'00000111' ; W=6 que es la máscara que quiero crear
  MOVWF MASK,1 ;MASK=14, aquí oculto el sumando 2, leeré de izquierda a derecha
               ;Por lo tanto, el sumando 1 es el de la izquierda y el segundo es el de la derecha
  MOVFF PORTA,DIGITOUNO ;PA=W (0||1||2||4)
  MOVF DIGITOUNO,WREG,0
  ANDWF MASK,W,1 ;Enmascarar a wreg, solo dejé a ra3, RA2 y RA1
  RRNCF DIGITOUNO,W,0 ;PUEDE SER 0 O W EN DESTINATION
  MOVFF WREG,DIGITOUNO
  MOVLW B'01110000'
  MOVWF MASK,1 ;aquí oculto el sumando 1
  MOVFF PORTA,DIGITODOS
  MOVF DIGITODOS,WREG,0
  ANDWF MASK,W,1 ;Enmascarar a wreg, solo dejé a ra3, RA2 y RA1
  SWAPF DIGITODOS,W,0 ;PUEDE SER 0 O W EN DESTINATION
  MOVFF DIGITOUNO,WREG
  SUBWF DIGITODOS,WREG,1 ;W+DATO=W
  MOVFF WREG,PORTB ;PORTB TIENE EL RESULTADO

MULTIPLICACION
  MOVLW B'00000111' ; W=6 que es la máscara que quiero crear
  MOVWF MASK,1 ;MASK=14, aquí oculto el sumando 2, leeré de izquierda a derecha
               ;Por lo tanto, el sumando 1 es el de la izquierda y el segundo es el de la derecha
  MOVFF PORTA,DIGITOUNO ;PA=W (0||1||2||4)
  MOVF DIGITOUNO,WREG,0
  ANDWF MASK,W,1 ;Enmascarar a wreg, solo dejé a ra3, RA2 y RA1
  RRNCF DIGITOUNO,W,0 ;PUEDE SER 0 O W EN DESTINATION
  MOVFF WREG,DIGITOUNO
  MOVLW B'01110000'
  MOVWF MASK,1 ;aquí oculto el sumando 1
  MOVFF PORTA,DIGITODOS
  MOVF DIGITODOS,WREG,0
  ANDWF MASK,W,1 ;Enmascarar a wreg, solo dejé a ra3, RA2 y RA1
  SWAPF DIGITODOS,W,0 ;PUEDE SER 0 O W EN DESTINATION
  MOVFF DIGITOUNO,WREG
  MULWF DIGITODOS,WREG,1 ;W+DATO=W
  MOVFF WREG,PORTB ;PORTB TIENE EL RESULTADO
  GOTO MAIN
  END