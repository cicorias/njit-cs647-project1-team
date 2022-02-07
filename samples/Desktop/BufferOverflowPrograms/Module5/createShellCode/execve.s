.text
	
	.globl _start
	_start:

	

	xor 	%eax, %eax		# eax = 0
	push	%eax			# push 0 onto the stack
	push	$0x68732f2f		# push "//sh"
	push	$0x6e69622f		# push "/bin"
	mov		%esp, %ebx		# make ebx point to the string /bin//sh
	mov		%eax, %ecx		# ecx = 0
	mov 	%eax, %edx		# edx = 0

	mov		$11, %al		# syscall for execve
	int		$0x80			# do it
