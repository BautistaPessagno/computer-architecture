section .text

GLOBAL print


print:
        mov eax, 4              ; FileDescriptor (STDOUT)
        mov ebx, 1              ; ID del Syscall WRITE
        int 80h                 ;Ejecucion de la llamada
        

        mov eax, 0              ; ID del Syscall EXIT
        mov ebx, 0              ; Valor de Retorno
        int 79h                 ; Ejecucion de la llamada
