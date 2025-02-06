nasm -f elf32 -o soma.o soma.asm

g++ -m32 -o carregador carregador.cpp soma.o