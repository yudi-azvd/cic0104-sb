#include <iostream>


#include "../lib/doctest/doctest.h"
#include "../include/calc.h"

int factorial(int number) { return number <= 1 ? number : factorial(number - 1) * number; }

TEST_CASE("Another test file") {
    // std::cout << "olha só" << std::endl;
    CHECK(factorial(1) == 1);
    CHECK(sum_ints(1, 1) == 2);

    // std::cout << "Hello wwworld" << std::endl;

    CHECK("essa string" != "dessa outr string");
}