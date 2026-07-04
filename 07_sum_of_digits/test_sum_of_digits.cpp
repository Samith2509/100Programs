// Unit tests for sumOfDigits().
#include "sum_of_digits.h"

#include "../test_common/test_framework.h"

TEST(basic) {
    CHECK_EQ(sumOfDigits(1234), 10);
}

TEST(single_digit) {
    CHECK_EQ(sumOfDigits(7), 7);
}

TEST(zero) {
    CHECK_EQ(sumOfDigits(0), 0);
}

TEST(negative_ignores_sign) {
    CHECK_EQ(sumOfDigits(-56), 11);
}

TEST(trailing_zeros) {
    CHECK_EQ(sumOfDigits(1000), 1);
}

TEST(all_nines) {
    CHECK_EQ(sumOfDigits(9999), 36);
}

RUN_ALL_TESTS_MAIN()
