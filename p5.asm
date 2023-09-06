PAGE 60,132
TITLE PROG5.EXE
.MODEL SMALL         ;MODELO DE 64
;____________________________________

.STACK 64            ;PILA DE 64
.DATA                ;SEGMENTO DE DATOS

;_______________________________________

.CODE                ;COMIENZA EL CODIGO
BEGIN PROC FAR       ;INICIO DEL PROCEDIMIENTO LLAMADO BEGIN
        MOV AX,01H   ;MUEVE 01 EN HEXA A AX
        MOV BX,01H   ;MUEVE 01 EN HEXA A BX
        CALL B10     ;VA AL PROCEDIMIENTO CON NOMBRE B10
        MOV AX,4C00H ;INGRESA EL VALOR 4C00 EN HEXA A AX
        INT 21H      ;LLAMA A LA INTERRUPCION 21 PARA FINALIZAR
    BEGIN ENDP       ;FIN DEL PROCEDIMIENTO
;_____________________________________

    B10 PROC NEAR    ;INICIA EL PROCEDIMIENTO B10
        MOV CX,01H   ;MUEVE 01 EN HEXA A CX
        CALL C10     ;VA AL PROCEDIMIENTO CON NOMBRE C10
        SHL CX,1     ;HACE UN DESPLAZAMIENTO A LA IZQUIERDA
        RET          ;RETORNA AL PROCEDIMIENTO 
    B10 ENDP         ;FINALIZA EL PROCEDIMIENTO B10
;_____________________________________

    C10 PROC NEAR    ;INICIA EL PROCEDIMIENTO C10
        ADD AX,01H   ;SUMA 01 A AX EN HEXA
        ADD BX, AX   ;SUMA EL VALOR DE AX Y BX Y SE QUEDA EN BX
        RET          ;RETORNA AL PROCEDIMIENTO
    C10 ENDP         ;FINALIZA EL RPOCEDIMIENTO C10
;_____________________________________

END BEGIN            ;FINALIZA EL PROGRAMA