#include <stdio.h>

extern int simple_sub(int x, int y);

int main() {
  int resa;
  int x = 100, y = 10; 

  resa = simple_sub(x, y);

  printf(" O resultado de A: %d\n", resa);

  return 0;
}