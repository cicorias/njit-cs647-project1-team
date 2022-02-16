.data
	var_x:	
		.int 4
	var_y:
		.int 10
	


.bss

.text

	.globl _start

	_start:


		# Increment - decrement works the same. Swap <inc> with <dec>
		movl	var_x, %eax			# eax = 4
		incl 	%eax				# increment eax. eax is now 5
		incl	var_x(,1)			# var_x = 5

		
		
		# Addition (subtraction is the same, just use <sub> instead of <add>)
	
		# Adding constants to register and memory
		addl	$5, var_x			# Adds 5 to var_x. var_x is now 10 
		addl	$4, %eax			# Adds 4 to eax. eax is now 9
		
		# Adding a register to a register
		movl	$10, %ebx			# ebx = 10
		addl	%eax, %ebx			# ebx = (eax + ebx). ebx is now 19

		# Adding a register to memory
		addl	%eax, var_x(,1)		# var_x = (eax + var_x). var_x is now 19

		# Adding memory to a register
		addl	var_x, %ebx			# ebx = (var_x + ebx). ebx is now 38
	

		

		# Integer Multiplication
		movl	$5, %eax				# eax = 5
		movl	$10, %ebx				# ebx = 10
		movl	$20, %ecx				# ecx = 20


		# Single Operand multplies the register or memory operand by the value in eax and stores
		# the result in EDX:EAX
		imull	%ecx	

		# Multiplying two registers
		imull	%eax, %ebx				# ebx = eax * ebx. ebx is now 1000

		# Multiplying memory and a register
		imull	var_y,	%eax			# eax = var_y * eax. eax is now 1000

		# Scaling a register by a constant and storing the result in a register
		imull	$10, var_y, %eax		# eax = 10 * var_y. eax is now 100

		# Scaling memory by a constand value and storing the result in a register
		imull	$25, var_y, %eax		# eax = var_y * 25. eax is now 250


		

		# Integer Division
	
		# Most significant 4 bytes are in edx. Least significant 4 bytes are in eax so the number is 100
		movl	$0, 	%edx	# edx = 0
		movl	$100,	%eax	# eax = 100
								# EDX:EAX = 100


		# Divide EDX:EAX by register
		movl	$5,	%ebx		# ebx = 5
		idiv	%ebx			# The resulting quotient is stored in eax, and the remainder is stored in edx
								# eax will contain 20 and edx will contain 0


		# Reset EDX:EAX
		movl    $0,     %edx    # edx = 0
		movl    $100,   %eax    # eax = 100
		                        # EDX:EAX = 100
		
		# Divide EDX:EAX by memory location
		movl 	$9, var_y		# var_y = 9
		idivl	var_y(,1)		# 100/9 eax will contain 11 and edx will contain 1 



		# Exit	
		movl $1, %eax
		movl $0, %ebx
		int  $0x80
