section .text
global _start
extern print
extern toString
extern exit
global loop1
global loop2
global printArray
_start:
  mov eax, len
  mov ebx, array
  xor esi, esi

loop1:
    cmp esi, eax
    jge end
    mov edi, esi
    inc edi                 ; j = i + 1
    mov ecx, [ebx+esi*4]    ; current minimum
    jmp loop2

loop2:
    cmp edi, eax
    jge .backToLoop1
    mov edx, [ebx+edi*4]
    cmp edx, ecx
    jb .swap
    inc edi
    jmp loop2
  
.swap:
    mov [ebx+esi*4], edx
    mov [ebx+edi*4], ecx
    mov ecx, edx            ; new minimum value
    inc edi
    jmp loop2

.backToLoop1:
    inc esi
    jmp loop1

end:
    call printArray
    xor ebx, ebx            ; exit code 0
    call exit



printArray:
    mov edi, len            ; array length
    xor esi, esi            ; index i
    .loop:
        cmp esi, edi
        jge .finish
        mov eax, [array + esi*4]
        mov ebx, cadena
        xor ecx, ecx        ; digit counter for toString
        xor edx, edx
        push esi            ; preserve loop index (toString clobbers esi)
        call toString
        mov byte [cadena + ecx], 10
        mov byte [cadena + ecx + 1], 0
        mov ebx, cadena
        pop esi             ; restore loop index
        call print
        inc esi
        jmp .loop
    .finish:
        ret




section .data
array dd 10, 7, 3, 2, 5, 4, 1, 6, 9, 8
len equ ($-array)/4

section .bss
cadena resb 20
