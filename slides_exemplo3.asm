section .data
name_msg db 'Digite seu nome: '
NAMESIZE equ $-name_msg
query_msg db 'Quantas vezes deseja repetir? '
QUERYSIZE equ $-query_msg
confirm_msg1 db 'Repetir mensagem Bem-vindo '
CONF1SIZE equ $-confirm_msg1
confirm_msg2 db ' vezes? (s/n) '
CONF2SIZE equ $-confirm_msg2
welcome_msg db 'Bem-vindo ao Assembly '
WELCOMESIZE equ $-welcome_msg
quebra_linha db 0xA
QUEBRALINHASIZE equ $-quebra_linha

section .bss
username resb 16
response resb 1

section .text
global _start

_start:
    ; 4 - Escrever na tela
    mov eax, 4
    mov ebx, 1
    mov ecx, name_msg
    mov edx, NAMESIZE
    int 80h

    ; 3 - Ler da entrada padrão
    mov eax, 3
    mov ebx, 0
    mov ecx, username
    mov edx, 16
    int 80h

perguntar:
    mov eax, 4
    mov ebx, 1
    mov ecx, query_msg
    mov edx, QUERYSIZE
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, response
    mov edx, 1
    int 80h

    mov ecx, 0          ; Zera o registrador ECX
    mov byte [response], '9'
    mov cl, [response]  ; Move o valor armazenado em response para CL
    sub cl, 0x30        ; Converte o caractere numérico de ASCII para seu valor inteiro

printar:
    push ecx
    mov eax, 4
    mov ebx, 1
    mov ecx, welcome_msg
    mov edx, WELCOMESIZE
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, username
    mov edx, 16
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, quebra_linha   
    mov edx, QUEBRALINHASIZE
    int 80h

    pop ecx
    loop printar

    mov eax, 1
    mov ebx, 0
    int 80h