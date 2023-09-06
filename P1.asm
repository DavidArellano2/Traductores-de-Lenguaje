PAGE 60,132         ;# DE FILAS Y COLUMNAS
TITLE PROG1.EXE     
.MODEL SMALL

.STACK 64           ;SE ESTABLECE LA PILA

.DATA
DAT1 DB 05H         ;SE DEFINE DAT1 CON SU VALOR
DAT2 DB 10H         ;SE DEFINE DAT2 CON SU VALOR
DAT3 DB ?           ;SE DEFINE DAT3 SIN VALOR

.CODE               ;AQUI COMIEZA EL CODIGO
BEGIN PROC FAR
MOV AX, @DATA       ;SE LE ASIGNA VALOR A @DATA
MOV DS, AX          ;EL VALOR DE AX PASA A DS
MOV AH,DAT1         ;EL VALOR DE DAT1 PASA A AH
ADD AH,DAT2         ;SE SUMA EL VALOR DE DAT2 Y PASA A AH
MOV DAT3,AH         ;EL VALOR DE AH PASA A DAT3
MOV AX, 4C00H
INT 21H             

BEGIN ENDP

END BEGIN           ;SE TERMINA EL CODIGO