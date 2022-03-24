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
    cmp SI,SIZEOF len
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

IniciarJuego macro
    PrintText prueba
    PrintText msjPrueba
    numAleatorio1
    mov ah, 02h
    mov dl, numA1
    add dl, '0'
    int 21h
    case11:
        cmp numA1,1
        jne case22
        sorteo2
        jmp next
    case22:
        cmp numA1,0
        sorteo1
        jmp next
    next:
      PrintText msjPrueba2
      numAleatorio2
      mov ah, 02h
      mov dl, numA2
      add dl, '0'
      int 21h
      jmp case111
    case111:
        cmp numA2,0
        jne case222
        turno0
        jmp FIN1
    case222:
        cmp numA2,1
        turno1
        jmp FIN1
    FIN1:
        PrintText FINX
        PrintText welc
        PrintRow row1,x,o,ye,null,row1,ln,saltoLinea
        PrintRow row2,x,o,y4,null,row2,ln,saltoLinea
		    PrintRow row3,x,o,yc,null,row3,ln,saltoLinea
		    PrintRow row4,x,o,y2,null,row4,ln,saltoLinea
		    PrintRow row5,x,o,ya,null,row5,ln,saltoLinea
	     	PrintText xtitles
	    	PrintText stop
        

endm

PressEnter macro
  mov ah, 00
  int 16h
endm

CargarJuego macro
    PrintText prueba2
endm

sorteo1 macro
    mov fig,0b ;0b representara que para el jugador 1 sera la X
    PrintText pieza1x
    PrintText pieza1O
endm

sorteo2 macro
    mov fig,1b ;1b representara que para el jugador 2 sera la X
    PrintText pieza2O
    PrintText pieza2x
endm

turno0 macro
    mov turno,0b ;0b significara que el jugador 1 sera el primero en jugar.
    PrintText turno11
    PrintText turno12
endm

turno1 macro
    mov turno,1b ;1b significara que el jugador 2 sera el primero en jugar.
    PrintText turno21
    PrintText turno22
endm

numAleatorio1 macro
    mov ah, 0h ;interrupciones para obtener la hora del sistema.
    int 1ah    ;ahora no se guardará ningún reloj en dx

    mov ax, dx ;mover no de relojes marcan en ax
    mov dx, 0  ;borrar el dx a cero
    mov bx,2  ;bx=2 nuestro divisor para generar no entre 0 y 1 como resto.
    div bx     ;divida ax por bx, sea ax=152, bx=2, luego dx=0
    mov numA1, dl  ;obtenga el divisor de dl y guárdelo en la variable randomNum.
endm

numAleatorio2 macro

    mov ah, 0h ;interrupciones para obtener la hora del sistema.
    int 1ah    ;ahora no se guardará ningún reloj en dx

    mov ax, dx ;mover no de relojes marcan en ax
    mov dx, 0  ;borrar el dx a cero
    mov bx,2  ;bx=2 nuestro divisor para generar no entre 0 y 1 como resto.
    div bx     ;divida ax por bx, sea ax=152, bx=2, luego dx=0
    mov numA2, dl  ;obtenga el divisor de dl y guárdelo en la variable randomNum.
endm

;MACROS PARA COMANDOS

GetText macro buffer
  LOCAL CONTINUE, FIN
  PUSH SI
  PUSH AX
  xor si, si
  CONTINUE:
    getChar
    cmp al, 0dh
    je FIN
    mov buffer[si], al
    inc si
    jmp CONTINUE
  FIN:
    mov al, '$'
    mov buffer[si], al
  POP AX
  POP SI
endm

getChar macro
		mov ah, 01h
		int 21h
	endm

getRuta macro buffer
    LOCAL CONTINUE, FIN
    PUSH SI
    PUSH AX

    xor si,si
    CONTINUE:
    getChar
    cmp al,0dh
    je FIN
    mov buffer[si],al
    inc si
    jmp CONTINUE

    FIN:
    mov al,'$'
    mov buffer[si],al
    POP AX
    POP SI
endm
generarCarga macro rutaArchivo, handle
    crearArchivo rutaArchivo, handle
    abrirArchivo rutaArchivo, handle
    generarCargaFila row1,handle
    generarCargaFila row2,handle
    generarCargaFila row3,handle
    generarCargaFila row4,handle
    generarCargaFila row5,handle
    cerrarArchivo handle
endm

;Macros que sirven para crear, abrir y cerrar un archivo
crearArchivo macro buffer,handle
    mov ah,3ch
    mov cx,00h
    lea dx,buffer
    int 21h
    mov handle,ax
     jc ErrorCrear
endm
abrirArchivo macro ruta,handle
  
    mov ah,3dh
    mov al,10b
    lea dx,ruta
    int 21h
    mov handle,ax
    jc ErrorAbrir
endm
cerrarArchivo macro handle
    mov ah,3eh
    mov handle,bx
    int 21h
endm

;Metodo  para generar la carga de cada una de las filas de la matriz.
generarCargaFila macro arreglo, handle
LOCAL CICLO, printX,printO,Afuera
    mov cx,5
    xor si,si
    CICLO: 
        cmp arreglo[si],001b 
        je printX
        cmp arreglo[si],100b
        je printO
        escribirArchivo  carganull, carganull, handle
        jmp Afuera
        printX:
            escribirArchivo  cargax, cargax, handle
            jmp Afuera
        printO:
            escribirArchivo  cargao, cargao, handle   
            jmp Afuera   
        Afuera:
        
        inc si
        dec cx
    JNE CICLO
endm

;Macros utilizadas para escribir sobre el archivo lo que tengan las columnas del tablero 
escribirArchivo macro numbytes,buffer,handle
    push cx
    escribir  numbytes,buffer,handle
    pop cx
endm
escribir macro numbytes,buffer,handle
	mov ah, 40h
	mov bx,handle
	mov cx, SIZEOF numbytes
	lea dx,buffer
	int 21h
	jc ErrorEscribir
endm