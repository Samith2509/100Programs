// Unit tests for maxInArray().
#include "max_in_array.h"

#include "../test_common/test_framework.h"

TEST(max_at_end) {
    int a[] = {1, 2, 3, 9};
    CHECK_EQ(maxInArray(a, 4), 9);
}

TEST(max_at_start) {
    int a[] = {9, 2, 3, 1};
    CHECK_EQ(maxInArray(a, 4), 9);
}

TEST(max_in_middle) {
    int a[] = {1, 8, 3};
    CHECK_EQ(maxInArray(a, 3), 8);
}

TEST(single_element) {
    int a[] = {42};
    CHECK_EQ(maxInArray(a, 1), 42);
}

TEST(all_negative) {
    int a[] = {-5, -2, -9};
    CHECK_EQ(maxInArray(a, 3), -2);
}

TEST(duplicates) {
    int a[] = {7, 7, 7};
    CHECK_EQ(maxInArray(a, 3), 7);
}

TEST(mixed_sign) {
    int a[] = {-3, 0, 4, -10};
    CHECK_EQ(maxInArray(a, 4), 4);
}

RUN_ALL_TESTS_MAIN()
