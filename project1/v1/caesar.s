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


.bss
    .comm   plaintext  51               # plaintext message 10 now for testing only will be 51
    .comm   rotinput 5                  # number up to 1000 plus EOL
    .comm   rotvalue 4                  # place where the post atoi goes

.text

  
  .global _start
    # used for gdb primarily
    .type PrintFunction, @function
    .type GetInput1, @function
    .type GetInput2, @function
    .type Encrypt, @function
    .type atoi, @function

  # here we encrypt the plain text value
  Encrypt:
    nop
    # prolog
    pushl %ebp              # store the current value of EBP on the stack
    movl %esp, %ebp         # Make EBP point to top of stack

    # these are my registers.... i zero them and have them here for my own recollection.
    xor %eax, %eax
    xor %ebx, %ebx
    xor %ecx, %ecx
    xor %edx, %edx

    # logic
    # here we setup a source and destiation for doing a loop "in place"
    movl 8(%ebp), %esi # plaintext, %esi  # source
    movl 8(%ebp), %edi # plaintext, %edi  #destination
    # we limit to 50 characters, 1 extra for \n
    movl $51, %ecx
    
    Loop:
      
      lodsb				# load in the next byte to eax
      # check if in range-- not sure why my logic here didn't work so commented out.
      # IF eax < 65 - exit
      // cmp $65, %eax
      // jb _exit

      cmp $32, %eax  # its a space
      je noshift  # jump to avoid shifting but preserving

      # IF eax > 90 - exit  -- not required, but if value is beyond capital alpa
      cmp $90, %eax
      jg _exit

      cmp $0xa, %eax		#compare with "\n"
      je encryptdone  #if we get a \n jump to this label - forget the label name

      movl %eax, %edx # get read to add ROT value
      addl 12(%ebp), %edx  # this is the post modulus ROT value from the stack


      cmp $90, %edx  # are we now OVER letter Z ?
      jle doshift  # if NOT go to shift

      sub $26, %al  # we're over 90/Z so, normalize back to letter range

      doshift:
        add   12(%ebp) , %al # now, shift the value put lower byte in eax...

        stosb				# store that byte in destination as specificed above - this is "in-place"
        dec		%ecx		# decrement the counter			
        
        jecxz	encryptdone  # are we at the end of an asciiz ?
        jmp		Loop # back to next byte

      noshift:
        stosb  # store the byte without a ROT shift
        dec   %ecx  # decrement 
        jecxz	encryptdone # are we at the end of an asciiz?
        jmp		Loop  # start next byte


		encryptdone:
      nop  # get ready to exit fn


    # epilog
    movl %ebp, %esp         # Restore the old value of ESP
    popl %ebp               # Restore the old value of EBP
    ret   


  GetInput1: 
    nop
    movl $3, %eax  # call for read
    movl $0, %ebx  #  use stdin
    movl $plaintext, %ecx  #pointer to plaintext
    movl $51, %edx   # limit to 50 character as specified
    int $0x80  #syscall
    ret
    
  GetInput2:
    nop
    movl $3, %eax  #call for read
    movl $0, %ebx  # use stdin
    movl $rotinput, %ecx # pointer to ROT in string/ascii
    movl $5, %edx   # limit to 4 chars as < 1000
    int $0x80 # syscall
    ret

  PrintFunction:  # taken from examples in class
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
    nop
    # prolog
    pushl %ebp              # store the current value of EBP on the stack
    movl %esp, %ebp         # Make EBP point to top of stack
    
    # these are my registers.... i zero them and have them here for my own recollection.
    xor %eax, %eax  
    xor %ebx, %ebx
    xor %ecx, %ecx
    xor %edx, %edx

    movl $0, %eax        # initialize the accumulator
    movl $rotinput, %esi #point to input
    movl $10, %ecx  #need the multiplier
 
    nxchr:
        xor %ebx, %ebx        # clear all the bits in EBX
        mov (%esi), %bl     # load next character in BL
        incl %esi            # and advance source index

        cmp $0xa, %ebx		#compare with "\n"
        je atoidone       #we are done

        cmp $'0', %bl       # does character preceed '0'?
        jb  inval           # yes, it's not a numeral jb:jump below
        cmp $'9', %bl       # does character follow '9'?
        ja  inval           # yes, it's not a numeral ja:jump above

        sub $'0', %bl       # else convert numeral to int
        imull	%ecx	            # multiply accumulator by ten. %eax * 10
        addl %ebx, %eax      # and then add the new integer
        jmp nxchr           # go back for another numeral

    atoidone:
      # zero it out -- ECX has the "low order parts" from prior loop
  	  xor	%edx, 	%edx

      movl  $26, %ebx  # put 26 for denominstor
      idiv  %ebx  # divid EDX:ECX

      movl  %edx, rotvalue  # grab the remainder as it's normal and below 27 now

    inval:
      # epilog
      movl %ebp, %esp         # Restore the old value of ESP
      popl %ebp               # Restore the old value of EBP
      ret  

_start:
  nop

  # push the strlen on the stack
  pushl $prompt1len
  # push the string pointer on the stack
  pushl $prompt1
  call PrintFunction

  # get the plain text
  call GetInput1

  # push the strlen on the stack
  pushl $prompt2len
  # push the string pointer on the stack
  pushl $prompt2
  call PrintFunction
  
  # get the ROT
  call GetInput2  # this is ROT

  # convert from ascii to int and normalize < 27
  call atoi

  # push length
  pushl rotvalue
  # push pointer
  pushl $plaintext
  call Encrypt

  # push the strlen on the stack
  pushl $prompt3len
  # push the string pointer on the stack
  pushl $prompt3
  call PrintFunction

  # push the strlen on the stack
  pushl $51
  # push the string pointer on the stack
  pushl $plaintext
  call PrintFunction

  call _exit

  _exit:

      movl    $0,%ebx         # first argument: exit code.
      movl    $1,%eax         # system call number (sys_exit).
      int     $0x80           # call kernel.
