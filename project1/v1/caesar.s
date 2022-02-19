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
    .comm   rotvalue 4

.text

  .global _start
    .type PrintFunction, @function
    .type GetInput1, @function
    .type GetInput2, @function
    .type Encrypt, @function
    .type atoi, @function

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
      pushl $rotvalue # $ROTTEMP
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

        cmp $32, %eax  # its a space
        je noshift

        # IF eax > 90 - exit
        cmp $90, %eax
        jg _exit

        cmp $0xa, %eax		#compare with "\n"
        je PrintStrAfter

        # IF eax + ROT > 90 ; eax + ROT - 26
        movl %eax, %edx
        
        addl rotvalue, %edx  # ROTTEMP, %edx
        cmp $90, %edx
        jl doshift

        sub $26, %al

        doshift:
        # now shift.. ?? %ebx
        add  rotvalue, %al #  ROTTEMP, %al # 	%dl, %al	# add ROT to that byte in eax
        stosb				# store that byte in DestinationWithStos
        dec		%ecx		# decrement the counter			
        
        jecxz	PrintStrAfter
        jmp		Loop

        noshift:
        stosb
        dec   %ecx
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


  atoi:
  # https://stackoverflow.com/questions/19461476/convert-string-to-int-x86-32-bit-assembler-using-nasm/28202303#28202303
    nop
    # prolog
    pushl %ebp              # store the current value of EBP on the stack
    movl %esp, %ebp         # Make EBP point to top of stack
    
    xor %eax, %eax
    xor %ebx, %ebx
    xor %ecx, %ecx
    xor %edx, %edx

    movl $0, %eax        # initialize the accumulator
    movl $rotinput, %esi
    movl $10, %ecx
 
    nxchr:
        movl $0, %ebx        # clear all the bits in EBX
        mov (%esi), %bl     # load next character in BL
        incl %esi            # and advance source index


        cmp $0xa, %ebx		#compare with "\n"
        je atoidone

        cmp $'0', %bl       # does character preceed '0'?
        jb  inval           # yes, it's not a numeral jb:jump below
        cmp $'9', %bl       # does character follow '9'?
        ja  inval           # yes, it's not a numeral ja:jump above

        sub $'0', %bl       # else convert numeral to int
        imull	%ecx	            # multiply accumulator by ten. %eax * 10
        addl %ebx, %eax      # and then add the new integer
        jmp nxchr           # go back for another numeral



    atoidone:
      # preserve it
      movl  %eax, rotvalue
    inval:
      # epilog
      movl %ebp, %esp         # Restore the old value of ESP
      popl %ebp               # Restore the old value of EBP
      ret  

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
  
  
  call GetInput2  # this is ROT

  call atoi


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
