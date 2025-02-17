section .note.GNU-stack 

section .data
    msg db "Num blocos: ", 0
    len_msg EQU $ - msg

    msg_n_possivel db "Não é possível calcular o espaço", 0Ah
    len_msg_n_possivel equ $ - msg_n_possivel

section .bss
    buffer resb 12   ; Buffer para armazenar número convertido

section .text
global calcular_espaco
 
calcular_espaco:
    push EBP
    mov EBP, ESP

    ; Exibir a mensagem "O número é: "
    mov EAX, 4
    mov EBX, 1
    mov ECX, msg
    mov EDX, len_msg
    int 80h
    
    ; Converter número para string
    mov EAX, [EBP+6]   ; Número inteiro
    lea EDI, buffer    ; Ponteiro para o buffer
    call int_to_ascii  ; Converte para string

    ; Exibir número convertido
    mov EAX, 4
    mov EBX, 1
    mov ECX, buffer
    mov EDX, 12
    int 80h

    pop EBP
    ret

; ================================
; Converte um número inteiro (EAX) para ASCII
; Entrada: EAX (número), EDI (buffer de saída)
; ================================
int_to_ascii:
    push EBX
    push ECX
    push EDX

    mov EBX, 10        ; Divisor para obter dígitos
    mov ECX, 0         ; Contador de dígitos

convert_loop:
    xor EDX, EDX       ; Zera EDX para divisão correta
    div EBX            ; EAX = EAX / 10, EDX = resto (último dígito)
    add DL, '0'        ; Converte número para caractere ASCII
    push DX            ; Armazena caractere na pilha
    inc ECX            ; Incrementa contador de dígitos
    test EAX, EAX      ; Se EAX == 0, terminou
    jnz convert_loop

write_digits:
    pop AX             ; Pega caractere da pilha
    mov [EDI], AL      ; Escreve no buffer
    inc EDI            ; Avança buffer
    loop write_digits  ; Repete para todos os caracteres

    mov BYTE [EDI], 0  ; Adiciona terminador nulo

    pop EDX
    pop ECX
    pop EBX
    ret
