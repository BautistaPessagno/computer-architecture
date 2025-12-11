section .text

GLOBAL _start
extern print
extern toString
extern exit

_start:
        ; Armado del Stack
        push ebp
        mov ebp, esp
        
        mov ebx, comienzo ;puntero a la cadena
        call print        ;llamo a la funcion print

        call recorrerStack ;llamo a la funcion recorrerStack

        ;desarmado del stack
        mov esp, ebp
        pop ebp

        call exit         ;llamo a la funcion exit

recorrerStack:
        ;recorrer el stack
        mov eax, 0          ;inicializo el contador
        mov ebp, esp        ;guardo el puntero a la base del stack
        
    .ciclo:
        mov ebx, cadena     ;puntero a la cadena
        call toString       ;llamo a la funcion toString
        call print         ;llamo a la funcion print

        add eax, 4         ;incremento el contador
        sub ebp, 4         ;decremento el puntero a la base del stack
        
        mov ecx, [ebp]    ;buscamos el segmentation fault
        jmp .ciclo        ;vuelvo al ciclo

section .bss
        cadena resb 20 ; buffer para la cadena de caracteres


section .data
comienzo db "Arrancando el recorrido del Stack",10,0

