;Este programa realiza la resta de la cantidad binaria que ingresa en
;PORTA<R5:R4> (00 01 10 11) + EL VALOR GUARDADO EN EL REG DATOA (7)

#INCLUDE<P18F4550.INC>

DATOA EQU .30
ORG .0

SETTINGS
  CLRF PORTA,0
  SETF TRISA,0
  MOVLW 0X0F
  MOVWF ADCON1,0
  MOVLW 0X07
  MOVWF CMCON,0
  CLRF PORTB,0
  CLRF TRISB,0

RESTA
  MOVLW 0X07
  MOVWF DATOA,1
  MOVF PORTA,W,0
  SWAPF WREG,F,0
  SUBWF DATOA,W,0
  MOVWF PORTB,0
  GOTO RESTA
  END