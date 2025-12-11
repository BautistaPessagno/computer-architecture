section .text

GLOBAL _start
extern print

_start:
        mov eax, [num]
        mov ebx, buffer     ;puntero al buffer
        mov ecx, 10        ;divisor
        call loop
        dec ebx            ;ajustar ebx para apuntar al último carácter
        mov edx, ebx       ;guardar el fin del string
        mov eax, buffer    ;inicio del string
        call reverse
loop:
        cmp eax,0
        jne toString    ;si no es cero voy al toString, si es cero termino
        mov byte[ebx],0 ;si es cero agrego el 0 para marcar el cierre de la string
        inc ebx
        ret             ;vuelvo

toString:
        xor edx, edx    ;limpio edx
        div ecx         ;divido por 10
        add dl, '0'
        mov byte[ebx], dl
        inc ebx
        jmp loop

reverse:
        cmp ebx, eax
        jbe end
        mov cl, [ebx]
        mov ch, [eax]
        mov [ebx],ch
        mov [eax],cl
        inc eax
        dec ebx
        jmp reverse

end:
        xor ecx, ecx
        mov ecx, edx
        sub ecx, buffer
        call print

section .bss
        buffer resb 100 

section .data
        num dd 438
