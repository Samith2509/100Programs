// Unit tests for reverse_number().
// Build & run: g++ -std=c++17 -O2 -o test_reverse_number test_reverse_number.cpp && ./test_reverse_number
#include "reverse_number.h"

#include "../test_common/test_framework.h"

TEST(reverses_multi_digit) {
    CHECK_EQ(reverse_number(1234), 4321);
}

TEST(reverses_negative) {
    CHECK_EQ(reverse_number(-57), -75);
}

TEST(single_digit_unchanged) {
    CHECK_EQ(reverse_number(7), 7);
    CHECK_EQ(reverse_number(-7), -7);
}

TEST(zero_stays_zero) {
    CHECK_EQ(reverse_number(0), 0);
}

TEST(trailing_zeros_are_dropped) {
    CHECK_EQ(reverse_number(1200), 21);
    CHECK_EQ(reverse_number(100), 1);
}

TEST(palindromic_number) {
    CHECK_EQ(reverse_number(1221), 1221);
}

TEST(reverse_twice_is_identity_for_no_trailing_zero) {
    CHECK_EQ(reverse_number(reverse_number(3891)), 3891);
}

TEST(larger_value) {
    CHECK_EQ(reverse_number(900000), 9);
    CHECK_EQ(reverse_number(123456), 654321);
}

RUN_ALL_TESTS_MAIN()
