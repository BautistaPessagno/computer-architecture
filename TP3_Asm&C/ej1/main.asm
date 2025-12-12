;main.asm
GLOBAL main
EXTERN printf

section .rodata
  fmt db "Cantidad de argumentos: %d\n", 10
  fmt2 db "Argumento %d: %d", 10

section .text

  main:
      push ebp ;Armado de stack frame
      mov ebp, esp ;
      push dword [ebp+8]
      push fmt
      call printf
      add esp, 2*4
      
      ;consigo la cantidad de argumentos
      mov eax, [ebp+8]
      mov esi, 0
      .loop:
          cmp esi, eax
          je .end
          inc esi
          push dword [ebp+8+esi*4]
          push esi
          push fmt2
          call printf
          add esp, 3*4
          jmp .loop
        
      .end:    
      mov eax, 0
      mov esp, ebp ;Desarmado de stack frame
      pop ebp ;
      ret


