; Task 1.2 - Slide 22 Program

%include "asm_io.inc"

section .data
    x dd 20
    y dd 3

section .text
    global asm_main

asm_main:

    ; eax = x - y
    mov eax, [x]
    sub eax, [y]

    push eax
    call print_int
    add esp, 4

    ; newline
    push dword 10
    call print_char
    add esp, 4

    ; eax = x * y
    mov eax, [x]
    imul eax, [y]

    push eax
    call print_int
    add esp, 4

    ret
