// Compilar códgio 32 bits em arquitetura 64 bits:
// https://stackoverflow.com/questions/22355436/how-to-compile-32-bit-apps-on-64-bit-ubuntu

#include <stdio.h>

extern int testl(int, int, int);

int main() {
  int x = 25, y = 70;
  int result;

  result = testl(x, y, 5);

  printf("result = %d\n", result);

  return 0;
}