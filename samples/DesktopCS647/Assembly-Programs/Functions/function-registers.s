.data

        HelloWorld:
                .asciz "Hello World!\n"
				lenHelloWorld = .-HelloWorld

        HelloFunction:
                .asciz "Hello Function!\n"
				lenHelloFunction =.-HelloFunction

.text

        .globl _start

        .type MyFunction, @function

        # In this case MyFunction expects the string to print to be in ECX and
        # its length to be in EDX
        MyFunction:

                movl $4, %eax
                movl $1, %ebx
                int $0x80
                ret

        _start :
                nop

                # Print Hello World
                leal HelloWorld, %ecx
                movl $lenHelloWorld, %edx
                call MyFunction

                # Print Hello Function
                leal HelloFunction, %ecx
                movl $lenHelloFunction, %edx
                call MyFunction

        ExitCall:
                movl $1, %eax
                movl $0, %ebx
                int $0x80
