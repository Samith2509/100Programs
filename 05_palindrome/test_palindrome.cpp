// Unit tests for isPalindrome().
#include "palindrome.h"

#include "../test_common/test_framework.h"

TEST(simple_palindrome) {
    CHECK(isPalindrome("racecar"));
}

TEST(not_a_palindrome) {
    CHECK(!isPalindrome("hello"));
}

TEST(single_char_is_palindrome) {
    CHECK(isPalindrome("a"));
}

TEST(empty_string_is_palindrome) {
    CHECK(isPalindrome(""));
}

TEST(even_length_palindrome) {
    CHECK(isPalindrome("abba"));
}

TEST(case_sensitive) {
    CHECK(!isPalindrome("Racecar"));  // capital R != lowercase r
}

TEST(numeric_string_palindrome) {
    CHECK(isPalindrome("12321"));
    CHECK(!isPalindrome("12345"));
}

RUN_ALL_TESTS_MAIN()
