
section .text

GLOBAL _start
extern print
extern toString
extern exit

_start:
    mov ebx, [num]
    mov eax, 1
    mov ecx, 1
  .loop:
    cmp ecx, ebx
    jae .end
    inc ecx
    mul ecx
    jmp .loop
  .end:
    mov ebx, result
    xor ecx, ecx
    call toString
    
    mov ebx, result
    call print

    call exit
    






section .data
num dd 5

section .bss
result resb 16
