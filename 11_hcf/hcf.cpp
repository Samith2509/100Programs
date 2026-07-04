// Compute the HCF (GCD) of two numbers entered by the user.
// Example: 12, 18 -> HCF: 6
//
// Build: g++ -O2 -o hcf hcf.cpp
// Run:   ./hcf

#include <iostream>

#include "hcf.h"

int main() {
    int a, b;
    std::cout << "Enter two numbers: ";
    std::cin >> a >> b;

    std::cout << "HCF: " << hcf(a, b) << '\n';
    return 0;
}
