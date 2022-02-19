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
    .comm   input  10                   # plaintext message 10 now for testing only will be 51
    .comm   rotinput 5                  # number up to 1000 plus EOL


.text

  .global _start
    .type PrintFunction, @function
    .type GetInput1, @function
    .type GetInput2, @function
    .type Encrypt, @function

  Encrypt:
    nop
    ret

  GetInput1:
    nop
    movl $3, %eax
    movl $0, %ebx
    movl $input, %ecx
    movl $10, %edx
    int $0x80
    ret
    
  GetInput2:
    nop
    movl $3, %eax
    movl $0, %ebx
    movl $input, %ecx
    movl $10, %edx
    int $0x80
    ret

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
  call Encrypt


  # push the strlen on the stack
  pushl $prompt3len
  # push the string pointer on the stack
  pushl $prompt3
  call PrintFunction

  ; call _exit

  _exit:

      movl    $0,%ebx         # first argument: exit code.
      movl    $1,%eax         # system call number (sys_exit).
      int     $0x80           # call kernel.
