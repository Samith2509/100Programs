// Unit tests for fibonacci().
#include "fibonacci.h"

#include "../test_common/test_framework.h"

TEST(zero_terms_is_empty) {
    CHECK_EQ(fibonacci(0), std::vector<long long>({}));
}

TEST(one_term) {
    CHECK_EQ(fibonacci(1), std::vector<long long>({0}));
}

TEST(two_terms) {
    CHECK_EQ(fibonacci(2), std::vector<long long>({0, 1}));
}

TEST(first_ten_terms) {
    CHECK_EQ(fibonacci(10),
             std::vector<long long>({0, 1, 1, 2, 3, 5, 8, 13, 21, 34}));
}

TEST(negative_count_is_empty) {
    CHECK_EQ(fibonacci(-3), std::vector<long long>({}));
}

TEST(large_term_uses_long_long) {
    std::vector<long long> f = fibonacci(50);
    CHECK_EQ(f.back(), 7778742049LL);  // 50th term (0-indexed 49)
}

RUN_ALL_TESTS_MAIN()
