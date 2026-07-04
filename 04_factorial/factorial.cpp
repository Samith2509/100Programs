// Compute N! (factorial). Accurate up to N = 20 with long long.
//
// Build: g++ -O2 -o factorial factorial.cpp
// Run:   ./factorial

#include <iostream>

#include "factorial.h"

int main() {
    int n;
    std::cout << "Enter n (0-20): ";
    std::cin >> n;

    std::cout << n << "! = " << factorial(n) << '\n';
    return 0;
}
