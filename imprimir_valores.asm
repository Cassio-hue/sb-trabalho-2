; arquivo: imprimir.asm

section .data  
    msg         db "Programa cabe no endereco ", 0
    ate         db " ate ", 0
    newline     db 10, 0

section .bss
    buffer      resb 100
    num1        resb 12    ; Buffer para o primeiro número
    num2        resb 12    ; Buffer para o segundo número

section .text
    global imprimir_valores

; Função para imprimir os valores
imprimir_valores:
    push ebp
    mov ebp, esp

    ; Converter o primeiro número (endereço inicial)
    mov eax, [ebp + 8]       ; Parâmetro: endereço inicial
    lea edi, [num1]
    call itoa

    ; Converter o segundo número (endereço final)
    mov eax, [ebp + 12]      ; Parâmetro: endereço final
    lea edi, [num2]
    call itoa

    ; Construir a mensagem
    lea edi, [buffer]
    lea esi, [msg]
    call strcpy              ; Copia "Programa cabe no endereco "

    lea esi, [num1]
    call strcat              ; Adiciona o endereço inicial

    lea esi, [ate]
    call strcat              ; Adiciona " ate "

    lea esi, [num2]
    call strcat              ; Adiciona o endereço final

    lea esi, [newline]
    call strcat              ; Adiciona nova linha

    ; Imprimir a mensagem (sys_write)
    mov eax, 4               ; Número da chamada do sistema (sys_write)
    mov ebx, 1               ; File descriptor: stdout
    lea ecx, [buffer]
    mov edx, edi             ; Tamanho da mensagem (edi aponta para o final do buffer)
    sub edx, ecx
    int 0x80

    mov esp, ebp
    pop ebp
    ret

; conversao dos inteiros para ascii
itoa:
    push ebx
    mov ebx, 10
    xor ecx, ecx             ; Contador de dígitos

itoa_loop:
    xor edx, edx
    div ebx                  ; EAX dividido por 10, resto em EDX
    add dl, '0'              ; Converte dígito para ASCII
    push edx                 ; Armazena o dígito
    inc ecx
    test eax, eax
    jnz itoa_loop

    ; Desempilhar dígitos
itoa_pop:
    pop eax
    stosb                    ; Armazena o caractere no buffer
    loop itoa_pop

    mov byte [edi], 0        ; Finaliza a string com terminador nulo
    pop ebx
    ret

; ----------------------------------------------------------
; Função strcpy: copia uma string de [esi] para [edi]
; ----------------------------------------------------------
strcpy:
    lodsb
    stosb
    test al, al
    jnz strcpy
    dec edi                  ; Ajusta o ponteiro para o terminador nulo
    ret

; ----------------------------------------------------------
; Função strcat: concatena a string em [esi] ao final da string em [edi]
; ----------------------------------------------------------
strcat:
    push esi
    push edi
    ; Encontrar o final da string destino
    mov ecx, -1
    xor al, al
    repne scasb
    dec edi                  ; Posiciona em cima do terminador nulo
    pop edi
    pop esi
    call strcpy             ; Copia a string de origem para o destino
    ret
