// Unit tests for countVowels().
#include "count_vowels.h"

#include "../test_common/test_framework.h"

TEST(basic_sentence) {
    CHECK_EQ(countVowels("Hello World"), 3);
}

TEST(case_insensitive) {
    CHECK_EQ(countVowels("AEIOU"), 5);
    CHECK_EQ(countVowels("aeiou"), 5);
}

TEST(no_vowels) {
    CHECK_EQ(countVowels("rhythm"), 0);
}

TEST(empty_string) {
    CHECK_EQ(countVowels(""), 0);
}

TEST(digits_and_symbols_ignored) {
    CHECK_EQ(countVowels("a1e2i3!"), 3);
}

TEST(all_vowels_mixed_case) {
    CHECK_EQ(countVowels("EducatiOn"), 5);
}

RUN_ALL_TESTS_MAIN()
