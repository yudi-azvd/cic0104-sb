; Para compilar esse programa em um PC de 64bits:
; nasm -f elf file.asm -o file.o
; ld -m elf_i386 -o file file.o
%include "linux64.inc"

section .data
  filename  db "myfile.txt", 0
  text      db "Here's some text"

section .text
  global _start

_start:
  mov eax, SYS_OPEN          ; criar/abrir
  mov edi, filename
  mov esi, O_CREAT+O_WRONLY      ; 111 000 000
  mov edx, 0666o
  int 80h

  push eax
  mov edi, eax
  mov eax, SYS_WRITE
  mov esi, text
  mov edx, 17
  int 80h

  mov eax, SYS_CLOSE    ; SYS_CLOSE
  pop edi
  int 80h

end_program:
  exit

