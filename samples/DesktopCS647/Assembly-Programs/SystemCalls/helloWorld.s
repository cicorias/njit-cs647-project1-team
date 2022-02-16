.data
	
	Str:
		.asciz "Hello World!\n"	
		lenStr = .-Str

.text 

	.globl _start

	_start:


		Write:

			# Print the string
			movl $4, 		%eax	# syscall for write()
			movl $1, 		%ebx	# File descriptor
			leal Str,		%ecx	# Store address of the string in ecx
			movl $lenStr, 	%edx	# store the lenth of the string in edx
			int  $0x80
	
		Exit:

			# Exit
			movl $1, %eax
			movl $0, %ebx
			int  $0x80
