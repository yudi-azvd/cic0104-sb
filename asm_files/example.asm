; nasm -felf64 -o hello.o hello.asm # 64bits
; nasm -f elf -o hello.o hello.asm  # 32bits
; ld -o hello hello.o

section .data
msg: db "Hello World!", 0dh, 0ah ; CR+LF

global _start

section .text

_start: mov eax, 4    ; system call ID: sys_write
        mov ebx, 1    ; 1o argumento: file handler: stdout
        mov ecx, msg  ; 2o argumento: ponteiro p string
        mov edx, 14   ; 3o argumento: tamanho da string
        int 80h       ; chamada ao sistema
        mov eax, 1    ; matar programa
        mov ebx, 0
        int 80h
