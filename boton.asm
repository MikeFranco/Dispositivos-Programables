#include "p18f4550.inc"
CBLOCK 0X00
ENDC

#DEFINE BUTTON PORTE,RE0,0
#DEFINE LED PORTD,RD1,0
ORG .0

GOTO INICIO

DELAY_10ms
  CLRF TMR0L,0
  MOVLW .39
ASK
  CPFSEQ TMR0L,0
  GOTO ASK
  RETURN
  
INICIO
  BFS TRISE,0,0
  CLRF PORTE,0
  MOVLW .15
  MOVWF ADCON1,0 ;PARA QUE LAS ENTRADAS SEAN DIGITALES
  MOVLW .7
  MOVWF CMCON,0
  CLRF PORTD,0
  CLRF TRISD,0
  MOVLW B'11000111'
  MOVWF T0CON,0 ;TMR0 ON, 8 BITS, RELOJ INTERNO, EDGE X, SI PREESALER, 256
  MOVLW H'60'
  MOVWF OSCCON,0 ; EL PROCESADOR DEL PIC TRABAJE A A 4MHZ
   
MAIN
  BTFSS BUTTON
  GOTO MAIN
ASK_B
  CALL DELAY_10ms
  BTFSC BUTTON
  GOTO ASK_B
  GOTO RESPUESTA

RESPUESTA 
  BTG LED
  GOTO MAIN
  END
