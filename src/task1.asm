; Task 1 - Slide 18 Program
; Adds two integers stored in global memory and prints result

%include "asm_io.inc"

section .data
    num1 dd 5
    num2 dd 7

section .text
    global asm_main

asm_main:

    mov eax, [num1]
    add eax, [num2]

    push eax
    call print_int
    add esp, 4

    ret

