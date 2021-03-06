
    LIST P=18F4550
    #INCLUDE<P18F4550.INC>
		;CONFIG1L dir 300000h 	20
		;CONFIG	PLLDIV=1	 ; 
		;CONFIG	CPUDIV=OSC1_PLL2 ;CUANDO SE USA XTAL	
		;CONFIG	USBDIV=2

		;CONFIG1H dir 300001h	08
		CONFIG	FOSC=INTOSCIO_EC ;OSCILADOR INTERNO, RA6 COMO PIN, USB USA OSC EC
		CONFIG	FCMEN=OFF        ;DESHABILITDO EL MONITOREO DEL RELOJ
		CONFIG	IESO=OFF

		;CONFIG2L DIR 300002H	38
		CONFIG	PWRT=ON          ;PWRT HABILITADO
		CONFIG  BOR=OFF		 ;BROWN OUT RESET DESHABILITADO
		CONFIG BORV=3		 ;RESET AL MINIMO VOLTAJE NO UTILZADO EN ESTE CASO
		CONFIG	VREGEN=ON	 ;REULADOR DE USB ENCENDIDO

		;CONFIG2H DIR 300003H	1E
		CONFIG	WDT=OFF          ;WACH DOG DESHABILITADO
		CONFIG WDTPS=32768      ;TIMER DEL WATCHDOG 
		
		;CONFIG3H DIR 300005H	81
		CONFIG	CCP2MX=ON	 ;CCP2 MULTIPLEXADAS CON RC1	
		CONFIG	PBADEN=OFF       ;PUERTO B PINES DEL 0 AL 4 ENTRADAS DIGITALES
		CONFIG  LPT1OSC=OFF	 ;TIMER1 CONFIURADO PARA OPERAR EN BAJA POTENCIA
		CONFIG	MCLRE=ON         ;MASTER CLEAR HABILITADO
		
		;CONFIG4L DIR 300006H	81
		CONFIG	STVREN=ON	 ;SI EL STACK SE LLENA CAUSE RESET		
		CONFIG	LVP=OFF		 ;PROGRAMACI�N EN BAJO VOLTAJE APAGADO
		CONFIG	ICPRT=OFF	 ;REGISTRO ICPORT DESHABILITADO
		CONFIG	XINST=OFF	 ;SET DE EXTENCION DE INSTRUCCIONES Y DIRECCIONAMIENTO INDEXADO DESHABILITADO

		;CONFIG5L DIR 300008H	0F
		CONFIG	CP0=OFF		 ;LOS BLOQUES DEL C�DIGO DE PROGRAMA
		CONFIG	CP1=OFF          ;NO ESTAN PROTEGIDOS
		CONFIG	CP2=OFF		 
		CONFIG	CP3=OFF
		
		;CONFIG5H DR 300009H	C0
		CONFIG	CPB=OFF		 ;SECTOR BOOT NO ESTA PROTEGIDO
		CONFIG	CPD=OFF		 ;EEPROM N PROTEGIDA

		;CONFIG6L DIR 30000AH	0F
		CONFIG	 WRT0=OFF	 ;BLOQUES NO PROTEGIDOS CONTRA ESCRITURA
		CONFIG	 WRT1=OFF
		CONFIG	 WRT2=OFF
		CONFIG	 WRT3=OFF

		;CONFIG6H DIR 30000BH	E0
		CONFIG	 WRTC=OFF	 ;CONFIGURACION DE REGISTROS NO PROTEGIDO
		CONFIG	 WRTB=OFF	 ;BLOQUE BOOTEBLE NO PROTEGIDO
		CONFIG	 WRTD=OFF	 ;EEPROMDE DATOS NO PROTGIDA

		;CONFIG7L DIR 30000CH	0F
		CONFIG	 EBTR0=OFF	 ;TABLAS DE LETURA NO PROTEGIDAS
		CONFIG	 EBTR1=OFF
		CONFIG	 EBTR2=OFF
		CONFIG	 EBTR3=OFF

		;CONFIG7H DIR 30000DH	40
		CONFIG	 EBTRB=OFF	 ;TABLAS NO PROTEGIDAS
 				   
  
#DEFINE SUMANDO1 B'00000000'
#DEFINE SUMANDO B'00000000' ;ES EL CONTADOR PARA EL CICLO FOR
#DEFINE CERO B'1011011' ; M
#DEFINE UNO  B'1011111' ; a
#DEFINE DOS  B'1000100' ;r
#DEFINE TRES B'0000010' ;i
#DEFINE CUATRO B'1011111' ;a
#DEFINE CINCO B'1000110' ;n
#DEFINE SEIS B'1011111' ;a
#DEFINE SIETE B'0000000' ; espacio
#DEFINE OCHO B'1101011' ; y
#DEFINE NUEVE B'0000000' ; espacio
#DEFINE DIEZ B'1011011' ; M
#DEFINE ONCE B'0000010' ; i
#DEFINE DOCE B'1110111' ; g
#DEFINE TRECE B'0101111' ; u
#DEFINE CATORCE B'1110101' ; e
#DEFINE QUINCE B'0100100' ; l
    
    ORG .0
    
INICIO
    CLRF    PORTD,0
    CLRF    TRISD,0
    MOVLW   B'11000111'
    MOVWF   T0CON
    MOVLW   .0
    MOVWF   SUMANDO
    
COMPARAR
    CALL    DELAY_100ms
    MOVF    SUMANDO,W,1
    MULLW   .2
    MOVF    PRODL,W,0
    CALL    TABLA
    MOVWF   PORTD
    INCF    SUMANDO1,1,1
    GOTO    COMPARAR

DELAY_100ms
    CLRF    TMR0L,0
    MOVLW   .97
    
ASK
    CPFSEQ  TMR0L,0
    GOTO    ASK
    RETURN

TABLA
     ADDWF PCL,F
     DT CERO,UNO,DOS,TRES,CUATRO,CINCO,SEIS,SIETE,OCHO,NUEVE,DIEZ,ONCE,DOCE,TRECE,CATORCE,QUINCE

     END


