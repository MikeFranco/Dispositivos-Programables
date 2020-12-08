#include "p18f4550.inc"

#DEFINE DATO EQU 
ORG 0
GOTO INICIO
RETARDO_100mS
  CLRF TMR0L,0
  MOVLW .95
ASK
  CPFSEQ TMR0L,0
  BRA ASK ;SALTO PEQUEñO
  RETURN

INICIO
  CLRF PORTD,0
  CLRF TRISD,0
  MOVLW B'11010111'
  MOVWF T0CON,0

MAIN
  MOVLW B'11001100' ; ABCS, ABCD RD7654, RD3210
                    ;SOLAMENTE CONECTO RD3210
  MOVWF PORTD,0
CICLO ;OTRA PARTE
  MOVLW .3  ;OTRA PARTE
  MOVWF DATO,1 ;OTRA PARTE
OTRA;OTRA PARTE
  DECFSZ DATO,F,1 ;OTRA PARTE
  GOTO ROTAR;OTRA PARTE
  GOTO CICLO

ROTAR
  CALL RETARDO_100mS ;PARA 1MHZ
  RRNCF PORTD,F,0
  ;GOTO ROTAR ;PARTE ORIGINAL
  GOTO OTRA ;OTRA PARTE
  END