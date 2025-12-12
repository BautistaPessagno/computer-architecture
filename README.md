# Computer Architecture (ITBA)

Material de la materia Arquitectura de Computadoras: apuntes teóricos, prácticos (TP0–TP5), ejercicios en ensamblador/C y carpetas para practicar parciales/finales.

## Estructura
- `TP0/`: Armado del ambiente de trabajo (PDF).
- `TP1/`: Análisis de binarios; incluye consignas, ejemplos y binarios 32/64 bits.
- `TP2_Asm_y_sysCalls/`: Ejercicios de llamadas al sistema en NASM (`libasm.asm`, carpeta `ej*`, extras, fuentes).
- `TP3_Asm&C/`: Ejemplos de interoperabilidad asm/C (NASM + GCC), casos con `printf`, apuntes y fuentes.
- `TP4_Decodificador/`: Consigna/teoría de decodificación (PDF).
- `TP5_Accseso_HW/`: Acceso a hardware y arranque x86_64; contiene PDFs, guía Docker y el proyecto `x64BareBones` para correr un kernel minimal.
- `theory/`: PDFs de las clases teóricas.
- `parciales/`: Carpeta de primeros y segundos parciales en PDF.
- `finales/`: Espacio para material de finales (actualmente vacío).

## Herramientas recomendadas
- `nasm` y `ld`/`gcc -m32` para los ejemplos de 32 bits (se usan interrupciones `int 0x80`).
- `make` y `qemu-system-x86_64` para `TP5_Accseso_HW/x64BareBones`.
- `gdb`, `objdump` y herramientas de análisis de binarios para los TPs iniciales.
- Opcional: Docker (ver `TP5_Accseso_HW/guia uso Docker.pdf`).

## Cómo ejecutar ejemplos rápidos
- Ensamblador simple (`TP2_Asm_y_sysCalls/ej1/hello.asm`):
  ```bash
  cd TP2_Asm_y_sysCalls/ej1
  nasm -f elf32 hello.asm -o hello.o
  ld -m elf_i386 -o hello hello.o
  ./hello
  ```
- Ejemplo asm con `printf` (`TP3_Asm&C/ejercicio1/ej1.asm`):
  ```bash
  cd TP3_Asm&C/ejercicio1
  nasm -f elf32 ej1.asm -o ej1.o
  gcc -m32 -no-pie ej1.o -o ej1
  ./ej1 arg1 arg2
  ```
- Kernel minimal (`TP5_Accseso_HW/x64BareBones`):
  ```bash
  cd TP5_Accseso_HW/x64BareBones
  cd Toolchain && make all && cd ..
  make all
  ./run.sh
  ```

## Notas
- Muchos TPs incluyen PDFs con la consigna y teoría; conviene leerlos antes de compilar o modificar el código.
- Hay archivos `.zip` con material adicional (por ejemplo binarios o proyectos completos) que pueden necesitarse según el ejercicio.
