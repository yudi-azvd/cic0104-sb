; Esse procedimento recebe 3 inteiros pela
; pilha. Soma os dois primeiros e subtrai o
; terceiro. É chamado de um programa em C
; testl.c

segment .text

global testl

testl:
  enter 0, 0
  mov eax, [ebp+8]    ; pega o 1o argumento
  add eax, [ebp+12]   ; soma c o 2o argumento
  sub eax, [ebp+16]   ; subtrai o 3o argumento
  leave
  ret
