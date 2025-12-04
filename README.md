
Screenshots for this task can be found in /screenshots/task1_output.png in my repo

# Worksheet 1 – An Echo of Assembler

Module: UFCFWK-15-2 Operating Systems  
Student: Abdulaziz Alfaraj

This repo contains my solutions for Worksheet 1.  
The work covers:

- Basic x86 assembler
- Calling assembler from C using `driver.c`
- Loops and conditionals in assembler
- Using `make` to build multiple programs

Directory layout:

```text
worksheet1/
├── Makefile
├── README.md
└── src/
    ├── asm_io.inc
    ├── asm_io.asm
    ├── driver.c
    ├── task1.asm
    ├── task1_2.asm
    ├── task2_name.asm
    ├── task2_array.asm
    └── task2_range.asm
 
From the root of the repo (worksheet1):
make          # builds task1, task1_2, task2_name, task2_array, task2_range
./task1
./task1_2
./task2_name
./task2_array
./task2_range

Task 1: task1.asm
Adds two integers stored in global memory (num1 and num2).
Stores them in .data and uses print_int from asm_io.

section .data
    num1 dd 5
    num2 dd 7

section .text
    global asm_main

asm_main:
    enter 0, 0
    pusha

    mov eax, [num1]
    add eax, [num2]
    call print_int          ; prints 12
    call print_nl

    popa
    mov eax, 0
    leave
    ret


output =12






Task 1.2: task1_2.asm
Based on the slide 22 example.
Performs two arithmetic operations and prints both results.
Example (if x = 20, y = 3):
17
60   OR 1760




Task 2 – Loops and Conditionals (20%)
Program 1 – Welcome message: task2_name.asm
Description:
Asks the user how many times to print a welcome message.
Checks that the value is greater than 50 and less than 100.
If valid, prints Welcome Aziz that many times.
Otherwise prints an error.
Core logic:
mov eax, askCount
call print_string

call read_int          ; user input → EAX
mov ecx, eax           ; loop counter

cmp ecx, 50
jle invalid_input
cmp ecx, 100
jge invalid_input

print_loop:
    mov eax, welcome
    call print_string
    call print_nl
    loop print_loop
How many times to print? 20
Error: number must be >50 and <100

How many times to print? 55
Welcome Aziz
Welcome Aziz



task2_array.asm
Description:
Allocates an array of 100 integers in .bss.
Initialises arr[i] = i + 1 for i = 0..99 (values 1..100).
Loops over the array, summing all values into EAX.
Prints the sum using print_int.

; initialise 1..100
mov ecx, 100
mov ebx, 0

init_loop:
    mov eax, ebx
    inc eax                ; eax = i + 1
    mov [arr + ebx*4], eax
    inc ebx
    loop init_loop

; sum loop
mov ecx, 100
mov ebx, 0
xor eax, eax               ; sum = 0

sum_loop:
    add eax, [arr + ebx*4]
    inc ebx
    loop sum_loop

call print_int             ; prints 5050

Sum of a range: task2_range.asm
Description:
Reuses the same array arr[0..99] = 1..100.
Asks the user for a start and end value between 1 and 100.
Checks that both are in range and start <= end.
If valid, sums arr[start..end] and prints the result.
Otherwise prints "Invalid range".
Core logic:

mov eax, askStart
call print_string
call read_int
mov [start], eax

mov eax, askEnd
call print_string
call read_int
mov [finish], eax

; validate 1..100 and start <= finish
; ...

; ECX = finish - start + 1
mov eax, [finish]
mov edx, [start]
sub eax, edx
inc eax
mov ecx, eax

mov esi, [start]
dec esi             ; zero-based index
xor eax, eax        ; sum = 0

range_loop:
    add eax, [arr + esi*4]
    inc esi
    loop range_loop

call print_int

Enter start of range (1-100): 50
Enter end of range (1-100): 20
Invalid range

Enter start of range (1-100): 10
Enter end of range (1-100): 40
775


I created a Makefile in the repo root to automate building all programs.
all: task1 task1_2 task2_name task2_array task2_range

task1: src/task1.o src/driver.o src/asm_io.o
	gcc -m32 src/driver.o src/task1.o src/asm_io.o -o task1

task1_2: src/task1_2.o src/driver.o src/asm_io.o
	gcc -m32 src/driver.o src/task1_2.o src/asm_io.o -o task1_2

task2_name: src/task2_name.o src/driver.o src/asm_io.o
	gcc -m32 src/driver.o src/task2_name.o src/asm_io.o -o task2_name

task2_array: src/task2_array.o src/driver.o src/asm_io.o
	gcc -m32 src/driver.o src/task2_array.o src/asm_io.o -o task2_array

task2_range: src/task2_range.o src/driver.o src/asm_io.o
	gcc -m32 src/driver.o src/task2_range.o src/asm_io.o -o task2_range

src/%.o: src/%.asm
	nasm -f elf $< -o $@

src/driver.o: src/driver.c
	gcc -m32 -c src/driver.c -o src/driver.o

clean:
	rm -f src/*.o task1 task1_2 task2_name task2_array task2_range
Running make rebuilds all executables, which demonstrates understanding of basic build automation.

Task 4 – Reflection
In completing this worksheet I:
Practised writing simple assembler functions and calling them from C.
Implemented arithmetic with values in global memory.
Translated C-style loops and if-statements into x86 loop/compare/jump instructions.
Used arrays and pointer arithmetic to sum ranges of values.
Wrote a Makefile to manage compilation and linking automatically.
Screenshots throughout the README show the programs running on the CSCTCloud
