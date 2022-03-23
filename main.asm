include macros.asm
.model small
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
            db 13,10,"3. Salir", 10,13, 'Opcion Seleccionada: $'
	prueba db 13,10,"Estoy en iniciar juego $"	
	prueba1 db 13,10,"Estoy en cargar Juego $"
	prueba2 db 13,10,"Estoy en Salir $"
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
			PrintText prueba
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
main endp   
end main