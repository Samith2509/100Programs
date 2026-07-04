// Compute the LCM of two numbers entered by the user.
// Uses the Euclidean algorithm for the GCD, then LCM = a / gcd * b.
// Example: 12, 18 -> LCM: 36
//
// Build: g++ -O2 -o lcm lcm.cpp
// Run:   ./lcm

#include <iostream>

#include "lcm.h"

int main() {
    int a, b;
    std::cout << "Enter two numbers: ";
    std::cin >> a >> b;

    std::cout << "LCM: " << lcm(a, b) << '\n';
    return 0;
}
