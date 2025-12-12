global _start

section .text

_start:

    mov eax, 6
    push eax
    call fibonacci

    mov ebx, cadena
    call toString

    mov ecx, ebx	
	mov edx, eax
    mov eax, 4
    mov ebx, 1
    int 80h

    mov eax, 1          ;exit
    mov ebx, 0
    int 0x80

fibonacci:
    push ebp
    mov ebp, esp



    push ebx
    sub esp, 4

    mov eax, [ebp+8]
    cmp eax , 1
    ja .act 
    jmp .end

.act:
    mov ebx, eax
    sub eax, 1
    sub	esp, 8
    push eax
    call fibonacci
    add	esp, 16
	mov	ebx, eax
	mov	eax, DWORD [ebp+8]
	sub	eax, 2
	sub	esp, 8
	push eax
	call fibonacci
    add	esp, 12
	add	eax, ebx
.end:
    mov	ebx, DWORD [ebp-4]
    leave
    ret
	
toString:
	pushad
	mov ecx, 0
	push ebx
.startScan:
    mov ebx, 10
    xor edx, edx
    div ebx
    add edx, "0"
	pop ebx
    push edx
	push ebx
    inc ecx
    cmp eax, 0
    jne .startScan

    mov eax, ecx
    mov ecx, 0 
	pop ebx

.popNumbers:
    pop edx
    mov [ebx + ecx], edx
    dec eax
    inc ecx
    cmp eax, 0
    jne .popNumbers

	mov byte[ebx + ecx], 10
    inc ecx
	popad
    
    ret
    
section .bss
cadena resb 20