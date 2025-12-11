
section .text
GLOBAL _start
extern print
extern exit
extern toString

_start:
    mov eax,20 
    int 80h
    mov ebx, cadena
    call toString
    mov ebx, cadena
    call print
    call exit



section .bss
cadena resb 20

    
