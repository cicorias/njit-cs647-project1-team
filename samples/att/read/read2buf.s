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
    movl    $3,         %eax  #syscall read
    movl    $0,         %ebx  #std input
    movl    $Str,       %ecx
    movl    $strlen,    %edx
    int     $0x80

    movl    %eax,       Str
    cmp     %edx,       %eax
    jb      endloop
    movb    -0x1(%ecx,%eax,1),  %bl
    cmp     $10,        %bl
    je      endloop
    incl    e1_len


    loop:
        movl    $3,         %eax  #syscall read
        movl    $0,         %ebx  #std input        
        movl    $Str,       %ecx
        movl    $strlen,    %edx
        int     $0x80
        test    %eax,       %eax
        je      endloop
        movb    dummy,      %al
        jne     loop

    endloop:


    movl    $4,     %eax
    movl    $1,     %ebx
    movl    $Str,   %ecx
    movl    $e1_len,      %edx

    #just write something
    // movl    $len,       %edx       # third argument: message length.
    // movl    $msg,       %ecx       # second argument: pointer to message to write.
    // movl    $1,         %ebx	        # first argument: file handle (stdout).
    // movl    $4,         %eax	        # system call number (sys_write).
    // int     $0x80           # call kernel.

    # and exit.

    movl    $0,%ebx         # first argument: exit code.
    movl    $1,%eax         # system call number (sys_exit).
    int     $0x80           # call kernel.

