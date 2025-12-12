;main.asm
GLOBAL main
EXTERN printf
section .rodata
    fmt db "Cantidad de argumentos: %d",10,0
    argftm db "Argumento: %s",10,0
section .text
    main:
        push ebp ;Armado de stack frame
        mov ebp, esp ;


        mov eax, [ebp+8] ; voy a la cantidad de argumentos
        dec eax ; le resto 1 porque el primer argumento es el nombre del programa
        push eax
        push fmt
        call printf


        add esp, 2*4 ;Limpiar stack

        mov ecx, [ebp+8]    ; get argc again in ecx for loop control
        mov esi, [ebp + 12] ; Get the base pointer
        mov edi, 1;

    .loop:
        cmp edi, eax  ; comparo si ya se acabo el loop
        jge .endloop ; If zero, exit the loop
       
        push dword [esi+edi*4]  ; Push first argument (argv[1])

        push argftm
        call printf      ; Print it

        add esp, 2*4 ; Clean up stack
        inc edi; Increment the index;
        jmp .loop ; Repeat the loop

    .endloop:
        mov eax, 0
        mov esp, ebp ;Desarmado de stack frame
        pop ebp 
        ret