section .data
    LINHAS EQU 3
    COLUNAS EQU 3

matriz1 db 1, 2, 3
        db 4, 5, 6
        db 7, 8, 9

matriz2 db 1, 1, 1
        db 1, 1, 1
        db 1, 1, 1

section .bss
    resultado resb 9

section .text
global _start

_start:
    mov ecx, LINHAS
    mov ebx, 0
    mov esi, 0
    mov ah, 0
    mov dh, 0

soma_matriz:
    mov al, [matriz1 + ebx + esi]
    mov dl, [matriz2 + ebx + esi]
    add al, dl

    mov [resultado + ebx + esi], al
    inc esi
    cmp esi, COLUNAS

    jb soma_matriz

    add ebx, COLUNAS
    mov esi, 0
    loop soma_matriz

    mov eax, 1
    mov ebx, 0
    int 80h