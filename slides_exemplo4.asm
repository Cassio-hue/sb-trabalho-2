%define code 0
%define limit 4
%define registered 8
%define room 12

global _start

section .data
msg1 db 'Entre com o código do curso ', 0
size_msg1 equ $-msg1
msg2 db 'Entre com limite de alunos ', 0
size_msg2 equ $-msg2
msg3 db 'Entre com numero de alunos matriculados ', 0
size_msg3 equ $-msg3
msg4 db 'Entre com numerod a sala  ', 0
size_msg4 equ $-msg4

section .bss
struct resb 16
response resb 2

section .text
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, size_msg1
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, response
    mov edx, 2
    int 80h

    mov ebx, 0
    mov bl, [response]
    mov eax, struct
    mov dword [eax+code], ebx

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, size_msg2
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, response
    mov edx, 2
    int 80h

    mov ebx, 0
    mov bl, [response]
    sub bl, 0x30
    mov eax, struct
    mov dword [eax+limit], ebx

    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, size_msg3
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, response
    mov edx, 2
    int 80h

    mov ebx, 0
    mov bl, [response]
    sub bl, 0x30
    mov eax, struct
    mov dword [eax+registered], ebx

    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, size_msg4
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, response
    mov edx, 2
    int 80h

    mov ebx, 0
    mov bl, [response]
    sub bl, 0x30
    mov eax, struct
    mov dword [eax+room], ebx

    mov eax, 1
    mov ebx, 0
    int 80h