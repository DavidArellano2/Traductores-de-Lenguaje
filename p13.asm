PAGE    60,132
    TITLE	P13.EXE
;-----------------------------------------------------------
	.MODEL SMALL
	.STACK 64
;-----------------------------------------------------------
	.DATA
TOPROW	EQU	00		        ;Hilera superior del menu
BOTROW	EQU	07		        ;Hilera inferior del menu
LEFCOL	EQU	20		        ;columna izquierda del menu
COL	    DB	00		        ;Columna de pantalla
ROW	    DB	00		        ;Hilera de pantalla
COUNT	DB	?		        ;Caracteres por linea
LINES	DB	7		        ;Lineas exhibidas
ATTRIB 	DB 	? 		        ;Atributo de pantalla
NINTEEN DB 	23 		        ;Ancho del mensaje
MENU 	DB 	0C9H , 21 DUP(0CDH), 0BBH
	DB 	0BAH , ' Agregar registro    ', 0BAH
	DB 	0BAH , ' Eliminar registro   ', 0BAH
	DB 	0BAH , ' Ingresar orden      ', 0BAH
	DB 	0BAH , ' Imprimir reporte    ', 0BAH
	DB 	0BAH , ' Actualizar cuentas  ', 0BAH
	DB 	0BAH , ' Ver registros       ', 0BAH
	DB 	0C8H , 21 DUP(0CDH) , 0BCH
PROMPT	DB 	05, 'Para seleccionar una opcion, usa las flechas y despues presiona Enter.'
	DB 	13, 10, 09,
	DB 'Presiona Esc para salir.' 
;-----------------------------------------------------------
	.CODE
BEGIN PROC FAR
	MOV	    AX,@DATA	    ;Iniciar registros
	MOV	    DS,AX		    ;de segmento
	MOV	    ES,AX
	CALL	Q10CLR		    ;Despejar pantalla
	MOV 	ROW, BOTROW+2
	MOV	    COL,00
	CALL	Q20CURS		    ;Fijar cursor
	MOV	    AH, 40H		    ;Peticion de exhibicion
	MOV	    BX, 01		    ;Manejo de pantalla
	MOV	    CX,98		    ;Numero de caracteres
	LEA	    DX,PROMPT	    ;Indicacion
	INT	    21H
A10LOOP:
	CALL	B10MENU		    ;Exhibicion de menu
	MOV	    COL,LEFCOL+1
	CALL	Q20CURS		    ;Fijar cursor
	MOV	    ROW,TOPROW+1	;Fijar hilera a opcion superior
	MOV	    ATTRIB,16H	    ;Fijar video inverso
	CALL	H10DISP		    ;Resaltar la linea de menu
	CALL	D10INPT		    ;Proporcionar para la seleccion de menu
	CMP	    AL,0DH		    ;Se presiono enter?
	JE	    A10LOOP		    ;Si, continuar
	MOV	    AX, 0600H	    ;Esc presionado (indica fin)
	CALL	Q10CLR		    ;Despejar pantalla
	MOV	    AX, 4C00H	    ;Salida a DOS
	INT 	21H
BEGIN	ENDP
;-------------------------MOSTRAR MENU------------------------	
B10MENU	PROC NEAR
	MOV 	ROW,TOPROW  	;Fijar hilera superior
	MOV 	LINES,08	    ;Numero de lineas
	LEA 	SI,MENU
	MOV 	ATTRIB,74H 	    ;Azul sobre blanco
B20:
	MOV 	COL,LEFCOL  	;Fijar columna izquierda del mensajeú
	MOV 	COUNT,23
B30:
	CALL 	Q20CURS 	    ;Fijar cursor en la siguiente columna
	MOV 	AH, 09H 	    ;Peticion de exhibicion
	MOV 	AL, [SI] 	    ;Obtener caracter del menú
	MOV 	BH, 00 		    ;Pagina 0
	MOV 	BL, 71H 		;Nuevo atributo
	MOV	    CX, 01 		    ;Un carácter
	INT 	10H
	INC 	COL 		    ;Siguiente columna
	INC 	SI 		        ;Fijar siguiente caracter
	DEC 	COUNT 		    ;Ultimo caracter?
	JNZ 	B30 		    ;No, repetir
	INC 	ROW 		    ;Siguiente hilera
	DEC 	LINES
	JNZ 	B20 		    ;Se imprimieron todas las líneas?
	RET 			        ;Si es asi, regresar
