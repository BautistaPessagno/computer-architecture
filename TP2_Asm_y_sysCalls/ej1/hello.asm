section .text

GLOBAL _start

_start:
    mov ecx, msg
    mov edx, len

    call print

    ;exit(0)
    mov ebx, 0
    mov eax, 1
    int 80h

print:
    mov eax, 4
    mov ebx, 1
    int 80h
    ret

section .data
msg db "Hello, world!", 10
len equ $ - msg
