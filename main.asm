include macros.asm
.model large
.stack 


.data 
	datos   db 13,10,"Universidad de San Carlos de Guatemala"
			db 13,10,"Facultad de Ingenieria"
			db 13,10,"Escuela de Ciencias y Sistemas"
			db 13,10,"Arquitectura de Compiladores y ensambladores 1"
			db 13,10,"Seccion A"
			db 13,10,"Marvin Eduardo Catalan Veliz"
			db 13,10,"201905554",13,10,"Presione enter para continuar",10,13,"$"

	menu    db 13,10,"*****MENU PRINCIPAL*****"
            db 13,10,"Opciones:"
            db 13,10,"1. Iniciar Juego"
            db 13,10,"2. Cargar Juego"
            db 13,10,"3. Salir", 10,13, '>   $'
	prueba  db 13,10,"Estoy en iniciar juego $"	
	prueba1 db 13,10,"Estoy en cargar Juego $"
	prueba2 db 13,10,"Estoy en Salir $"
	
	;MATRIZ 5 X 5
	;000 -> vacio	001 -> X	100 -> O  
	row1	db  000b, 000b, 000b, 000b, 000b
	row2	db  000b, 000b, 000b, 000b, 000b
	row3	db  000b, 000b, 000b, 000b, 000b
	row4	db  000b, 000b, 000b, 000b, 000b
	row5	db  000b, 000b, 000b, 000b, 000b

	;VARIABLES PARA INICIAR EL JUEGO
	turno db 0b
	fig   db 0b
	newgame db 13,10,"***NUEVO JUEGO***"
	ye db 'E	|','$'
	y4 db '4	|','$'	
	yc db 'C	|','$'
	y2 db '2	|','$'
	ya db 'A	|','$'
	x  db 'X|','$'
	o  db 'O|','$'
	null db	' |','$'
	ln db '  	-----------', 10,13, '$'
	saltoLinea db 0ah, 0dh,'$'
	xtitles db 0ah, 0dh, 32,32,32,32,32,' 	 1 B 3 D 5', 10,13,'$'
	stop db '------------------------', '$'
	turnoPlayer1 db 0ah, 0dh, ' > Turno Jugador 1: Figura [ ', '$'
	turnoPlayer2 db 0ah, 0dh, ' > Turno Jugador 2: Figura [ ', '$'
	figx db 'X ]$'
	figo db 'O ]$'
	;TEMPORALE
	msjPrueba db 10,13,"Numero Aleatorio 1: $"
    msjPrueba2 db 10,13,"Numero Aleatorio 2 : $"
    numA1    db 0 ,10,13
    numA2    db 0 ,10,13
    pieza1x  db 13, 10,"Jugador 1 Su pieza es: X",10,13, "$"
    pieza1O  db 13, 10,"Jugador 2 Su pieza es: O",10,13, "$"
    pieza2x  db 13, 10,"Jugador 2 Su pieza es: X",10,13, "$"
    pieza2O  db 13, 10,"Jugador 1 Su pieza es: O",10,13, "$"

    turno11  db 13, 10,"Turno 1: Jugador 1",10,13, "$"
    turno12  db 13, 10,"Turno 2: Jugador 2",10,13, "$"
    turno21  db 13, 10,"Turno 1: Jugador 2",10,13, "$"
    turno22  db 13, 10,"Turno 2: Jugador 1",10,13, "$"
	FINX	 db 13, 10,"FIN DE SORTEO",10,13, "$"
	welc 	 db 13, 10,"-----TABLERO QUIXO-----",10,13, "$"

	;VARIABLES DE COMANDOS 
	SaveWord db 'S','A','V','E','$'
	guardando db 0ah, 0dh, '-------- GUARDANDO PARTIDA --------', 10,13,'$'
	GetNameFichero db 0ah, 0dh, '>Ingrese nombre para guardar: ', '$'
	;VARIABLES DE ARCHIVOS
	bufferLectura db 200 dup('$')
	rutaArchivo db 200 dup(0),0
	CreateErrror db 0ah,0dh,'Error al crear archivo','$'
	OpenError db 0ah,0dh,'Error al abrir archivo','$'
	WriteError db 0ah,0dh,'Error al escribir en archivo','$'
	 
	handleFichero dw ?
	 savemsg db 'Archivo guardado correctamente',0ah,0dh,'$'
	cargax db '1'
	cargao db '2'
	carganull db '3'
	leerCarga db 200 dup(0),0
	handleCarga dw ?
	bufferLecturaCarga db 10 dup('$')
	 msmError2 db 0ah,0dh,'Error al leer archivo','$'
	 msmError3 db 0ah,0dh,'Error al crear archivo','$'
	 msmError4 db 0ah,0dh,'Error al Escribir archivo','$'
.code
main proc
	mov ax,@data
	mov ds,ax
	PrintText datos
	PressEnter
	start:
		PrintText menu
		RecibirEntrada
		mov bl,al
		case1:
			cmp bl,"1"
			jne case2
			;PrintText prueba
			IniciarJuego
			cmp turno, 0b
			je PrintP1
			cmp turno, 1b 
			je PrintP2
			jmp start
		case2:
			cmp bl,"2"
			jne case3
			PrintText GetNameFichero
			GetText leerCarga
			cargaTablero leerCarga, handleCarga, bufferLecturaCarga
			ErrorLeer:
				PrintText msmError2
				getChar
				jmp start
		case3:
			cmp bl,"3"
			jne case4
			PrintText prueba2
			mov ah,4ch
			int 21h
			jmp start
		case4:
			Cls
			jmp start
		PrintP1:
			PrintText turnoPlayer1
			cmp fig,0b 
			je P1x 
			cmp fig,1b 
			je P1o 
		P1x:
			PrintText figx
			cmp turno, 0b
			je Player1
			cmp turno, 1b 
			je Player2
		P1o:
			PrintText figo
			cmp turno, 0b
			je Player1
			cmp turno, 1b 
			je Player2
		PrintP2:
			PrintText turnoPlayer2 
			cmp fig,1b 
			je P1x  
			cmp fig, 0b   
			je P1o 
		Player1:
			GetText bufferLectura
            cmp bufferLectura[0],83
            jne start
            cmp bufferLectura[1],65
            jne start
            cmp bufferLectura[2],86
            jne start
            cmp bufferLectura[3],69
            je SAVE
			jmp start
		Player2:
			GetText bufferLectura
			cmp bufferLectura[0],83
            jne start
            cmp bufferLectura[1],65
            jne start
            cmp bufferLectura[2],86
            jne start
            cmp bufferLectura[3],69
            je SAVE
			jmp start
		SAVE:
			PrintText guardando
			PrintText GetNameFichero
			getRuta rutaArchivo
			generarCarga rutaArchivo, handleFichero
			PrintText savemsg

		ErrorCrear:
			PrintText CreateErrror
			jmp start ;temporal
		ErrorAbrir:
			PrintText OpenError
			jmp start ;temporal
		ErrorEscribir:
			PrintText WriteError
			jmp start

main endp   
end main