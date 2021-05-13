; Para compilar esse programa em um PC de 64bits:
; nasm -f elf file.asm -o file.o
; ld -m elf_i386 -o file file.o


section .data
  filename  db "hamlet.txt", 0
  text      db "to be or not to be", 0xa
  TEXT_SIZE: equ $-text

section .bss
  fd        resd 1 ; file descriptor
  size:     resd 1

section .text
  global _start

_start:
  mov eax, 8          ; criar/abrir
  mov ebx, filename
  ; NaO ESQUECER DO 'o' NO FINAL DO OCTAL
  mov ecx, 0644o      ; 110 100 100
  int 80h
  mov [fd], eax       ; guardar file descriptor em eax

  mov eax, 4    ; write
  mov ebx, [fd]
  mov ecx, text
  mov edx, TEXT_SIZE ; TEXT_SIZE
  int 80h

  mov eax, 6    ; SYS_CLOSE
  mov ebx, [fd]
  int 80h

end_program:
  mov eax, 1
  mov ebx, 0
  int 0x80


