; ej_debug_2.asm
;===============================================================================

GLOBAL main
EXTERN puts, sprintf,printf

section .rodata

fmt db "%d",0
number dd 1234567890
debbuger db "Todo ok",10,0

section .text
main:

     push ebp
     mov ebp,esp
     ; armado de stack frame
    
     push dword[number]
     push fmt
     push buffer     
     
     call sprintf
     add esp, 3*4

     push buffer
     call puts
     add esp,4

     mov esp,ebp
     pop ebp  ; desarmado de stack frame
     
     ret

print:
     push debbuger
     call printf
     add esp,4

section .bss
buffer resb 40
