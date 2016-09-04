CC_FLAGS=-Wall -std=c11

ee:
	nasm -f elf64 -Isrc src/eval.s -o lib/eval.o

main: ee
	gcc -Iinclude $(CC_FLAGS) main.c lib/eval.o -o bin/main

all: ee main
