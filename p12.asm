PAGE 60,132
TITLE PRACT12.EXE
.MODEL SMALL
;_____________________________________

.CODE
ORG 100H
BEGIN PROC NEAR         ;Iniciamos la funcion
    MOV AH, 0FH         ;Conserva
    INT 10H             ;modo de video
    PUSH AX             ;original
    CALL B10MODE        ;Designa el modo gráfico
    CALL C10DISP        ;Despliegue gráfico en color
    CALL D10KEY         ;Obtiene respuesta del teclado
    POP AX              ;Restaura
    MOV AH,00H          ;el modo original
    INT 10H             ;(en AL)
    MOV AX,4C00H        ;Sale al DOS
    INT 21H             ;interrupcion 21h
BEGIN ENDP              ;fin func

B10MODE PROC NEAR
    MOV AH,00H          ;Establece el modo gráfico EGA/VGA
    MOV AL,10H          ;640 cois x 350 renglones
    INT 10H             ;INTERRUPCION 10H
    MOV AH,0BH          ;Designa la paleta para el fondo
    MOV BH,00           ;Fondo
    MOV BL,07H          ;Gris
    INT 10H             ;INTERRUPCION 10H
    RET                 ;retornamos
B10MODE ENDP

C10DISP PROC NEAR
    MOV BX, 00          ;Designa la página inicial,
    MOV CX, 64          ;color, columna
    MOV DX, 70          ;y renglón

C20:
    MOV AH,0CH          ;Escribe el pixel punto
    MOV AL, BL          ;Designa el color
    INT 10H             ;Se conservan BX, CX y DX
    INC CX              ;Incrementa la columna
    CMP CX,576          ;Es la columna 576
    JNE C20             ;repetir
    MOV CX, 64          ;restaurar la columna
    INC BL              ;Cambiar el color
    INC DX              ;Incrementa el renglón
    CMP DX,280          ;Es el renglón 280?
    JNE C20             ;no, repetir
    RET                 ;retornar
C10DISP ENDP            ;fin func

D10KEY PROC NEAR        ;inicio func
    MOV AH,10H          ;Petición para entrada
    INT 16H             ;desde el teclado
    RET                 ;retornamos
D10KEY ENDP             ;FIN FUNC

END BEGIN               ;FIN PROGRAMA
