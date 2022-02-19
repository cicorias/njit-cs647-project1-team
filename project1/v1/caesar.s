.data
    prompt1:
        .asciz  "Please enter the plaintext: "      # the string to print.
        prompt1len = .-prompt1                               # length of the string.

    prompt2:
        .asciz  "Please enter the shift value: "      # the string to print.
        prompt2len = .-prompt2                               # length of the string.

    prompt3:
        .asciz  "your ciphertext is: "      # the string to print.
        prompt3len = .-prompt3                               # length of the string.

    ROTTEMP:
      .int 3

.bss
    .comm   plaintext  51                   # plaintext message 10 now for testing only will be 51
    .comm   rotinput 5                  # number up to 1000 plus EOL
    .comm   ciphertext 51


.text

  .global _start
    .type PrintFunction, @function
    .type GetInput1, @function
    .type GetInput2, @function
    .type Encrypt, @function

  Encrypt:
    nop
    # prolog
    pushl %ebp              # store the current value of EBP on the stack
    movl %esp, %ebp         # Make EBP point to top of stack

    # these are my registers....
    xor %eax, %eax   #1
    xor %ebx, %ebx
    xor %ecx, %ecx   #1
    xor %edx, %edx

    # stack
    # movl 8(%ebp), %ecx      # parm 1 pointer to plaintext  # TODO: redundant
    # movl 12(%ebp), %edx     # parm 2 rot length

      # debug what offset is it on stack
      pushl $4
      pushl $ROTTEMP
      call PrintFunction
      subl $8, %esp


      # debug - this is the string address...
      pushl $51
      pushl 8(%ebp)
      call PrintFunction
      # reset stack x2
      subl $8, %esp

      # debug -- this is the ROT address
      pushl $5
      pushl 12(%ebp)
      call PrintFunction
      # reset stack x2
      subl $8, %esp
      # debug - end

    # logic
      # convert string to int
      # must handle moulus % 26
        // while:
        //   mov (%edx), %cl
        //   cmp $10, %cl               # if char is not asci 10 (enter)
        //   je endwhile
          
        //   sub $48, %cl
        //   add %cl, %al
        //   inc %ebx
        //   jmp while
        // endwhile:

      # shift each value
      # TODO: use stack instead
      # leal plaintext, %esi #  8(%ebp), %esi # plaintext, %esi
      # leal ciphertext, %edi #  8(%ebp), %edi # plaintext, %edi
      movl 8(%ebp), %esi # plaintext, %esi
      movl 8(%ebp), %edi # plaintext, %edi
      movl $51, %ecx

      pushl $0  # my counter at
      
      Loop:
				
        # Convert character to lowercase (assumes character is valid ASCII alphabetical character)
      
        # TODO: ROT coded to "1" T
        # TODO: IF OVER 'Z' 90 0x5A

        lodsb				# load in the first byte to eax
        # check if in range
        # IF eax < 65 - exit
        // cmp $65, %eax
        // jb _exit

        # IF eax > 90 - exit
        cmp $90, %eax
        jg _exit

        cmp $0xa, %eax		#compare with "\n"
        je PrintStrAfter

        # IF eax + ROT > 90 ; eax + ROT - 26
        movl %eax, %edx
        
        addl ROTTEMP, %edx
        cmp $90, %edx
        jl doshift

        sub $26, %al

        doshift:
        # now shift.. ?? %ebx
        add   ROTTEMP, %al # 	%dl, %al	# add ROT to that byte in eax
        stosb				# store that byte in DestinationWithStos
        dec		%ecx		# decrement the counter			
        
        jecxz	PrintStrAfter
        jmp		Loop


		PrintStrAfter:
			movl	$4, %eax		# syscall number for write()
			movl	$1,	%ebx		# file desriptor for stdout
			# leal  ciphertext, %ecx # 	plaintext, %ecx		# ecx -> Str
      movl  8(%ebp), %ecx 
			movl	$51, %edx	# store length of Str in edx
			int 	$0x80			# syscall

    # epilog
    movl %ebp, %esp         # Restore the old value of ESP
    popl %ebp               # Restore the old value of EBP
    ret   


  GetInput1:
    nop
    movl $3, %eax
    movl $0, %ebx
    movl $plaintext, %ecx
    movl $51, %edx
    int $0x80
    ret
    
  GetInput2:
    nop
    movl $3, %eax
    movl $0, %ebx
    movl $rotinput, %ecx
    movl $5, %edx
    int $0x80
    ret

  PrintFunction:
    pushl %ebp              # store the current value of EBP on the stack
    movl %esp, %ebp         # Make EBP point to top of stack

    # The write function
    movl $4, %eax           # write call
    movl $1, %ebx           # stdout
    movl 8(%ebp), %ecx      # message pointer
    movl 12(%ebp), %edx     # message length
    int $0x80

    movl %ebp, %esp         # Restore the old value of ESP
    popl %ebp               # Restore the old value of EBP
    ret                     # change EIP to to jump to "addl $8, %esp"

  AtoI:
  # https://stackoverflow.com/questions/19461476/convert-string-to-int-x86-32-bit-assembler-using-nasm/28202303#28202303
    nop

_start:
  nop

  # not using stack because of pure time limit
  # TODO: convert to single function with stack

  # push the strlen on the stack
  pushl $prompt1len
  # push the string pointer on the stack
  pushl $prompt1
  call PrintFunction


  call GetInput1


  # push the strlen on the stack
  pushl $prompt2len
  # push the string pointer on the stack
  pushl $prompt2
  call PrintFunction
  
  
  call GetInput2



  # at least this should use a stack...
  # push length
  pushl $rotinput
  # push pointer
  pushl $plaintext
  call Encrypt



  // # push the strlen on the stack
  // pushl $prompt3len
  // # push the string pointer on the stack
  // pushl $prompt3
  // call PrintFunction

  // # push the strlen on the stack
  // pushl $51
  // # push the string pointer on the stack
  // pushl $plaintext
  // call PrintFunction



  // # TODO: remove 
  // # DEBUG
  // # push the strlen on the stack
  // pushl $51
  // # push the string pointer on the stack
  // pushl $plaintext
  // call PrintFunction
  

  // # push the strlen on the stack
  // pushl $5
  // # push the string pointer on the stack
  // pushl $rotinput
  // call PrintFunction  

  # debug end

  call _exit

  _exit:

      movl    $0,%ebx         # first argument: exit code.
      movl    $1,%eax         # system call number (sys_exit).
      int     $0x80           # call kernel.
