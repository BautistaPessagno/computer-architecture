
section .text


global _start
extern print
extern toString
extern exit

_start:
    mov ecx, [num1]
    mov ebx, [num2]
    mov esi, 0            ; loop counter for multiples
  .multLoop:
    inc esi
    mov eax, esi
    mul ecx
    push eax
    cmp esi, ebx
    jne .multLoop

    mov edi, esi          ; how many values are on the stack
  .printLoop:
    pop eax
    mov ebx, result
    xor ecx, ecx
    call toString

    mov ebx, result
    call print
    mov ebx, newline
    call print
    dec edi
    cmp edi, 0
    jne .printLoop
  .end:
    call exit

    





section .data
num1 dd 100
num2 dd 10
newline db 10, 0

section .bss
result resb 16
