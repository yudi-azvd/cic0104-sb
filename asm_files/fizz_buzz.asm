;; olhar o arquivo ./fizz-buzz-fluxogram.jpeg para referência.

mod_a: begin
extern: is_divisible_by_3
extern: is_divisible_by_5
public one
public zero
public ret_div_by_3
public ret_div_by_5

load counter
add one
store counter ; counter = 1

loop: load counter  ; acc = counter
      sub i_100     ; acc = acc - 100 // acc < 0 na maior parte das vezes
      jmpp finish   ; acc > 0 acabou o programa

      load counter
      jmp is_divisible_by_3 ; acc % 3 == 0 ? acc = 1 : acc = 0
      jmpz call_div_5
      output fizz
      jmp is_divisible_by_3_and_5
call_div_5: 
      load counter
      jmp is_divisible_by_5 ; acc % 5 == 0 ? acc = 1 : acc = 0
      jmpz print_counter
      output buzz
      jmp _L1
is_divisible_by_3_and_5: 
      jmp is_divisible_by_5 ; acc % 5 == 0 ? acc = 1 : acc = 0
      jmpz _L1
      output buzz
      jmp _L1
print_counter:
      output counter

_L1:  output newline
      load counter
      add one
      store counter ; counter++
      jmp loop
finish: stop

i_100: const 100
one: const 1
zero: const 0
counter: space
fizz: "fizz"
buzz: "buzz"
fizzbuzz: "fizzbuzz"
newline: "\n"
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mod_b: begin
extern: one
extern: zero
extern: ret_div_by_3
public is_divisible_by_3
; assumindo que o numero de interesse ja esta em ACC
is_divisible_by_3: 
  sub three
  jmpp is_divisible_by_3
  jmpn not_divisible_by_3
  jmpz is_divisible_by_3
not_divisible_by_3: 
  load zero
  jmp ret_div_by_3
is_divisible_by_3: 
  load one
  jmp ret_div_by_3

three: const 3
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mod_c: begin
extern: one
extern: zero
extern: ret_div_by_5
public is_divisible_by_5
; assumindo que o numero de interesse ja esta em ACC
is_divisible_by_5: 
  sub five
  jmpp is_divisible_by_5
  jmpn not_divisible_by_5
  jmpz is_divisible_by_5
not_divisible_by_5: 
  load zero
  jmp ret_div_by_5
is_divisible_by_5: 
  load one
  jmp ret_div_by_5
five: const 5
end