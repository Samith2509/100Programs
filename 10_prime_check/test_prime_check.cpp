// Unit tests for isPrime().
#include "prime_check.h"

#include "../test_common/test_framework.h"

TEST(small_primes) {
    CHECK(isPrime(2));
    CHECK(isPrime(3));
    CHECK(isPrime(5));
    CHECK(isPrime(7));
}

TEST(small_composites) {
    CHECK(!isPrime(4));
    CHECK(!isPrime(8));
    CHECK(!isPrime(9));
}

TEST(zero_and_one_not_prime) {
    CHECK(!isPrime(0));
    CHECK(!isPrime(1));
}

TEST(negatives_not_prime) {
    CHECK(!isPrime(-7));
}

TEST(larger_prime) {
    CHECK(isPrime(97));
    CHECK(isPrime(7919));
}

TEST(larger_composite) {
    CHECK(!isPrime(100));
    CHECK(!isPrime(7917));  // 7917 = 3 * 7 * 13 * 29
}

RUN_ALL_TESTS_MAIN()
