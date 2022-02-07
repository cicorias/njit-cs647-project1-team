.data

        HelloWorld:
                .asciz "Hello World!\n"
				lenHelloWorld = .-HelloWorld

        HelloFunction:
                .asciz "Hello Function!\n"
				lenHelloFunction =.-HelloFunction

.bss
        .comm StringPointer, 4
        .comm StringLength, 4

.text

        .globl _start

        .type MyFunction, @function

        MyFunction:

                movl $4, %eax
                movl $1, %ebx
                movl StringPointer, %ecx
                movl StringLength, %edx
                int $0x80
                ret

        _start:

                # Print Hello World
                movl $HelloWorld, StringPointer
                movl $lenHelloWorld, StringLength
                call MyFunction

                # Print Hello Function
                movl $HelloFunction, StringPointer
                movl $lenHelloFunction, StringLength
                call MyFunction

    ExitCall:
                movl $1, %eax
                movl $0, %ebx
                int $0x80
