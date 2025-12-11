

section .text
extern print
extern toString
extern exit
GLOBAL _start

_start:
    mov eax, len
    mov ebx, 4
    div ebx
    mov ebx, array
    mov esi, 1

    ;chequeo que no sea un array vacio
    cmp eax, 0
    je .end
    ;cargo el primero elemento
    mov ecx, [ebx]
  .loop:
    cmp esi, eax
    je .end
    mov edx, [ebx+esi*4]
    inc esi
    cmp edx, ecx
    jae .loop

  .swap:
    mov ecx, edx
    jmp .loop

  .end:
    mov eax, ecx
    mov ebx, result
    xor ecx, ecx
    call toString

    mov ebx, result
    call print
    call exit

    
section .data
;unordered array
array dd 40, 7, 10,9, 8, 6, 9, 30
len equ $ - array

section .bss
result resb 16
