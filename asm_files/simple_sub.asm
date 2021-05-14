segment .text

global simple_sub

; simple_sub(int a, int b)
; ------
; |  a
; ------
; |  b

simple_sub:
  enter 0, 0
  mov eax, [ebp+8]
  sub eax, [ebp+12]
  leave
  ret