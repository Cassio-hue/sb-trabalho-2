section .data
msg db 'PORTAL', 0xA

section .text
global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 7
    int 80h

    mov ebx, msg
    mov eax, 6

DoMore:
    add byte [ebx], 32
    inc ebx
    dec eax
    jnz DoMore

    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 7
    int 80h

    ; Encerrar o programa
    mov eax, 1
    mov ebx, 0
    int 80h
