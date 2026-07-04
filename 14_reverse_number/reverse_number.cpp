// Reverse the digits of an integer entered by the user.
// Negative numbers keep their sign. Example: 1234 -> 4321, -57 -> -75
//
// Build: g++ -O2 -o reverse_number reverse_number.cpp
// Run:   ./reverse_number

#include <iostream>

#include "reverse_number.h"

int main() {
    int n;
    std::cout << "Enter a number: ";
    std::cin >> n;

    std::cout << "Reversed: " << reverse_number(n) << '\n';
    return 0;
}
