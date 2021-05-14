; Ainda não funciona

section .data
  sum: dw 0

segment .text
global f4
f4:
  enter 0, 0
  mov ecx, [ebp+16]     ; int n 
  mov esi, [ebp+12]     ; short* y 
  mov edi, [ebp+8]      ; short* x
  xor edx, edx
  push ebx
  xor ebx, ebx
.repeat:
  mov bx, word [edi] ; copiar com extensão de sinal
  mov ax, word [esi] ; copiar com extensão de sinal
  ; imul  bx, word [esi]
  imul bx, ax
  add [sum], eax
  add edi, 2
  add esi, 2
  loop .repeat
  mov eax, [sum]    ; retorno em eax
  ; movsx eax, word [sum]    ; retorno em eax
  pop ebx
  leave
  ret