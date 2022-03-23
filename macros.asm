PrintText macro Text ;Macro para imprimir textos
    mov ah,09h
    lea dx,offset Text
    int 21h
endm
RecibirEntrada macro  ;Macro para recibir datos de entrada 
    mov ah,01
    int 21h
endm
Cls macro   ;Macro para limpiar la pantalla
  mov  ah, 0
  mov  al, 3
  int  10H
endm
PrintRow macro len, x, o, y, null,row,ln, enter
  LOCAL DO, VERX, VERO, VERNULL, FIN, COMPARAR
  PrintText y
  PUSH SI ;Registro de inice de origen, almacena desplazamiento del operando de origen en memoria en algunos tipos de operaciones 
  PUSH AX
  XOR SI,SI
  DO:
    mov al,[row+SI]
    cmp al,0001b
    je VERX
    cmp al,100b
    je VERO
    jmp VERNULL
  COMPARAR:
    inc SI
    cmp SI,len
    jb DO
    jmp FIN
  VERX:
    PrintText x    
    jmp COMPARAR
  VERO:
    PrintText o 
    jmp COMPARAR
  VERNULL:
    PrintText null 
    jmp COMPARAR
  FIN:
    POP AX
    POP SI
    PrintText enter
endm