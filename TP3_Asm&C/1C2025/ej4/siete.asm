section .text

GLOBAL siete

siete:
    ; guardo el numero 7 en el registro de retortno
    mov eax, DWORD[num]
    ret

section .data
    num dd 7