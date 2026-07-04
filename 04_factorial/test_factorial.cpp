// Unit tests for factorial().
#include "factorial.h"

#include "../test_common/test_framework.h"

TEST(factorial_of_zero_is_one) {
    CHECK_EQ(factorial(0), 1LL);
}

TEST(factorial_of_one_is_one) {
    CHECK_EQ(factorial(1), 1LL);
}

TEST(small_values) {
    CHECK_EQ(factorial(5), 120LL);
    CHECK_EQ(factorial(6), 720LL);
}

TEST(factorial_of_ten) {
    CHECK_EQ(factorial(10), 3628800LL);
}

TEST(factorial_of_twenty_fits_long_long) {
    CHECK_EQ(factorial(20), 2432902008176640000LL);
}

RUN_ALL_TESTS_MAIN()
