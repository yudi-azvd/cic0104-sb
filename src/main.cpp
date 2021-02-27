#include <stdio.h>

#include "../include/calc.h"

int main() {
  int a = 3, b = 5, c=1;

  c = 3*b-a/c;

  c = sum_ints(a, b);

  printf("sum: %d\n", c);

  return 0;
}