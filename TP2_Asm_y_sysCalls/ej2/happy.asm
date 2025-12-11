section .text

GLOBAL _start
global loop
global checkMin
global checkMax
global toMayus
global end

_start:
    mov ecx, 0
    call loop

    mov ecx, msg
    mov ebx, len

loop:
    mov al, [msg + ecx]
    cmp al, 10
    jne checkMin
    jmp end

checkMin:
    cmp al, 'a'
    jae checkMax
    inc ecx
    jmp loop

checkMax:
    cmp al, 'z'
    jb toMayus
    inc ecx
    jmp loop


end:
    ;call print
    mov ecx, msg
    mov edx, len
    mov eax, 4
    mov ebx, 1
    int 80h

    mov ebx, 0
    mov eax, 1
    int 80h

toMayus:
    sub byte[msg + ecx], 32 
    inc ecx
    jmp loop


section .data
msg db "h4ppy c0d1ng", 10
len equ $ - msg
