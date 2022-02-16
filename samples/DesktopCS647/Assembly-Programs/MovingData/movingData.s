.data
        IntArray:
                .int 10, 20, 30, 40, 50

        var_x:
                .int 1337
        var_y:
                .int 10

.text
        .globl _start
        _start:


		# Moving constants into registers or memory
                movl $16, %eax		# const, reg ----- eax = 16
                movl $0x10, var_y	# const, mem ----- var_y = 16

		# Moving data from between memory and a register
                movl var_x, %eax         # mem, reg ---- copy 1337 into eax. eax = 1337
                movl %eax, %ecx          # reg, reg ---- copy eax into ecx. ecx = 1337
                movl %ebx, var_y         # reg, mem ---- copy 1337 into var_y


		# Moving Data into an indexed memory location
                # Format: movl _value, Label(offset, index, data_size)
                movl $0, %ecx				# ecx = 0 (offset = 0)
                movl $2, %edi				# edi = 2 (index = 2)
                movl $4, %eax				# eax = 4
                movl %eax, IntArray(%ecx, %edi, 4)	# move the value in eax to the IntArray at index 2

                # Move 5 into IntArray at location 1 (offset + data_size*index)
                movl $1, %ecx
                movl $0, %edi
                movl $5, IntArray(%ecx, %edi, 4)


                # Indirect Addressing
                movl $IntArray+4, %eax  # store the address of IntArray + 4 in EAX
                movl $1, (%eax)         # store the number 1 at the address eax is pointing to IntArray[1]
                movl $2, 4(%eax)        # store the number 2 at the address of eax + 4 IntArray[2]


                # Exit the program
                movl $1, %eax
                movl $0, %ebx
                int  $0x80

