#include <stdio.h>

#include "../include/calc.h"

int main() {
  int a = 3, b = 5, c;

  c = sum_ints(a, b);

  printf("sum: %d\n", c);

  return 0;
}