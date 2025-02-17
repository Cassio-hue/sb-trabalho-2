section .data
count DW 0
value DB 25

section .text
global _start

_start:
    inc WORD [count] ; count = 1
    dec BYTE [value] ; value = 24
    mov EBX,count ; EBX = count
    inc WORD [EBX] ; count = 2
    mov ESI,value ; ESI = value
    dec BYTE [ESI] ; value = 23

    mov eax, 1
    mov ebx, 0
    int 80h