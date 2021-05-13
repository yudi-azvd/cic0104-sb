; Para compilar esse programa em um PC de 64bits:
; nasm -f elf example3.asm -o example3.o
; ld -m elf_i386 -o example3 example3.o


; dados inicializados
          section .data
name_msg:     db  "Please enter your name: "
NAMESIZE:     equ $-name_msg
query_msg:    db  "How many times to repeat welcome message? "
QUERYSIZE:    equ $-query_msg
confirm_msg1: db  "Repeat welcome message" 
CONF1SIZE:    equ $-confirm_msg1
confirm_msg2: db  "times? (y/n)"
CONF2SIZE:    equ $-confirm_msg2
welcome_msg:  db  "welcome to Assembly Language Programming, "
WELCSIZE:     equ $-welcome_msg
newline:      db  0dh, 0ah
NEWLSIZE:     equ $-newline

; dados não inicializados
          section .bss
user_name:    resb 16
response:     resb 1


          section .text
global _start
_start:
  mov eax, 4
  mov ebx, 1
  mov ecx, name_msg
  mov edx, NAMESIZE
  int 80h
  mov eax, 3
  mov ebx, 0
  mov ecx, user_name
  mov edx, 16
  int 80h

ask_count:
  mov eax, 4
  mov ebx, 1
  mov ecx, query_msg
  mov edx, QUERYSIZE
  int 80h
  mov eax, 3
  mov ebx, 0
  mov ecx, response
  mov edx, 1
  int 80h
  mov ecx, 0          ; ecx inteiro foi zerado
  mov cl, [response]  ; ultimos 8bits de cl
  sub cl, 0x30        ; -48: offset do digitos na table ASCII
                      ; soh funciona quando tem um unico digito

display_msg:
  push ecx ; ecx para arquitetura 32bits
  mov eax, 4
  mov ebx, 1
  mov ecx, welcome_msg
  mov edx, WELCSIZE
  int 80h
  mov eax, 4
  mov ebx, 1
  mov ecx, user_name
  mov edx, 16
  int 80h
  mov eax, 4
  mov ebx, 1
  mov ecx, newline
  mov edx, NEWLSIZE
  int 80h
  pop ecx ; ecx para arq 32bits
  loop display_msg ; decrementa ecx sozinho
  mov eax, 1
  mov ebx, 0
  int 80h
