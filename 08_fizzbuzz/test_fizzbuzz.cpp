// Unit tests for fizzbuzz().
#include "fizzbuzz.h"

#include "../test_common/test_framework.h"

TEST(plain_number) {
    CHECK_EQ(fizzbuzz(1), std::string("1"));
    CHECK_EQ(fizzbuzz(2), std::string("2"));
}

TEST(multiples_of_three_are_fizz) {
    CHECK_EQ(fizzbuzz(3), std::string("Fizz"));
    CHECK_EQ(fizzbuzz(9), std::string("Fizz"));
}

TEST(multiples_of_five_are_buzz) {
    CHECK_EQ(fizzbuzz(5), std::string("Buzz"));
    CHECK_EQ(fizzbuzz(20), std::string("Buzz"));
}

TEST(multiples_of_fifteen_are_fizzbuzz) {
    CHECK_EQ(fizzbuzz(15), std::string("FizzBuzz"));
    CHECK_EQ(fizzbuzz(30), std::string("FizzBuzz"));
}

TEST(fizz_takes_priority_check_45) {
    CHECK_EQ(fizzbuzz(45), std::string("FizzBuzz"));  // 45 = 3*5*3
}

RUN_ALL_TESTS_MAIN()
