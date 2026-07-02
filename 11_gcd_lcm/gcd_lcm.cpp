// Compute the GCD and LCM of two numbers entered by the user.
// Example: 12, 18 -> GCD: 6, LCM: 36
//
// Build: g++ -O2 -o gcd_lcm gcd_lcm.cpp
// Run:   ./gcd_lcm

#include <iostream>

int main() {
    int a, b;
    std::cout << "Enter two numbers: ";
    std::cin >> a >> b;

    int x = a, y = b;
    while (y != 0) {
        int t = y;
        y = x % y;
        x = t;
    }
    int gcd = x;
    int lcm = (gcd != 0) ? (a / gcd) * b : 0;

    std::cout << "GCD: " << gcd << '\n';
    std::cout << "LCM: " << lcm << '\n';
    return 0;
}
