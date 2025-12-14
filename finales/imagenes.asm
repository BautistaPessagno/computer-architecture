
section .text
global _start

_start:
    mov esi, 4000h
    mov edi, C000h

    mov edx, 4fffh

    .loop:
        mov cl, byte [esi]
        mov ch, byte [edi]
        cmp cl, ch
        jne .fail
        inc esi
        inc edi
        cmp esi, edx
        jne .loop
    .success:
        mov eax, 0
        ret
    .fail:
        mov eax, 1
        ret
