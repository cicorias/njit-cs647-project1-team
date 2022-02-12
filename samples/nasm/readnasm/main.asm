BUFFER_SIZE equ 5
LINE_FEED equ 10

global _start           ; must be declared for using gcc ???

section .data
    str: times BUFFER_SIZE db 0 ; Allocate buffer of x bytes
    lf:  db 10          ; LF line feed

section .bss
    e1_len resd 1
    dummy resd 1

section .text

_start:                 ; tell linker entry point ???
    ; https://stackoverflow.com/questions/23468176/read-and-print-user-input-with-x86-assembly-gnu-linux

; read using function 3 (sys_read)
    mov eax, 3          ; Read user input into str
    mov ebx, 0          ; |
    mov ecx, str        ; | <- destination
    mov edx, BUFFER_SIZE        ; | <- length
    int 80h             ; \

    mov [e1_len], eax   ; Store number of inputted bytes
    cmp eax, edx        ; all bytes read?
    jb .2               ; yes: ok
    mov bl, [ecx+eax-1] ; BL = last byte in buffer
    cmp bl, LINE_FEED   ; LF in buffer?
    je .2               ; yes: ok
    inc DWORD [e1_len]  ; no: length++ (include 'lf')

; drain the linux input buffer
    .1:                 ; Loop
    mov eax, 3           ; SYS_READ
    mov ebx, 0          ; EBX=0: STDIN
    mov ecx, dummy      ; pointer to a temporary buffer
    mov edx, 1          ; read one byte
    int 0x80            ; syscall
    test eax, eax       ; EOF? eax contains the amount of bytes read
    jz .2               ; yes: ok
    mov al, [dummy]     ; AL = character
    cmp al, LINE_FEED   ; character = LF
    jne .1              ; no -> next character
    .2:                 ; end of loop

; output the array variable using function 4 from int 80h (sys_write)
    mov eax, 4          ; Print 100 bytes starting from str
    mov ebx, 1          ; |
    mov ecx, str        ; | <- source
    mov edx, [e1_len]   ; | <- length
    int 80h             ; \

; return using function 1 from int 80h (sys_exit)
    mov eax, 1          ; Return
    mov ebx, 0          ; | <- return code
    int 80h             ; \
