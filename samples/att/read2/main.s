.data
    msg:
        .ascii  "Hello, world!\n"      # the string to print.
        len = . - msg                  # length of the string.
.bss
    .comm   input  10

.text

.global _start


_start:
  nop

  call _getInput
  call _printInput
  call _exit

_getInput:
  movl $3, %eax
  movl $0, %ebx
  movl $input, %ecx
  movl $10, %edx
  int $0x80
  ret

_printInput:
  movl $4, %eax
  movl $1, %ebx
  movl $input, %ecx
  movl $10, %edx
  int $0x80
  ret

_exit:

    movl    $0,%ebx         # first argument: exit code.
    movl    $1,%eax         # system call number (sys_exit).
    int     $0x80           # call kernel.
