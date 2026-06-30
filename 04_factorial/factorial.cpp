// Compute N! (factorial). Accurate up to N = 20 with long long.
//
// Build: g++ -O2 -o factorial factorial.cpp
// Run:   ./factorial

#include <iostream>

int main() {
    int n;
    std::cout << "Enter n (0-20): ";
    std::cin >> n;

    long long result = 1;
    for (int i = 2; i <= n; i++) result *= i;

    std::cout << n << "! = " << result << '\n';
    return 0;
}
