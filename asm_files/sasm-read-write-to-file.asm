; read-write-to-file
; Para compilar esse programa em um PC de 64bits:
; nasm -f elf read-write-to-file.asm -o read-write-to-file.o
; ld -m elf_i386 -o read-write-to-file read-write-to-file.o

; Inspiração para leitura/escrita de arquivos
; https://stackoverflow.com/questions/45786253/create-write-to-file-x86-linux

; Inicialização de vetores
; https://stackoverflow.com/questions/43430805/initialize-array-to-specific-values-in-assembly-x86


; Para dados inicicializados
section .data
  inFilename:       db "myfile1.txt", 0
  outFilename:      db "myfile2.txt", 0
  newline:          db 0ah
  NEWLINE_SZ:       equ $-newline

  %assign chars_length 5
  n:            db chars_length            ; qtd de char a serem lidos do arquivo
  x:            times chars_length db 0    ; vetor com chars_length de comprimento
  buffer:       times 10 db 0
  BUFFER_SZ:    equ $-buffer

; Para dados não inicicializados
section .bss
  in_fd: resd 1
  out_fd: resd 1

%include "io.inc"

section .text
global CMAIN

section .text

CMAIN:
    mov ebp, esp; for correct debugging
open_in_file:
  mov eax, BUFFER_SZ
  mov eax, 5            ; abrir arquivo. acho que o arquivo já deve existir
  mov ebx, inFilename   ; nome do arquivo
  mov ecx, 0            ; file permissions: RONLY
  mov edx, 0777o        ; todos têm permissão pra ler, escrever, executar
  int 80h               ; syscall
  mov [in_fd], eax      ; guardar file descriptor


; Ler o arquivo inteiro é melhor
read_chars_into_x:
  mov eax, 3            ; ler arquivo
  mov ebx, [in_fd]
  mov ecx, x
  mov edx, chars_length ; ler apenas chars_length bytes e salvar em chars
  int 80h               ; syscall

close_in_file:
  mov eax, 6    ; SYS_CLOSE
  mov ebx, [in_fd]
  int 80h

do_sum:
  xor ecx, ecx
  mov cl, chars_length ; contador/iterador
  mov ebx, x      ; esi = x
  xor eax, eax    ; zerar eax para ser o acumulador
repeat:
  movzx edx, byte[ebx]
  add eax, edx  ; eax += byte ebx[i]
  inc ebx
  dec ecx
  jnz repeat     ; while (--ecx)

int_to_string:
  lea esi, [buffer] ; buffer tem tamanho 10
  add esi, 9 ; esi aponta para o fim do buffer, len-1
  mov byte [esi], 0
  mov ebx, 10
.prox_digito:
  xor edx, edx
  div ebx
  add dl, '0'
  dec esi
  mov [esi], dl
  test eax, eax
  jnz .prox_digito ; eax == 0
  mov eax, esi
  ; ret


open_out_file:
  mov eax, 8            ; criar/abrir arquivo
  mov ebx, outFilename  ;
  mov ecx, 0666o        ; todos rwx
  ; mov ecx, 07000o        ; apenas dono tem rxw, para a prova
  int 80h
  mov [out_fd], eax     ; guardar file descriptor
write_to_file:
   mov eax, 4            ; escrever em arquivo
   mov ebx, [out_fd]
   mov ecx, buffer
   mov edx, BUFFER_SZ
   int 80h

close_out_file:
  mov eax, 6    ; SYS_CLOSE
  mov ebx, [out_fd]
  int 80h
 
print_BUFFER:
  mov eax, 4
  mov ebx, 1
  mov ecx, buffer
  mov edx, BUFFER_SZ
  int 80h
  call print_newline


end_program:
  mov eax, 1
  mov ebx, 0
  int 0x80

print_newline:
  mov eax, 4
  mov ebx, 1
  mov ecx, newline
  mov edx, NEWLINE_SZ
  int 80h
  ret
