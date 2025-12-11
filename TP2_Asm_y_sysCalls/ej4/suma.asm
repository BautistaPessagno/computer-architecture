
section .text
extern print
extern toString
extern exit
GLOBAL _start

_start:
    mov eax, [num1]
    mov ebx, 0
    mov ecx, 0
  .loop:
    cmp eax, 0
    je .end
    inc ecx
    add ebx, ecx
    dec eax
    jmp .loop
  .end:
    mov eax, ebx        ; sum to convert
    mov ebx, result     ; buffer for string
    xor ecx, ecx
    call toString

    mov ebx, result
    call print
    xor ebx, ebx
    call exit






section .data
num1 dd 100

section .bss
result resb 16

