section .data
  v1 dw "333", 0xa  
  V1_SIZE equ $-v1

section .bss
  buffer: resb 10

section .text
  global _start

_start:
  call add_one
  call show_value

end_program:
  mov eax, 1
  mov ebx, 0
  int 0x80

add_one:
  lea esi, [v1]
  mov ecx, 3
  call stoi
  add eax, 1
  ret

show_value:
  lea esi, [buffer]
  call itos
  mov eax, 4
  mov ebx, 1
  mov ecx, buffer
  mov edx, 10
  int 0x80
  ret

; Converte de string para inteiro.
; Entradas: ESI: ponteiro para string; EXC: qtd de digitos da string
; Saída: EAX com o valor
stoi:
  xor ebx, ebx;
.next_char:
  movzx eax, byte[esi]
  inc esi
  sub al, '0'
  imul ebx, 10
  add ebx, eax
  loop .next_char
  mov eax, ebx
  ret

; Converte de inteiro para string.
; Entradas:EAX com o valor; ESI: ponteiro para string
; Saída: EAX com o valor
itos:
  add esi, 9
  mov byte [esi], 0
  mov ebx, 10
.next_digit:
  xor edx, edx
  div ebx
  add dl, '0'
  dec esi
  mov [esi], dl
  test eax, eax
  jnz .next_digit ; eax == 0
  mov eax, esi
  ret