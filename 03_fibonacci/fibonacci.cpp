// Print the first N terms of the Fibonacci sequence.
//
// Build: g++ -O2 -o fibonacci fibonacci.cpp
// Run:   ./fibonacci

#include <iostream>

int main() {
    int n;
    std::cout << "Enter number of terms: ";
    std::cin >> n;

    long long a = 0, b = 1;
    std::cout << "Fibonacci: ";
    for (int i = 0; i < n; i++) {
        if (i > 0) std::cout << ' ';
        std::cout << a;
        long long c = a + b;
        a = b;
        b = c;
    }
    std::cout << '\n';
    return 0;
}
