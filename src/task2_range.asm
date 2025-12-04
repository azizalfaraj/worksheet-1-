%include "asm_io.inc"

section .bss
    arr    resd 100        ; array of 100 ints
    start  resd 1
    finish resd 1

section .data
    askStart db "Enter start of range (1-100): ", 0
    askEnd   db "Enter end of range (1-100): ", 0
    errMsg   db "Invalid range", 0

section .text
    global asm_main

asm_main:
    enter 0, 0
    pusha

    ; ---------- initialise arr[i] = i+1 for i=0..99 ----------
    mov ecx, 100          ; loop count
    mov ebx, 0            ; index i = 0

init_loop:
    mov eax, ebx
    inc eax               ; eax = i + 1
    mov [arr + ebx*4], eax
    inc ebx
    loop init_loop

    ; ---------- ask for start ----------
    mov eax, askStart
    call print_string

    call read_int         ; eax = start
    mov [start], eax

    ; ---------- ask for end ----------
    mov eax, askEnd
    call print_string

    call read_int         ; eax = finish
    mov [finish], eax

    ; ---------- validate ----------
    ; start between 1 and 100
    mov eax, [start]
    cmp eax, 1
    jl invalid
    cmp eax, 100
    jg invalid

    ; finish between 1 and 100
    mov eax, [finish]
    cmp eax, 1
    jl invalid
    cmp eax, 100
    jg invalid

    ; start <= finish
    mov eax, [start]
    mov edx, [finish]
    cmp eax, edx
    jg invalid

    ; ---------- sum arr[start..finish] ----------
    ; ECX = number of elements = finish - start + 1
    mov eax, [finish]
    mov edx, [start]
    sub eax, edx          ; eax = finish - start
    inc eax               ; eax = finish - start + 1
    mov ecx, eax

    ; ESI = zero-based index = start - 1
    mov esi, [start]
    dec esi               ; esi = start - 1

    xor eax, eax          ; eax = sum = 0

range_loop:
    add eax, [arr + esi*4]
    inc esi
    loop range_loop

    ; print sum in eax
    call print_int
    call print_nl
    jmp done

invalid:
    mov eax, errMsg
    call print_string
    call print_nl

done:
    popa
    mov eax, 0
    leave
    ret

