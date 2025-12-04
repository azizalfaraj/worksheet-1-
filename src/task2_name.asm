; Task 2 - Program 1
; Asks for a number, checks 50 < n < 100,
; then prints "Welcome Aziz" n times.

%include "asm_io.inc"

section .data
    askCount db "How many times to print? ", 0
    errMsg   db "Error: number must be >50 and <100", 0
    welcome  db "Welcome Aziz", 0

section .text
    global asm_main

asm_main:
    ; standard prologue
    enter 0, 0
    pusha

    ; print prompt
    mov eax, askCount
    call print_string

    ; read integer into EAX
    call read_int          ; eax = user input
    mov ecx, eax           ; use ECX as loop counter

    ; validate: 50 < n < 100
    cmp ecx, 50
    jle invalid_input
    cmp ecx, 100
    jge invalid_input

print_loop:
    ; print "Welcome Aziz"
    mov eax, welcome
    call print_string

    ; newline
    call print_nl

    loop print_loop
    jmp done

invalid_input:
    mov eax, errMsg
    call print_string
    call print_nl

done:
    ; standard epilogue
    popa
    mov eax, 0
    leave
    ret





