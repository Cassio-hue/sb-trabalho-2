nasm -f elf32 -o calcular_espaco.o calcular_espaco.asm

g++ -m32 -o carregador carregador.cpp calcular_espaco.o