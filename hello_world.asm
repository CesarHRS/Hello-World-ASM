    ;all syscalls are for MacOS 64 bits

    section .data
str:    db  "Hello, World"      ;db is a command from nasm, it allows me to define bytes. In the executable, on the str loc ation, it will be the bytes for hello world
.len:   equ $ - str             ;equ is another nasm command, this line takes the relative position of len in the memory and than subtracts itself with the position of str, and this will get the length of "Hello World"
        ;this only make sense because the write command takes 3 parameters, the file descriptor, a char pointer to a buffer where the string is located and the length of the string

    section .text   ;the text section is were the code is
    global _main    ;indicates that the main label is a global label, so it could be called from other labels
_main:
        ;the mov instructions move a value to a register, the next line says that rax = 0x02000004
        mov    rax, 0x02000004    ; system call for write
        mov    rdi, 1             ; file descriptor 1 is stdout, 0 is stdin and 2 is stderr, this case I'm using 1 because o want to print Hello, World
        mov    rsi, str           ; move str to rdi, str is a place in the executable
        mov    rdx, str.len       ; move the number of bytes from str (the lenght of Hello, World) to rdx
        syscall                   ; execute a syscall (in this case it will be 0x02000004 (write))
        ;this part of the code is for safety
        mov    rax, 0x02000001    ; system call for exit
        xor    rdi, rdi           ; exit code 0. I have used xor with 2 registers instead of moving 0 to them only because the mov instruction takes a few more bytes and it is slower than xor instruction
        syscall                   ; execute syscall (exit)

