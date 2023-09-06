PAGE 60,132
TITLE PROG8.EXE
.MODEL SMALL
.STACK 64
;_____________________________________

.DATA
ENTRA LABEL BYTE  ;REFERENCIA UN SIMBOLO CON OTRO NOMBRE TIPO BYTE
LONMAX DB 20  ;DECLARA VARIABLE CON VALOR 20
LONREAL DB ?  ;DECLARA VARIABLE CON VALOR INDEFINIDO 
INTROD DB 21 DUP (' ')  ;VARIABLE PARA METER 21 ESPACIOS
MEN DB 'INTRODUCIR NOMBRE: ' , '$'  ;DECLARA LA CADENA A IMPRIMIR
;_____________________________________

.CODE  ;COMIENZA EL C0DIGO
BEGIN PROC FAR  
MOV AX, @DATA     ;LE PASA EL VALOR DE @DATA A AX
MOV DS, AX        ;LE PASA EL VALOR DE AX A DS
OTRO: CALL PANT0  ;LLAMAMOS EL PROCESO PANT0 PARA DEFINIR LA PANTALLA
MOV DX,0502H      ;PASAMOS EL VALOR DE LAS COORDENADAS A DX
CALL CURS0        ;LLAMAMOS A CURS0 PARA DEFINIR EL CURSOR
CALL DESPL0       ;LLAMAMOS A DESPL0 PARA MOSTRAR EL MSJ EN PANTALLA
CALL TECLA0       ;LLAMAMOS A TECLA0 PARA LA ENTRADA DE DATOS
CMP LONREAL,00    ;COMPARA LONREAL CON 00
JE SALIR          ;SI ES 00 SALE Y TERMINA EL PROGRAMA
CALL CAMPA        ;LLAMA A CAMPA, AGREGAMOS BEEP Y UN DELIMITADOR A LO INGRESADO
CALL CENTRAR      ;CENTRA LOS DATOS QUE INGRESA EL USUARIO
JMP OTRO          ;SALTA A LA ETIQUETA DE OTROR
SALIR: MOV AX,4C00H ;SERVICIO QUE FINALIZA EL PROGRAMA
INT 21H           ;INTERRUPCION 21H
BEGIN ENDP
;_____________________________________ 

DESPL0 PROC NEAR  ;CODIGO DE LA FUN DESP0
MOV AH,09H        ;AQUI DESPLEGAMOS LA CADENA
LEA DX, MEN       ;ALMACENA LA DIRECCION
INT 21H           ;INTERRUPCION 21H
RET               ;RETORNA
DESPL0 ENDP       ;FIN DE LA FUNC
;--------------------------------------

TECLA0 PROC NEAR  ;CODIGO DE LA FUNC TECLA0
MOV AH,0AH        ;SERVICIO PARA TENER UNA ENTRADA COM BUFFER
LEA DX, ENTRA     ;ALMACENA LA DIRECCION DE MEMORIA
INT 21H           ;INTERRUPCION 21H
RET               ;RETORNO
TECLA0 ENDP       ;FIN DE LA FUNC
;_____________________________________

CAMPA PROC NEAR     ;CODIGO DE LA FUNC CAMPA
MOV BH,00           ;PONE 00 EN BX
MOV BL, LONREAL     ;PONE A LONREAL EN LA PARTE BAJA 
MOV INTROD[BX],07H  ;PONE A 07 EN LA POS ACTUAL
MOV INTROD[BX+1],'$';AGREGA EL CARACTER $
RET                 ;RETORNA 
CAMPA ENDP          ;FIN DE LA FUNC
;_____________________________________

CENTRAR PROC NEAR   ;FUNC CENTRAR COMIENZO
MOV DL, LONREAL     ;MOVEMOA LONREAL A DL
SHR DL,1            ;HACEMOS DESPLZAMIENTO A LA DERECHA
NEG DL              ;NEGAMOS EL VALOR DL
ADD DL,40           ;SUMAMOS 40 A DL
MOV DH,12           ;MOVEMOS EL VALOR 12 A DH
CALL CURS0          ;LLAMAMOS A LA FUNC CURS0 
MOV AH,09H          ;funcion para desplegar una cadena
LEA DX, INTROD      ;FUNCION PARA DESPLEGAR LA CADENA
INT 21H             ;INTERRUPCION 21H
RET                 ;RETORNO
CENTRAR ENDP        ;FIN DE �A FUNC CENTRAR

;_____________________________________

PANT0 PROC NEAR     ;INICIO DE LA FUNC PANT0
MOV AX,0600H        ;PROCESO PARA DEFINIR VENTANA
MOV BH,30           ;DEFINE COLORES
MOV CX,0000         ;COORDENADAS DE LA MEDIDA
MOV DX,184FH        ;COORDENADAS DEL TAMANIO
INT 10H             ;INTERRUPCION 10H
RET                 ;RETORNA
PANT0 ENDP          ;FIN DE LA FUNC

;_____________________________________
                                
CURS0 PROC NEAR     ;INICIO FUNC CURS0
MOV AH,02H          ;MUEVE EL 02H A AH
MOV BH,00           ;DEFINE LA PAGINA
INT 10H             ;INTERRUPCION 10H
RET                 ;RETORNO
CURS0 ENDP          ;FIN FUNC
;_____________________________________

END BEGIN           ;FIN PROGRAMA