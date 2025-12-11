section .text

GLOBAL _start
GLOBAL toString

_start:
    push ebp
    mov ebp, esp

    mov eax, 12345
    mov ebx, reserva
    call toString

    mov ecx, esi
    mov eax, 4
    mov ebx, 1
    int 80h

    mov esp, ebp
    pop ebp

    mov ebx, 0
    mov eax, 1
    int 80h

toString:
    mov esi, ebx
.stringLoop:
    mov ebx, 10
    xor edx, edx
    div ebx
    add edx, "0"
    push edx
    inc ecx
    cmp eax, 0
    jne .stringLoop

    mov eax, ecx
    mov ecx, 0 
.popNumbers:
    pop edx
    mov [esi + ecx], edx
    dec eax
    inc ecx
    cmp eax, 0
    jne .popNumbers
    
    ret




section .bss
reserva resb 10

