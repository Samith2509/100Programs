// Unit tests for gcd() and lcm().
// Build & run: g++ -std=c++17 -O2 -o test_lcm test_lcm.cpp && ./test_lcm
#include "lcm.h"

#include "../test_common/test_framework.h"

TEST(gcd_basic) {
    CHECK_EQ(gcd(12, 18), 6);
    CHECK_EQ(gcd(18, 12), 6);
}

TEST(gcd_coprime) {
    CHECK_EQ(gcd(7, 13), 1);
}

TEST(gcd_with_zero) {
    CHECK_EQ(gcd(5, 0), 5);
    CHECK_EQ(gcd(0, 5), 5);
}

TEST(gcd_equal_values) {
    CHECK_EQ(gcd(9, 9), 9);
}

TEST(lcm_basic) {
    CHECK_EQ(lcm(12, 18), 36);
}

TEST(lcm_commutative) {
    CHECK_EQ(lcm(4, 6), lcm(6, 4));
    CHECK_EQ(lcm(4, 6), 12);
}

TEST(lcm_coprime_is_product) {
    CHECK_EQ(lcm(7, 5), 35);
}

TEST(lcm_one_is_multiple_of_other) {
    CHECK_EQ(lcm(3, 12), 12);
}

TEST(lcm_with_one) {
    CHECK_EQ(lcm(1, 17), 17);
}

TEST(lcm_of_zero_is_zero) {
    CHECK_EQ(lcm(0, 0), 0);
}

TEST(lcm_equal_values) {
    CHECK_EQ(lcm(8, 8), 8);
}

RUN_ALL_TESTS_MAIN()
