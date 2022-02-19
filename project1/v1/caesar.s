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
    .comm   plaintext  51                   # plaintext message 10 now for testing only will be 51
    .comm   rotinput 5                  # number up to 1000 plus EOL


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

    # stack
    movl 8(%ebp), %ecx      # pointer to plaintext
    movl 12(%ebp), %edx     # rot length

      # debug
      pushl $51
      pushl 8(%ebp)
      call PrintFunction
      # debug
      pushl $5
      pushl 12(%ebp)
      call PrintFunction
      # debug - end

    # logic


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
