;para pausar el programa

section .text
GLOBAL _start
extern print
extern toString
extern exit

_start:
    ; Armado del Stack
    push ebp
    mov ebp, esp

    mov ebx, texto
    call print        ;llamo a la funcion print

    ;syscall para pausar el programa
    mov eax, 0xA2   ;llamo a la syscall nanosleeo
    mov ebx, timeout    ;tiempo dormido
    mov ecx, timeout2      ;no quiero nanosegundos
    int 0x80        ;llamo a la syscall

    mov ebx, texto2 ;puntero a la cadena
    call print      ;llamo a la funcion print

    ;desarmado del stack
    mov esp, ebp
    pop ebp

    call exit         ;llamo a la funcion exit

section .bss
    cadena resb 20 ; buffer para la cadena de caracteres

section .data
    timeout dd 3, 0 ;tiempo en nanosegundos
    timeout2 dd 0, 0 ;tiempo en nanosegundos
    texto db "Durmiendo el programa",10,0 
    texto2 db "Despertando el programa",10,0