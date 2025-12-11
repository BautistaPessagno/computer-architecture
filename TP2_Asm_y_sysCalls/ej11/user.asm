section .text
GLOBAL _start
extern print
extern exit

_start:

    push ebp        ;Armado de Stack Frame
    mov ebp, esp

    add ebp, 12     ;Apunto al null previo a los argumentos
    call findUser
            
    mov esp, ebp
    pop ebp         ;Desarmado de Stack Frame

    mov ebx, 0
    call exit       ;Termina el programa

findUser:
    cmp ebp, 0      ;Si encuentro 0 o NULL retorno
    je .endSearch

.searchLoop:
    add ebp, 4          ;Avanzo 4 bytes.
    mov eax, [ebp]      ;Guardo el puntero a la cadena
    mov ebx, busqueda   ;Guardo el puntero a la busqueda
    mov ecx, 5          ;Guardo la longitud de la busqueda (si coinciden esos caracteres iniciales, imprimo)
    call strcmp         ;Comparo ambos strings
    cmp eax,0           ;Si la comparacion es falsa, vuelvo a buscar en el siguiente
    je .searchLoop

    mov ebx, [ebp]          ;Si lo encontre, guardo en ebx el puntero para printear
    add ebx, 5              ;Sumo 5 para saltear el "USER="
    call print              ;Printeo
    mov ebx, endString      ;Imprimo un /n
    call print
.endSearch:
    ret

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

section .data
endString db 10, 0
busqueda db "USER=", 10

section .bss
cadena resb 20
