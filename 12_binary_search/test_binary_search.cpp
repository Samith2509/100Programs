// Unit tests for binary_search().
// Build & run: g++ -std=c++17 -O2 -o test_binary_search test_binary_search.cpp && ./test_binary_search
#include "binary_search.h"

#include "../test_common/test_framework.h"

TEST(finds_first_element) {
    int a[] = {1, 3, 5, 7, 9};
    CHECK_EQ(binary_search(a, 5, 1), 0);
}

TEST(finds_last_element) {
    int a[] = {1, 3, 5, 7, 9};
    CHECK_EQ(binary_search(a, 5, 9), 4);
}

TEST(finds_middle_element) {
    int a[] = {1, 3, 5, 7, 9};
    CHECK_EQ(binary_search(a, 5, 5), 2);
}

TEST(target_absent_returns_minus_one) {
    int a[] = {1, 3, 5, 7, 9};
    CHECK_EQ(binary_search(a, 5, 4), -1);
}

TEST(target_below_range) {
    int a[] = {10, 20, 30};
    CHECK_EQ(binary_search(a, 3, 5), -1);
}

TEST(target_above_range) {
    int a[] = {10, 20, 30};
    CHECK_EQ(binary_search(a, 3, 99), -1);
}

TEST(single_element_hit) {
    int a[] = {42};
    CHECK_EQ(binary_search(a, 1, 42), 0);
}

TEST(single_element_miss) {
    int a[] = {42};
    CHECK_EQ(binary_search(a, 1, 7), -1);
}

TEST(empty_array_returns_minus_one) {
    int a[] = {0};  // contents irrelevant; n = 0 means empty
    CHECK_EQ(binary_search(a, 0, 1), -1);
}

TEST(even_length_array) {
    int a[] = {2, 4, 6, 8};
    CHECK_EQ(binary_search(a, 4, 8), 3);
    CHECK_EQ(binary_search(a, 4, 2), 0);
}

TEST(handles_negative_values) {
    int a[] = {-9, -4, 0, 3, 11};
    CHECK_EQ(binary_search(a, 5, -4), 1);
    CHECK_EQ(binary_search(a, 5, 0), 2);
}

RUN_ALL_TESTS_MAIN()
