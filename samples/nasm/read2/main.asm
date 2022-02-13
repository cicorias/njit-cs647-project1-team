section .data
  question db "What is your name? "
  greeting db "Hello, "

section .bss
  input resb 24

section .text

global _start

_start:

  call _printQuestion
  call _getInput
  call _printGreeting
  call _printInput
  call _exit

_getInput:
  mov eax, 3
  mov ebx, 0
  mov ecx, input
  mov edx, 24
  int 0x80
  ret

_printQuestion:
  mov eax, 4
  mov ebx, 1
  mov ecx, question
  mov edx, 19
  int 0x80
  ret

_printGreeting:
  mov eax, 4
  mov ebx, 1
  mov ecx, greeting
  mov edx, 7
  int 0x80
  ret

_printInput:
  mov eax, 4
  mov ebx, 1
  mov ecx, input
  mov edx, 24
  int 0x80
  ret


_exit:
    mov eax, 1          ; Return
    mov ebx, 0          ; | <- return code
    int 0x80            ; \