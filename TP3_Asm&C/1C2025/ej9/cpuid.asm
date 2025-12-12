section .text

GLOBAL _start

_start:
    mov eax, 0  ;dejo el EAX en 0 para que el cpuid guarde todo en el EBX, ECX, EDX
    cpuid

    ; Guardar el resultado de CPUID en la sección .bss

    mov dword[manufacturer], ebx    ;guardo el creador
    mov dword[manufacturer+4], edx  ;guardo el creador
    mov dword[manufacturer+8], ecx  ;guardo el creador
    mov dword[manufacturer+12], 10 ;guardo el creador
    mov dword[manufacturer+13], 0 ;guardo el creador

    ; Imprimir el resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, manufacturer
    mov edx, 14
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80


section .data
    ; No data section needed for this example
section .bss
    manufacturer resb 14