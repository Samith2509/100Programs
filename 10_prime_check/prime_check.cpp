// Check whether a number entered by the user is prime.
// Example: 7 -> prime, 8 -> not prime
//
// Build: g++ -O2 -o prime_check prime_check.cpp
// Run:   ./prime_check

#include <iostream>

int main() {
    int n;
    std::cout << "Enter a number: ";
    std::cin >> n;

    bool prime = n >= 2;
    for (int i = 2; i * i <= n && prime; i++) {
        if (n % i == 0) prime = false;
    }

    std::cout << n << " is " << (prime ? "prime" : "not prime") << '\n';
    return 0;
}
