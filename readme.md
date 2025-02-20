nasm -f elf32 -o verificar_memoria.o verificar_memoria.asm

gcc -m32 -o carregador carregador.c verificar_memoria.o