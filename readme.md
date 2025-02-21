Cássio Vinícius Teixeira Borges 211036141
Felipe Costa de Sousa 211055236

nasm -f elf32 verificar_memoria.asm -o verificar_memoria.o

nasm -f elf32 imprimir_valores.asm -o imprimir_valores.o

gcc -m32 -o carregador carregador.c verificar_memoria.o imprimir_valores.o

./carregador tam_programa endereco_1 tam_bloco_1