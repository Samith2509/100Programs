// Find the maximum value in an array entered by the user.
//
// Build: g++ -O2 -o max_in_array max_in_array.cpp
// Run:   ./max_in_array

#include <iostream>

int main() {
    int n;
    std::cout << "Enter number of elements: ";
    std::cin >> n;

    std::cout << "Enter elements: ";
    int max, x;
    std::cin >> max;
    for (int i = 1; i < n; i++) {
        std::cin >> x;
        if (x > max) max = x;
    }

    std::cout << "Maximum: " << max << '\n';
    return 0;
}
