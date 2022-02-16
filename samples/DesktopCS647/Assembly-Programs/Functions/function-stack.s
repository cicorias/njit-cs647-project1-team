.data

        HelloWorld:
                .asciz "Hello World!\n"
				lenHelloWorld = .-HelloWorld
.text

        .globl _start
        .type PrintFunction, @function

        PrintFunction:
                pushl %ebp              # store the current value of EBP on the stack
                movl %esp, %ebp         # Make EBP point to top of stack

                # The write function
                movl $4, %eax
                movl $1, %ebx
                movl 8(%ebp), %ecx
                movl 12(%ebp), %edx
                int $0x80

                movl %ebp, %esp         # Restore the old value of ESP
                popl %ebp               # Restore the old value of EBP
                ret                     # change EIP to to jump to "addl $8, %esp"

        _start:

                # push the strlen on the stack
                pushl $lenHelloWorld

                # push the string pointer on the stack
                pushl $HelloWorld

                # Call the function
                call PrintFunction

                # adjust the stack pointer
                addl $8, %esp


                ExitCall:

                        movl $1, %eax
                        movl $0, %ebx
                        int $0x80
