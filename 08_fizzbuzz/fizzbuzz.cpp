// FizzBuzz from 1 to N.
// Multiples of 3 -> "Fizz", multiples of 5 -> "Buzz", both -> "FizzBuzz"
//
// Build: g++ -O2 -o fizzbuzz fizzbuzz.cpp
// Run:   ./fizzbuzz

#include <iostream>

int main() {
    int n;
    std::cout << "Enter N: ";
    std::cin >> n;

    for (int i = 1; i <= n; i++) {
        if      (i % 15 == 0) std::cout << "FizzBuzz\n";
        else if (i % 3  == 0) std::cout << "Fizz\n";
        else if (i % 5  == 0) std::cout << "Buzz\n";
        else                  std::cout << i << '\n';
    }
    return 0;
}
