; Led enciende y apaga F=1 MHz cada 500 mhz
; preescaler 256 tmr0 a 16 bits
#include "pic18f4550.inc"
  CBLOCK 0X00
    CONTA
    CONTA2
  ENDC
#DEFINE LED PORTD,1,0
ORG .0
GOTO INICIO

DELAY_1000ms
  MOVLW .2
  MOVWF CONTA2
CONTEO2
  CALL DELAY_500ms
  DECFSZ CONTA2,F,1
  GOTO CONTEO2
  RETURN
DELAY_500ms
  NOVLW .5
  MOVWF CONTA
CONTEO
  CALL DELAY_100ms
  DECFSZ CONTA,F,1
  GOTO CONTEO
  RETURN

DELAY_100ms
  CLRF TMRL0,0
  CLRF TMR0L,0
  MOVLW H'9E'
  MOVWF TMRH0,0
  MOVLW H'58'
  MOVWF TMR0L,0
ASK
  BTFSS INTCON,TMR0IF ;CONTROL DE INTERRUPCIONES
  GOTO ASK
  BCF INTCON,TMR0IF ; ES QUIEN AVISA QUE YA SE DESBORDÓ EL CONTEO
  RETURN

INICIO
  CLRF TRISD,0
  CLRF PORTD,0
  MOVLW B'11000111'
  MOVWF T0CON,0

ON_OFF
  BTG LED ;BIT TOGGLE LED
  ;BSF LED
  ;CALL DELAY_100ms
  ;BCF LED
  CALL DELAY_100ms
  GOTO ON_OFF
  END