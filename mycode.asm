PAGE 60,132
TITLE PROG6.EXE
.MODEL SMALL
;_____________________________________ 

.STACK 64
.DATA
MEN DB 'RICARDO DAVID LOPEZ '  ;TEXTO QUE SE CAMBIARA
;_____________________________________         

.CODE                  ;AQUI COMIENZA EL CODIGO
MAIN PROC NEAR         ;INICIO DEL PROCESO
    MOV AX,@DATA       ;INICIA A DS CON EL VALOR DE DIRECCION
    MOV DS,AX          ;CALCULADO POR LA DIRECCION @DATA
    LEA BX, MEN        ;ASIGNA LOS VALORES A LA CADENA BX
    MOV CX,20          ;TAMANIO DE LA CADENA A CONVERTIR 
    OTRO: MOV AH, [BX] ;ETIQUETA DE LA INSTRUCCION LOOP
    CMP AH,41H         ;COMPARA SI ESTA ARRIBA DE 'A' EN ASCII
    JB OTRO2           ;LO SALTA SI ESTA ABAJO, SI NO ESTA ARRIBA O SI NO ES IGUAL
    CMP AH,5AH         ;COMPARA LOS VALORES DESPUES DE LA Z
    JA OTRO2           ;LO SALTA SI ESTA ARRIBA, SI NO ESTA ABAJO O SI NO ES IGUAL
    OR AH,00100000B    ;REALIZA UNA OPERACION OR AL AX
    MOV [BX], AH       ;ASIGAN VALOR NUEVO A Ah EN BX (CAMBIO DE MAYUSCULAS)
    OTRO2: INC BX      ;INCREMENTO EN BX
    LOOP OTRO          ;CICLO Q MANDA A LLAMAR A 'OTRO' SI CX ES DIFERENTE DE 0

call mayusculas        ;LLAMA MAYUSCULAS

mayusculas proc near   ;COMIENZO DEL PROCESO
    LEA BX, MEN        ;ASIGNA LOS VALORES A BX
    MOV CX,20          ;TAMANIO DE LA CADENA 
    otra: MOV AH,[BX]  ;ETIQUETA CON INSTRUCCION LOOP
    CMP AH, 61h        ;COMPARA SI ESTA ARRIBA DE 'a' EN ASCII
    Jb otra2           ;LO SALTA SI ESTA ABAJO, SI NO ESTA ARRIBA O SI NO ES IGUAL
    CMP Ah,7ah         ;COMPARA LOS VALORES DESPUES DE LA z
    ja otra2           ;LO SALTA SI ESTA ARRIBA, SI NO ESTA ABAJO O SI NO ES IGUAL
    XOR AH,00100000B   ;REALIZA UNA OPERACION OR AL AX
    MOV [BX], AH       ;ASIGAN VALOR NUEVO A Ah EN BX (CAMBIO DE MINUSCULAS)
    otra2: INC BX      ;INCREMENTO EN BX
    LOOP otra          ;CICLO Q MANDA A LLAMAR A 'OTRO' SI CX ES DIFERENTE DE 0
    MOV AX,4C00H
    INT 21H            ;USAR 21h PARA SALIR
mayusculas ENDP        ;FIN DEL PROCESO


END MAIN               ;FIN DEL PROGRAMA