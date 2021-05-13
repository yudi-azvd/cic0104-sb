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
  n: db chars_length            ; qtd de char a serem lidos do arquivo
  x: times chars_length db 0    ; vetor com chars_length de comprimento
  ; x: times 50 db 0    ; vetor com chars_length de comprimento
  ; x:  db 0    ; vetor com chars_length de comprimento

; Para dados não inicicializados
section .bss
  in_fd: resd 1
  out_fd: resd 1
  buffer: resb 10


section .text
  global _start

_start:
open_in_file:
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

; print_x:
;   mov eax, 4
;   mov ebx, 1
;   mov ecx, x
;   mov edx, chars_length
;   int 80h
;   call print_newline


; print_charslen:
;   mov eax, chars_length
;   add eax, '0'
;   mov byte [buffer], al
;   mov eax, 4
;   mov ebx, 1
;   mov ecx, buffer
;   mov edx, 1
;   int 80h
;   call print_newline


close_in_file:
  mov eax, 6    ; SYS_CLOSE
  mov ebx, [in_fd]
  int 80h

do_sum:
  xor ecx, ecx
  mov cl, chars_length ; contador/iterador
  mov ebx, x      ; esi = x
  ; xor eax, eax    ; zerar eax para ser o acumulador
  mov eax, 0
repeat:
  add al, byte [ebx]  ; eax += esi[]
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

print_sum:
  mov eax, 4
  mov ebx, 1
  mov ecx, buffer
  mov edx, 10
  int 80h
  call print_newline

; Converter eax para string e imprimir


;   mov eax, [chars]
;   mov [esi], eax
;   inc esi
;   ; volta pra read chars enquanto não terminou


open_out_file:
  mov eax, 8            ; criar/abrir arquivo
  mov ebx, outFilename  ;
  mov ecx, 07770o        ; todos rwx
  ; mov ecx, 07000o        ; apenas dono tem rxw, para a prova
  mov [out_fd], eax     ; guardar file descriptor
  int 80h
; ; do_sum:
; ; int_to_str:
; write_to_file:
;   mov eax, 4            ; escrever em arquivo
;   mov ebx, [out_fd]
;   mov ecx, chars
;   mov edx, 1            ; escreve 1 byte, que tá em chars
;   int 80h

close_out_file:
  mov eax, 6    ; SYS_CLOSE
  mov ebx, [out_fd]
  int 80h

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


