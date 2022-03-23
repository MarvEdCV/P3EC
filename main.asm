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
			db 13,10,"201905554","$"

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
	row1	db  001b, 000b, 000b, 000b, 000b
	row2	db  000b, 000b, 000b, 000b, 000b
	row3	db  000b, 000b, 000b, 000b, 000b
	row4	db  000b, 000b, 000b, 000b, 000b
	row5	db  000b, 000b, 000b, 000b, 000b

	;VARIABLES PARA INICIAR EL JUEGO
	newgame db 13,10,"***NUEVO JUEGO***"
	turno 	db 0b
	ye db 'E	|','$'
	y4 db '4	|','$'	
	yc db 'C	|','$'
	y2 db '2	|','$'
	ya db 'A	|','$'
	x  db 'X|','$'
	o  db 'O|','$'
	null db	' |','$'
	ln db '  	-------------------------', 10,13, '$'
	saltoLinea db 0ah, 0dh,'$'
	xtitles db 0ah, 0dh, 32,32,32,32,32,'  1  B  3  D  5', 10,13,'$'
	stop db '--------------------------------', '$'
.code
main proc
	mov ax,@data
	mov ds,ax
	PrintText datos
	start:
		PrintText menu
		RecibirEntrada
		mov bl,al
		case1:
			cmp bl,"1"
			jne case2
			je NUEVO
			jmp start
		case2:
			cmp bl,"2"
			jne case3
			PrintText prueba1
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
	NUEVO:
		PrintText newgame
		mov turno, 0b
		jmp INGRESAR
	INGRESAR:
		PrintRow  SIZEOF row1,x,o,ye,null,row1,ln,saltoLinea
		;PrintRow SIZEOF row2,x,o,y4,null,row2,ln,saltoLinea
		;PrintRow SIZEOF row3x,o,yc,null,row3,ln,saltoLinea
		;PrintRow SIZEOF row4,x,o,y2,null,row4,ln,saltoLinea
		;PrintRow SIZEOF row5,x,o,ya,null,row5,ln,saltoLinea
		PrintText ln
		PrintText xtitles
		PrintText stop
		jmp start
main endp   
end main