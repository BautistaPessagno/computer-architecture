;main.asm
GLOBAL main
EXTERN printf

section .rodata
  fmt db "Cantidad de argumentos: %d", 10, 0
  fmt2 db "Argumento %d: %s", 10, 0

section .text

  main:
      push ebp ;Armado de stack frame
      mov ebp, esp ;

      ;consigo las variables
      mov edi, dword [ebp+8]
      mov ebx, [ebp+12]

      push edi
      push fmt
      call printf
      add esp, 2*4
      
      xor esi, esi ; esi = 0
      .loop:
          cmp esi, edi
          je .end
          mov ecx, [ebx+esi*4]
          push ecx
          push esi
          push fmt2
          call printf


          inc esi
          add esp, 3*4
          jmp .loop
        
      .end:    
      mov eax, 0
      mov esp, ebp ;Desarmado de stack frame
      pop ebp ;
      ret


