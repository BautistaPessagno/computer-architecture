section .text

GLOBAL _start
extern print
extern

_start:
    eax, [num]
    ebx, 0
    ecx, 0
    call loop
    mov ecx, ebx
    call numtostr
    call print
    

loop:
    cmp eax, ebx
    jg end_loop
    cmp eax, 0
    jbe lower_than_zero
    add ecx, ebx
    inc ebx
    jmp loop

lower_than_zero:
    inc ebx
    jmp loop

end_loop:
    ret

section .data
    num dd 10
    buffer resb 100