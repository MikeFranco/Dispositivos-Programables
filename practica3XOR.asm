; Un switch controla el encedido o apagado de un led
#include "p18f4550.inc"
ALLON EQU B'11111111'
ORG 0

CONFIGURACION
  MOVLW B'00000011'
  MOVWF TRISA,0 
  CLRF PORTA,0 ;MOVLW B'0000000' MOVWF PORTA,0
  MOVLW QUINCE ;W=15
  MOVWF ADCON1,0 ;ADCON1=15 POR LO QUE LAS ENTRADAS DE LOS PUERTOS A,B,E SON DIGITALES
  MOVLW H'07' ;W=07
  MOVWF CMCON,0 ;EL COMPRADOR DEL PORTA A Y E SE APAGA
  CLRF PORTB,0
  MOVLW B'00000000'
  MOVWF TRISB,0 ;TRISB=0, ENTONCES PB=SSSS SSSS

MAIN
  BTFSS PORTA,0,0
  GOTO VERIFYSECONDIMPUTNEGATIVE ;no, está apagado
  GOTO VERIFYSECONDIMPUTPOSITIVE ;yes, está prendido

VERIFYSECONDIMPUTPOSITIVE
  BTFSS PORTA,1,0
  GOTO SETPORTB ;no, está apagado
  GOTO CLEARPORTB ;yes, está prendido
VERIFYSECONDIMPUTNEGATIVE
  BTFSS PORTA,1,0
  GOTO CLEARPORTB ;no, está apagado
  GOTO SETPORTB ;yes, está prendido

CLEARPORTB
  CLRF PORTB
  GOTO MAIN
SETPORTB
  MOVLW ALLON
  MOVFF WREG,PORTB
  GOTO MAIN

  END