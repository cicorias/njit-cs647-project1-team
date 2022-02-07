.data

	HelloWorld:
		.asciz "Hello World!" # 12 chars + null byte = 13

	LoadStr:
		.asciz "ABCDEFGHI" # 9 characters plus the null byte = 10

	HelloCS647:
		.asciz "Hello CS647!"
	
 	Len_HelloCS647 = .-HelloCS647

.bss

	.comm	Destination, 100
	.comm	DestinationWithRep, 100

.text

	.globl _start

	_start:

		nop

		movl $HelloWorld, %esi      # This stores the address of HelloWorld in register esi
		movl $Destination, %edi		# This stores the address of Destination in register edi


		# In GDB, watch what happens to esi and Destination after
		# each of the following three instructions executes.
		movsb
		movsw
		movsl


		# show setting and clearing the direction flag
		std		# set the flag
		cld		# clear the flag


		# Move the string using rep
		movl $13, %ecx
		movl $HelloWorld, %esi 			# don't forget esi was incrememented before
		movl $DestinationWithRep, %edi
		rep movsb						# moves one byte



		# The next block shows how you could use lods and stos to quickly process the
		# elements of an array. 
		leal 	LoadStr, %esi		# Store the address of LoadStr into register esi
		leal	LoadStr, %edi		# Store the address of the destination in edi
		
		
		# Convert the first 4 letters in the string to lowercase
		
		lodsb				# load in the first byte to eax	
		add $0x20, %al		# add 0x20 to that byte in eax
		stosb				# store that byte in DestinationWithStos

		# Repeat 3 more times for demonstration
		
		lodsb              # load in the next byte to eax 
		add $0x20, %al       
		stosb                

		lodsb              # load in the third byte to eax 
		add $0x20, %al       
		stosb                

		lodsb              # load in the 4th byte to eax 
		add $0x20, %al       
		stosb                




		# Now compare strings
		leal HelloWorld, %esi		# Load the addr of the first string into esi
		leal HelloCS647, %edi		# Load the addr of the second string into edi
		cmpsb

		dec %edi					# Decrement edi to reset it back to the beginning of the string
		dec %esi					# Decrement esi to reset it back to the beginning of the string
		cmpsw

		subl $2, %esi				# Subtract esi, and edi, by 2 to have them point to the beginning of the strings
		subl $2, %edi
		cmpsl

		# Now show how to repeat
		leal HelloWorld, %esi           # Load the addr of the first string into esi
        leal HelloCS647, %edi           # Load the addr of the second string into edi
		movl $Len_HelloCS647, %ecx		# repnz will repeat until the zero flag is no longer set or ecx = 0
		repz cmpsb


		# Exit
		movl $1, %eax
		movl $0, %ebx
		int  $0x80
