section .data
    msg_tamanho db "Tamanho do Programa: %d", 10, 0
    msg_endereco db "Endereco: %d Tamanho: %d", 10, 0
    msg_contador db "Contador: %d", 10, 0
    msg_cabe db "Programa cabe no endereco %d ate %d", 10, 0
    msg_resultado_subtracao db "Resultado da subtracao: %d", 10, 0
    msg_fiz_fim db "Fiz fim", 10, 0

section .text
    global verificar_memoria
    extern printf

verificar_memoria:
    push ebp
    mov ebp, esp
    push ebx        ; Salva registradores preservados
    push esi
    push edi

    ; --- Imprimir "Tamanho do Programa: %d" ---
    push dword [ebp + 8]  ; tamanho_programa
    push msg_tamanho
    call printf
    add esp, 8

    ; --- Configurar loop ---
    mov ebx, [ebp + 20]  ; num_blocos (contador do loop)
    cmp ebx, 0

    ; Não coube em nenhum bloco
    ; Verificar se cabe dividindo o programa em blocos
    ; TODO: je verificar_divisao_blocos
    je fim

    mov esi, [ebp + 12]  ; enderecos[]
    mov edi, [ebp + 16]  ; tamanhos[]

loop_blocos:
    ; ==== Imprimir contador ====
    ;push ebx
    ;push msg_contador
    ;call printf
    ;add esp, 8

    ; Carregar valores
    mov eax, [esi]  ; enderecos[i]
    mov edx, [edi]  ; tamanhos[i]

    ; ==== Imprimir endereço e tamanho do bloco ====
    ;push edx
    ;push eax
    ;push msg_endereco
    ;call printf
    ;add esp, 12

    ; Verificar se o programa cabe no bloco (tamanho bloco >= tamanho_programa)
    mov ecx, [ebp + 8]  ; tamanho_programa
    sub edx, [ebp + 8]        ; edx = tamanhos[i] - tamanho_programa

    ; ==== Imprimir resultado da subtração ====
    ;push edx
    ;push msg_resultado_subtracao
    ;call printf
    ;add esp, 8

    cmp edx, 0
    jl proximo_bloco  ; Se for negativo, não cabe, pula para o próximo

    ; Calcular endereço final: endereco + tamanho_programa - 1
    add ecx, eax      ; ecx = endereco + tamanho_programa
    dec ecx           ; ecx = endereco + tamanho_programa - 1

    ; TODO: Chamar função assembly que imprime
    ; ==== Imprimir "Programa cabe no endereco X ate Y" ====
    push ecx
    push eax
    push msg_cabe
    call printf
    add esp, 12

    ; fim
    jmp fim

proximo_bloco:
    ; Avançar para o próximo bloco
    add esi, 4
    add edi, 4

    ; Decrementar contador e continuar se não for zero
    dec ebx
    jnz loop_blocos
    ; FIXME: verificar se esse je fim funciona e é necessário
    je fim


fim:
    pop edi
    pop esi
    pop ebx
    mov esp, ebp
    pop ebp
    ret
