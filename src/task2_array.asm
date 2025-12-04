%include "asm_io.inc"

section .bss
    arr resd 100          ; array of 100 integers

section .text
    global asm_main

asm_main:
    enter 0, 0
    pusha

    ; ------------ initialise arr[i] = i+1 (1..100) ------------
    mov ecx, 100          ; loop counter
    mov ebx, 0            ; index i = 0

init_loop:
    mov eax, ebx
    inc eax               ; eax = i + 1
    mov [arr + ebx*4], eax
    inc ebx
    loop init_loop

    ; ------------ sum all elements ------------
    mov ecx, 100          ; loop 100 times
    mov ebx, 0            ; index i = 0
    xor eax, eax          ; eax = sum = 0

sum_loop:
    add eax, [arr + ebx*4]
    inc ebx
    loop sum_loop

    ; eax now holds the sum (should be 5050)
    call print_int
    call print_nl

    ; ------------ exit ------------
    popa
    mov eax, 0
    leave
    ret

