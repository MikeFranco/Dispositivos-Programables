 ;Programa que enciende un LED en el bit RD0 del PORTA autom·ticamente. (Enciende y apaga por si mismo)
 
    LIST P=18F4550
    #INCLUDE<P18F4550.INC>
      
    #DEFINE LED PORTD,0,0
    
    ORG D'0'
    
INICIO
    
    CLRF PORTE,0
    CLRF PORTD,0
    MOVLW 0X01
    MOVWF TRISE,0
    CLRF TRISD,0
    MOVLW B'11000111'
    MOVWF T0CON
    MOVLW D'7'
    MOVWF CMCON
    BSF LED
    
 MAIN
    BTG LED
    CALL DELAY_100MS
    GOTO MAIN
    
 DELAY_100MS
    CLRF TMR0L,0
    MOVLW 20
    
  ASK
    CPFSEQ TMR0L,0
    BRA ASK
    RETURN 
    
 END