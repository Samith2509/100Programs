// Sum of digits of an integer entered by the user.
// Example: 1234 -> 10
//
// Build: g++ -O2 -o sum_of_digits sum_of_digits.cpp
// Run:   ./sum_of_digits

#include <iostream>

int main() {
    int n;
    std::cout << "Enter a number: ";
    std::cin >> n;

    if (n < 0) n = -n;

    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }

    std::cout << "Sum of digits: " << sum << '\n';
    return 0;
}
