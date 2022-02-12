TARGET_DIR := target
MKDIR_P = mkdir -p

all: directories main

main: main.o
	ld -m elf_i386 target/main.o -o target/main

main.o: main.asm
	nasm -f elf32 main.asm -o target/main.o

clean:
	rm target/main.o target/main

# https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html
.PHONY: directories
directories: ${TARGET_DIR}

${TARGET_DIR}:
	${MKDIR_P} ${TARGET_DIR}
