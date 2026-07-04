// Core logic for the primality test, factored out for unit testing.
#ifndef PRIME_CHECK_H
#define PRIME_CHECK_H

// Returns true if `n` is prime. Values < 2 are not prime.
inline bool isPrime(int n) {
    bool prime = n >= 2;
    for (int i = 2; i * i <= n && prime; i++) {
        if (n % i == 0) prime = false;
    }
    return prime;
}

#endif  // PRIME_CHECK_H
