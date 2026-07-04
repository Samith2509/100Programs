// Print the first N terms of the Fibonacci sequence.
//
// Build: g++ -O2 -o fibonacci fibonacci.cpp
// Run:   ./fibonacci

#include <iostream>

#include "fibonacci.h"

int main() {
    int n;
    std::cout << "Enter number of terms: ";
    std::cin >> n;

    std::vector<long long> terms = fibonacci(n);
    std::cout << "Fibonacci: ";
    for (size_t i = 0; i < terms.size(); i++) {
        if (i > 0) std::cout << ' ';
        std::cout << terms[i];
    }
    std::cout << '\n';
    return 0;
}
