section .note.GNU-stack 


section .text
global print

print:
    ; Manipulação da pilha
    push EBP
    mov EBP, ESP
    
    ; Acessa os parâmetros (a = [EBP+8], b = [EBP+12])
    mov AX, [EBP+8]      ; AX = a
    add AX, [EBP+12]     ; AX += b (soma)
    
    ; Retorna o valor em AX
    pop EBP
    ret
