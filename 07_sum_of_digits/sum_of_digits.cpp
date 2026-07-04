// Sum of digits of an integer entered by the user.
// Example: 1234 -> 10
//
// Build: g++ -O2 -o sum_of_digits sum_of_digits.cpp
// Run:   ./sum_of_digits

#include <iostream>

#include "sum_of_digits.h"

int main() {
    int n;
    std::cout << "Enter a number: ";
    std::cin >> n;

    std::cout << "Sum of digits: " << sumOfDigits(n) << '\n';
    return 0;
}
