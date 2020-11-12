;Este programa es para encender el led conectado en RC0 solamente cuando el switch esté conectado y en RA3 esté cerrado

#include "p18f4550.inc"

ORG .0

INICIO
  CLRF PROTA,0
  MOVLW B'00001000'
  MOVWF TRISA,0
  MOVLW .15
  MOVWF ADCON1,0
  MOVLW .7
  MOVWF CMCON,0
  CLRF PORTC,0
  CLRG TRISC,0

MAIN
  BTFSS PORTA,3,0 ;¿ESTÁS CERRADO RA3? ¿VALES 1?
    GOTO NO ;NO ESTÁ CERRADO, NO VALE 1
    GOTO SI  ;SÍ ESTÁ CERRADO, SÍ VALE 1

NO
  BCF PORTC,0,0 ;BIT 0 DEL PUERTOC=0
  GOTO MAIN

SI 
  BSF PORTC,0,0
  GOTO MAIN
END