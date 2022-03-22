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

; segemento de codigo    
.code

    ; procedimiento principal main
	main PROC

        ; carga en memoria las variables del semento de datos
    	MOV ax, @data
    	MOV ds, ax  

        ; impresion por pantalla
		mov dx, offset datos
		mov ah, 9
    	int 21h   
    	.exit   

	main ENDP   

end main