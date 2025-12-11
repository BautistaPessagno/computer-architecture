;getPid

section .text
GLOBAL _start
extern print
extern toString
extern exit

_start:
    ; Armado del Stack
    push ebp
    mov ebp, esp
    
    ;syscall para obtener el pid
    mov eax, 0x14
    int 0x80

    mov ebx, cadena ;puntero a la cadena
    call toString   ;llamo a la funcion toString
    call print      ;llamo a la funcion print

    ;desarmado del stack
    mov esp, ebp
    pop ebp

    call exit         ;llamo a la funcion exit





section .bss
    cadena resb 20 ; buffer para la cadena de caracteres

section .data