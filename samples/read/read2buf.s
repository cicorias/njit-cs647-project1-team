BUFFER_SIZE=10
LINE_FEED=10
#https://www.wfbsoftware.de/read-from-stdin-in-linux-assembler/

.data
    msg:
        .ascii  "Hello, world!\n"      # the string to print.
        len = . - msg                  # length of the string.

    Str:
        strlen = BUFFER_SIZE

.bss
    .comm   e1_len  4
    .comm   dummy   4

.text

    .global _start

_start:
    nop

    #read input
    movl    $3,         %eax
    movl    $0,         %ebx
    movl    $Str,       %ecx
    movl    $strlen,    %edx
    int     $0x80

    movl    %eax,       $(e1_len)
    cmp     %edx,       %eax
    jb      endloop
    movl    %ecx + %eax-1,    %bl
    cmp     $10,        %b1
    je      endloop
    incl    $e1_len


    loop:



    endloop:



    #just write something
    movl    $len,       %edx       # third argument: message length.
    movl    $msg,       %ecx       # second argument: pointer to message to write.
    movl    $1,         %ebx	        # first argument: file handle (stdout).
    movl    $4,         %eax	        # system call number (sys_write).
    int     $0x80           # call kernel.

    # and exit.

    movl    $0,%ebx         # first argument: exit code.
    movl    $1,%eax         # system call number (sys_exit).
    int     $0x80           # call kernel.

