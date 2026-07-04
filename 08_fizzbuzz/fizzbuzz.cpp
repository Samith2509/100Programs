// FizzBuzz from 1 to N.
// Multiples of 3 -> "Fizz", multiples of 5 -> "Buzz", both -> "FizzBuzz"
//
// Build: g++ -O2 -o fizzbuzz fizzbuzz.cpp
// Run:   ./fizzbuzz

#include <iostream>

#include "fizzbuzz.h"

int main() {
    int n;
    std::cout << "Enter N: ";
    std::cin >> n;

    for (int i = 1; i <= n; i++) {
        std::cout << fizzbuzz(i) << '\n';
    }
    return 0;
}
