#include "../lib/doctest/doctest.h"
#include "../include/calc.h"

int factorial_a(int number) { return number <= 1 ? number : factorial_a(number - 1) * number; }

TEST_CASE("testing the factorial function") {
    CHECK(factorial_a(1) == 1);
    CHECK(sum_ints(1, 2) == 3);
}