section .text
global _start
extern print
extern toString
extern exit


_start:
    push ebp
    mov ebp, esp
    mov eax, dword[ebp + 4]
    mov ebx, cadena 
    call toString
    mov ebx, cadena
    call print
    call exit

section .data

section .bss
cadena resb 20
