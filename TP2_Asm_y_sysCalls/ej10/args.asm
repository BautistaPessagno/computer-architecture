section .text

global _start
extern print
extern toString
extern exit

_start:
    push ebp
    mov ebp, esp
    ;args
   mov ecx, dword[ebp + 4]
   mov esi, 1
   .loop:
    cmp esi, ecx
    je .end
    mov ebx, [ebp + 8 + esi * 4]
    call print
    mov ebx, space
    call print
    inc esi
    jmp .loop

    .end:
    call exit




section .data
space db ' ', 0
