// Unit tests for hcf().
#include "hcf.h"

#include "../test_common/test_framework.h"

TEST(basic) {
    CHECK_EQ(hcf(12, 18), 6);
}

TEST(commutative) {
    CHECK_EQ(hcf(18, 12), 6);
}

TEST(coprime_is_one) {
    CHECK_EQ(hcf(7, 13), 1);
}

TEST(one_divides_other) {
    CHECK_EQ(hcf(4, 12), 4);
}

TEST(with_zero) {
    CHECK_EQ(hcf(5, 0), 5);
    CHECK_EQ(hcf(0, 5), 5);
}

TEST(equal_values) {
    CHECK_EQ(hcf(9, 9), 9);
}

RUN_ALL_TESTS_MAIN()
