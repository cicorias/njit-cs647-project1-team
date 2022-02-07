# build and run

```
gcc caesar.c && ./a.out
```


## compile and disassemble
```
gcc -O0 -c caesar.c -o caesar.o && \
objdump -d caesar.o  > caeaser.s
```