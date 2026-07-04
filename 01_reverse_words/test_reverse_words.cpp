// Unit tests for reverseEachWord().
#include "reverse_words.h"

#include "../test_common/test_framework.h"

TEST(reverses_two_words) {
    CHECK_EQ(reverseEachWord("HEllo world"), std::string("ollEH dlrow"));
}

TEST(single_word) {
    CHECK_EQ(reverseEachWord("abc"), std::string("cba"));
}

TEST(empty_string) {
    CHECK_EQ(reverseEachWord(""), std::string(""));
}

TEST(preserves_multiple_spaces) {
    CHECK_EQ(reverseEachWord("ab  cd"), std::string("ba  dc"));
}

TEST(leading_and_trailing_spaces_preserved) {
    CHECK_EQ(reverseEachWord(" ab "), std::string(" ba "));
}

TEST(single_char_words_unchanged) {
    CHECK_EQ(reverseEachWord("a b c"), std::string("a b c"));
}

TEST(only_spaces) {
    CHECK_EQ(reverseEachWord("   "), std::string("   "));
}

RUN_ALL_TESTS_MAIN()
