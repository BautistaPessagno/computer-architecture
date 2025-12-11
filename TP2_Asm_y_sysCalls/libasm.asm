section .text

GLOBAL print
GLOBAL exit
GLOBAL toString
GLOBAL toUpper


;===============================================================================
; print - imprime una cadena en la salida estandar
;===============================================================================
; Argumentos:
;	ebx: cadena a imprimer en pantalla, terminada con 0
;===============================================================================
print:
	pushad		; hago backup de los registros

	call strlen
	mov ecx, ebx	; la cadena esta en ebx
	mov edx, eax	; en eax viene el largo de la cadena

	mov ebx, 1	; FileDescriptor (STDOUT)
	mov eax, 4	; ID del Syscall WRITE
	int 80h
	
	popad 		; restauro los registros
	ret	


;===============================================================================
; exit - termina el programa
;===============================================================================
; Argumentos:
;	ebx: valor de retorno al sistema operativo
;===============================================================================
exit:
	mov eax, 1		; ID del Syscall EXIT
	int 80h		; Ejecucion de la llamada


;===============================================================================
; strlen - calcula la longitud de una cadena terminada con 0
;===============================================================================
; Argumentos:
;	ebx: puntero a la cadena
; Retorno:
;	eax: largo de la cadena
;===============================================================================
strlen:
	push ecx	; preservo ecx	
	push ebx	; preservo ebx
	pushf		; preservo los flags

	mov ecx, 0	; inicializo el contador en 0
.loop:			; etiqueta local a strlen
	mov al, [ebx] 	; traigo al registo AL el valor apuntado por ebx
	cmp al, 0	; lo comparo con 0 o NULL
	jz .fin 	; Si es cero, termino.
	inc ecx	; Incremento el contador
	inc ebx
	jmp .loop
.fin:			; etiqueta local a strlen
	mov eax, ecx	
	
	popf
	pop ebx	; restauro ebx	
	pop ecx	; restauro ecx
	ret

;===============================================================================
; toString - convierte un numero en String.
;===============================================================================
; Argumentos:
;	ebx: 
; Retorno:
;	eax: 
;===============================================================================	

toString:
    mov esi, ebx
.stringLoop:
    mov ebx, 10
    xor edx, edx
    div ebx
    add edx, "0"
    push edx
    inc ecx
    cmp eax, 0
    jne .stringLoop

    mov eax, ecx
    mov ecx, 0 
.popNumbers:
    pop edx
    mov [esi + ecx], edx
    dec eax
    inc ecx
    cmp eax, 0
    jne .popNumbers
    
    ret

;===============================================================================
; strcmp - compara dos strings para ver si son iguales
;===============================================================================
; Argumentos:
;	eax: direccion de la cadena 1.
;	ebx: direccion de la cadena 2.
;	ecx: largo de la cadena 2. --> se podria mejorar para que no se necesite esto
; Retorno:
;	eax: 0 si son distintos, 1 si son iguales
;===============================================================================	
strcmp:                 
    push ebp            ;Armado de StackFrame
    mov ebp, esp

    mov esi, eax        ;Puntero a la primera cadena en esi
    mov edi, ebx        ;Puntero a la segunda cadena en edi

.loop:
    mov al, [esi]       ;Guardo el caracter actual de la primer cadena
    mov bl, [edi]       ;Guardo el caracter actual de la segunda cadena
    cmp al, bl          ;Comparo ambos caracteres
    jne .notEqual       ;Si no son iguales, directamente voy a terminar el programa y devolver 0 en eax
    inc esi             ;Si son iguales, avanzo en esi
    inc edi             ;Avanzo tambien en edi
    dec ecx             ;Decremento la cantidad de caracteres por comparar
    cmp ecx, 0          ;Si no me quedan caracteres por comparar, es porque es igual
    jne .loop           ;Si me quedan, repito el ciclo
    mov eax, 1          ;Si ya no quedan, es porque es igual. Asigno 1 a eax y retorno
    jmp .endFunc

.notEqual:
    mov eax, 0
.endFunc:
    pop ebp             ;Desarmado de StackFrame
    ret

;===============================================================================
; toUpper - convierte caracteres en minuscula a mayuscula
;===============================================================================
; Argumentos:
;	ebx: direccion de la cadena terminada en cero
; Retorno:
;	
;===============================================================================
toUpper:
    mov ecx, 0
.upLoop:
    mov AL, [ebx + ecx]
    cmp AL, 10
    jne .checkMin
    ret
.checkMin:
    cmp AL, "a"
    jae .checkMax
    inc ecx
    jmp .upLoop
.checkMax:
    cmp AL, "z"
    jbe .modify
    inc ecx
    jmp .upLoop
.modify:    
    sub byte[ebx + ecx], 32
    inc ecx
    jmp .upLoop
