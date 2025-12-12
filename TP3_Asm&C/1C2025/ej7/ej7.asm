section .text

GLOBAL _start
extern main

_start:

    mov ecx, msg
    mov edx, len

    ;preparo el print
    mov eax, 0x04
    mov ebx, 1
    int 80h

    ;llamo a la funcion main
    call main

    ;preparo el exit
    mov ebx, eax
    mov eax, 1
    int 80h


section .data
    msg db "starting main from _start", 10,0
    len equ $-msg