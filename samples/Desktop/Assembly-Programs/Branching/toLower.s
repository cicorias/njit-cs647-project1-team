.data

	Str:
		.asciz "ABCDEFGHIJKLMNOPQRSTUVWXYZ\n"
		lenStr =.-Str
.text

	.globl _start

	_start:

		
		movl	$4, %eax		# syscall number for write()
		movl	$1,	%ebx		# file desriptor for stdout
		leal	Str, %ecx		# ecx -> Str
		movl	$lenStr, %edx	# store length of Str in edx
		int 	$0x80			# syscall

		
		# The next block shows how you could use lods and stos to quickly process the
		# elements of an array. 
		leal 	Str, %esi		# Store the address of LoadStr into register esi
		leal	Str, %edi		# Store the address of the destination in edi

		movl	$lenStr, %ecx		# Store the length of the string in ecx
		sub		$2,	%ecx			# Decrement ecx to not avoid changing newline or null byte

		
		Loop:
				
			# Convert character to lowercase (assumes character is valid ASCII alphabetical character)
		
			lodsb				# load in the first byte to eax	
			add 	$0x20, %al	# add 0x20 to that byte in eax
			stosb				# store that byte in DestinationWithStos
			dec		%ecx		# decrement the counter			
			
			jecxz	PrintStrAfter
			jmp		Loop


		PrintStrAfter:
			movl	$4, %eax		# syscall number for write()
			movl	$1,	%ebx		# file desriptor for stdout
			leal	Str, %ecx		# ecx -> Str
			movl	$lenStr, %edx	# store length of Str in edx
			int 	$0x80			# syscall


		Exit:
			# Exit the program
			movl $1, %eax
			movl $0, %ebx
			int  $0x80
