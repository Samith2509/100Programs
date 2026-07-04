// Unit tests for divisibilityPattern().
#include "divisibility_check.h"

#include "../test_common/test_framework.h"

TEST(first_divides_second_gives_1) {
    // 6 % 3 == 0 -> 1; then pair (3, 6): 6 % 3 == 0 -> 2
    CHECK_EQ(divisibilityPattern({6, 3}), std::vector<int>({1, 2}));
}

TEST(second_divides_first_gives_2) {
    // pair (3, 6): 3 % 6 != 0, 6 % 3 == 0 -> 2; pair (6, 3): 6 % 3 == 0 -> 1
    CHECK_EQ(divisibilityPattern({3, 6}), std::vector<int>({2, 1}));
}

TEST(neither_divides_gives_0) {
    // pair (4, 6): 4%6!=0, 6%4!=0 -> 0; pair (6, 4): same -> 0
    CHECK_EQ(divisibilityPattern({4, 6}), std::vector<int>({0, 0}));
}

TEST(wraps_last_to_first) {
    // arr = [2, 5, 4]; pairs: (2,5)->0, (5,4)->0, (4,2)->4%2==0->1
    CHECK_EQ(divisibilityPattern({2, 5, 4}), std::vector<int>({0, 0, 1}));
}

TEST(single_element_pairs_with_itself) {
    // pair (7, 7): 7 % 7 == 0 -> 1
    CHECK_EQ(divisibilityPattern({7}), std::vector<int>({1}));
}

TEST(handles_zero_without_dividing) {
    // pair (0, 3): b=3, 0%3==0 -> 1; pair (3, 0): b=0 skip, a=3 3%... 0%3 -> a!=0 && b%a: 0%3==0 ->2
    CHECK_EQ(divisibilityPattern({0, 3}), std::vector<int>({1, 2}));
}

RUN_ALL_TESTS_MAIN()
