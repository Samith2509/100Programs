// Check whether a number entered by the user is prime.
// Example: 7 -> prime, 8 -> not prime
//
// Build: g++ -O2 -o prime_check prime_check.cpp
// Run:   ./prime_check

#include <iostream>

#include "prime_check.h"

int main() {
    int n;
    std::cout << "Enter a number: ";
    std::cin >> n;

    std::cout << n << " is " << (isPrime(n) ? "prime" : "not prime") << '\n';
    return 0;
}
