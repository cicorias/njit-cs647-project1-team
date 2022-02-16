.data

        PlaintextPrompt:
                .asciz "Please enter the plaintext:\n"
                lenPtPrompt = .-PlaintextPrompt
        ShiftPrompt:
                .asciz "Please enter the shift value:\n"
                lenShiftPrompt = .-ShiftPrompt

.bss

    .comm   PlainText, 51 # with \n
    .comm   Shift, 5  # max 1000 as char
    .comm   CipherText, 51 # with \n

.text

        .globl _start
        .type PrintFunction, @function
        .type ReadFunction, @function
        MAX_CHAR=50
        MAX_ROT=5

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

        ReadFunction:  #https://gist.github.com/EdoardoVignati/aa91ec281cac37d26f058bbd8812d846
                pushl %ebp              # store the current value of EBP on the stack
                movl %esp, %ebp         # Make EBP point to top of stack

                # the read from stdio (stdin)
                #movl $1,    %ebx  # shouild be address of rss comm string
                movl $3,    %eax	# syscall for read()
                movl $0, 	%ebx	# File descriptor
                movl %esp,  %ecx 	#starting point
                #movl 8(%ebp), %ecx  # param address? TODO: verify size
                #TODO: use stack limit
                movl $MAX_CHAR, %edx
                int $0x80

                ## Need the cycle to count input length ##	
                movl $1, %ecx 		#counter

                end_input:
                    xor %ebx, %ebx      #zero out ebx target
                    movb (%esp), %bl    #move just a byte to part of ebx
                    add $1, %esp		#get next char to compare 
                    add $1, %ecx	 	#counter+=1
                    cmp $0xa, %ebx		#compare with "\n"
                    #TODO: use stack pointer to bss 
                    #movb %bl, %ecx(PlainText)
                    movl %ecx, %edi
                    movb %bl, PlainText(%ecx,%edi,1) 
                    
                    jne end_input		#if not, continue 


                    ## WRITE ##
                    sub %ecx, %esp		#start from the first input char
                    movl $4, %eax		#sys_write (number 4)
                    movl $1, %ebx		#stdout (number 1)
                    movl %ecx, %edx		#start pointer
                    movl %esp, %ecx		#length
                    int $0x80		#call


                movl %ebp,  %esp         # Restore the old value of ESP
                popl %ebp               # Restore the old value of EBP
                ret                     # change EIP to to jump to "addl $8, %esp"

        _start:

                nop

                # push the strlen on the stack
                pushl $lenPtPrompt
                # push the string pointer on the stack
                pushl $PlaintextPrompt
                # Call the function
                call PrintFunction
                # adjust the stack pointer
                addl $8, %esp


                #READ plaintext
                #TODO
                pushl $PlainText
                call ReadFunction
                #TODO: end


                #DEBUG
                pushl $50
                pushl $PlainText
                call PrintFunction

                
                #prompt for shift
                # push the strlen on the stack
                pushl $lenShiftPrompt
                # push the string pointer on the stack
                pushl $ShiftPrompt
                # Call the function
                call PrintFunction
                # adjust the stack pointer
                addl $8, %esp


                #READ shift
                #TODO
                pushl $Shift
                call ReadFunction
                #TODO: end

                #calculate cipher
                #TODO

                #PRINT cipher text
                #TODO

                ExitCall:

                        movl $1, %eax
                        movl $0, %ebx
                        int $0x80
