section .text
    global verificar_memoria
    extern imprimir_valores   ; Declaração da função definida em outro arquivo

verificar_memoria:
    push ebp
    mov ebp, esp
    push ebx        ; Salva registradores preservados
    push esi
    push edi

    ; --- configurando o loop
    mov ebx, [ebp + 20]  ; num_blocos (contador do loop)
    cmp ebx, 0

    mov esi, [ebp + 12]  ; enderecos[]
    mov edi, [ebp + 16]  ; tamanhos[]

loop_blocos:
    ; Carregar valores
    mov eax, [esi]       ; enderecos[i]
    mov edx, [edi]       ; tamanhos[i]

    ; Verificar se o programa cabe no bloco (tamanho bloco >= tamanho_programa)
    mov ecx, [ebp + 8]   ; tamanho_programa
    sub edx, [ebp + 8]   ; edx = tamanhos[i] - tamanho_programa

    cmp edx, 0
    jl parcial         ; Se for negativo, vai para bloco parcial

    ; Calcular endereço final: endereco + tamanho_programa - 1
    add ecx, eax       ; ecx = endereco + tamanho_programa
    dec ecx            ; ecx = endereco + tamanho_programa - 1

    push ecx           ; Segundo parâmetro: endereço final
    push eax           ; Primeiro parâmetro: endereço inicial
    call imprimir_valores
    add esp, 8         ; Limpa os parâmetros da pilha

    jmp fim

parcial:
    ; Carregar valores novamente
    mov eax, [esi]     ; enderecos[i]
    mov edx, [edi]     ; tamanhos[i]

    ; Calcular endereço final parcial: tamanho[i] - 1 + endereco
    sub edx, 1
    mov ecx, edx
    add ecx, eax
    
    push edi         ; Para preservar o valor de edi
    push esi         ; Para preservar o valor de esi
    push ebx         ; Salva o contador
    push ecx         ; Segundo parâmetro: endereço final parcial
    push eax         ; Primeiro parâmetro: endereço inicial
    call imprimir_valores
    add esp, 8
    pop ebx          ; Recupera o contador
    pop esi
    pop edi

    ; Verificar se ainda existe parte do tamanho_programa para ser alocada
    mov ecx, [ebp + 8]  ; tamanho_programa
    sub ecx, [edi]      ; ecx = tamanho_programa - tamanhos[i]
    
    ; Atualizar tamanho_programa
    mov [ebp + 8], ecx

    cmp ecx, 0
    jge proximo_bloco   ; Se ainda houver espaço, continua com o próximo bloco

    jmp fim

proximo_bloco:
    ; Avançar para o próximo bloco
    add esi, 4
    add edi, 4

    ; Decrementa o contador e repete se não for zero
    dec ebx
    jnz loop_blocos

fim:
    pop edi
    pop esi
    pop ebx
    mov esp, ebp
    pop ebp
    ret
