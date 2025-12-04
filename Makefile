# Default rule: build everything
all: task1 task1_2 task2_name task2_array task2_range

# -------- TASK 1 --------
task1: src/task1.o src/driver.o src/asm_io.o
	gcc -m32 src/driver.o src/task1.o src/asm_io.o -o task1

task1_2: src/task1_2.o src/driver.o src/asm_io.o
	gcc -m32 src/driver.o src/task1_2.o src/asm_io.o -o task1_2

# -------- TASK 2 --------
task2_name: src/task2_name.o src/driver.o src/asm_io.o
	gcc -m32 src/driver.o src/task2_name.o src/asm_io.o -o task2_name

task2_array: src/task2_array.o src/driver.o src/asm_io.o
	gcc -m32 src/driver.o src/task2_array.o src/asm_io.o -o task2_array

task2_range: src/task2_range.o src/driver.o src/asm_io.o
	gcc -m32 src/driver.o src/task2_range.o src/asm_io.o -o task2_range

# -------- Assembly rules --------
src/%.o: src/%.asm
	nasm -f elf $< -o $@

# -------- C rule --------
src/driver.o: src/driver.c
	gcc -m32 -c src/driver.c -o src/driver.o

# -------- Clean --------
clean:
	rm -f src/*.o task1 task1_2 task2_name task2_array task2_range
