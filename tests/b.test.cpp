#include <iostream>


#include "../lib/doctest/doctest.h"
#include "../include/calc.h"

int factorial(int number) { return number <= 1 ? number : factorial(number - 1) * number; }

TEST_CASE("Another test file") {
    CHECK(factorial(1) == 1);
    CHECK(sum_ints(3, 4) == 7);

    CHECK("essa string" != "dessa outr string");
}