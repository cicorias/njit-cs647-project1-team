.data

        HelloWorld:
                .asciz "Hello World!\n"

        ZeroFlagSet:
                .asciz  "Zero Flag was Set!\n"
                
.text

        .globl _start

        _start:



        movl 	$15, %eax		# eax = 15
        cmp 	$16, %eax		# compare 16 to eax
        jnz	PrintHelloWorld
		
	
	# Prints ZeroFlagSet string to the screen
        FlagSetPrint:
                movl $4, %eax
                movl $1, %ebx
                leal ZeroFlagSet, %ecx
                movl $20, %edx
                int $0x80
                jmp ExitCall

	
        ExitCall:
                movl $1, %eax
                movl $0, %ebx
                int $0x80

	# Prints HelloWorld string to the screen 10 times
        PrintHelloWorld:
                movl $10, %ecx				# ecx = 10
                PrintTenTimes:				
                        pushl %ecx			#push the value in ecx to the stack to store it

			# Write syscall to print HelloWorld string
                        movl $4, %eax			
                        movl $1, %ebx
                        leal HelloWorld, %ecx
                        movl $14, %edx
                        int $0x80

			popl %ecx			# retrieve ecx from the stack
                loop PrintTenTimes			# decrements ecx each time
                jmp ExitCall				# jump to exit the program