B10MENU ENDP 
;--------------------ACEPTAR ENTRADA A PEDIDO-------------------
D10INPT PROC NEAR
	MOV 	AH,10H 		    ;Petición de entrada
	INT 	16H 		    ;del teclado
	CMP 	AH,50H 		    ;Flecha hacia abajo?
	JE  	D20
	CMP 	AH,48H 		    ;Flecha hacia arriba?
	JE  	D30
	CMP 	AL,0DH 		    ;Tecla Enter?
	JE 	    D40
	CMP 	AL,1BH 		    ;Tecla escape?
	JE 	    D90
	JMP 	D10INPT 		;Ninguna, procesar de nuevo
D20: 	
    MOV 	ATTRIB, 71H 	;Azul sobre blanco
	CALL 	H10DISP 		;Fijar la línea anterior a video normal
	INC 	ROW
	CMP 	ROW,BOTROW-1 	;Se paso la hilera interior?
	JBE 	D40 		    ;no, muy bien
	MOV 	ROW,TOPROW+1 	;si, restablecer
	JMP 	D40
D30: 	
    MOV 	ATTRIB,71H 	    ;Video normal
	CALL 	H10DISP 	    ;Fijar linea anterior a video normal
	DEC 	ROW
	CMP 	ROW,TOPROW+1 	;Abajo de la hilera superior?
	JAE 	D40 		    ;no, muy bien
	MOV 	ROW,BOTROW-1 	;sI, restablecer
D40: 	
    CALL 	Q20CURS 	    ;Fijar cursor
	MOV 	ATTRIB,16H 	    ;Video inverso
	CALL 	H10DISP     	;Fijar nueva linea a video inverso
	JMP 	D10INPT
D90: 
    RET
D10INPT ENDP 
;-------------FIJAR LINEA DE MENU A NORMAL/RESALTADA------------
H10DISP PROC NEAR
	MOV	    AH,00
	MOV 	AL,ROW 		    ;La hilera dice que línea fijar
	MUL 	NINTEEN 	    ;Multiplica por la longitud de la línea
	LEA 	SI,MENU+1   	;por la linea de menú seleccionada
	ADD 	SI,AX
	MOV 	COUNT, 21   	;-Caracteres a exhibir
H20:
	CALL	Q20CURS		    ;-Fijar cursor en segmento columna
	MOV	    AH,09H	    	;Peticion de exhibicion
	MOV	    AL,[SI]		    ;Obtener caracter del menu
	MOV	    BH,00		    ;Pagina 0
	MOV	    BL,ATTRIB   	;Nuevo atributo
	MOV	    CX,01		    ;Un caracter
	INT	    10H
	INC	    COL		        ;Siguente columna
	INC 	SI		        ;Fijar para el siguiente caracter
	DEC	    COUNT		    ;Ultimo caracter?
	JNZ	    H20		        ;No, repetir
	MOV 	COL,LEFCOL+1	;Reestablecer columna a la izquierda
	CALL	Q20CURS		    ;Fijar cursor
	RET
H10DISP	ENDP
;-------------------------DESPEJAR PANTALLA------------------------
Q10CLR PROC	NEAR
	MOV	    AX,0600H
	MOV	    BH,71H		    ;Azul sobre cafe
	MOV	    CX,0000
	MOV	    DX,184FH
	INT	    10H		        ;Llamar a BIOS
	RET
Q10CLR	ENDP
;--------------------FIJAR CURSOR HILERA:COLUMNA-------------------
Q20CURS	PROC NEAR
	MOV	    AH,02H
	MOV	    BH,00		    ;Pagina 0
	MOV	    DH,ROW		    ;Hilera
	MOV	    DL,COL		    ;Columna
	INT	    10H
	RET
Q20CURS	ENDP
	END	BEGIN