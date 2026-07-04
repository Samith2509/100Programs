// Core logic for generating the Fibonacci sequence, factored out for testing.
#ifndef FIBONACCI_H
#define FIBONACCI_H

#include <vector>

// Returns the first `n` Fibonacci terms starting 0, 1, 1, 2, ...
// n <= 0 yields an empty vector.
inline std::vector<long long> fibonacci(int n) {
    std::vector<long long> out;
    long long a = 0, b = 1;
    for (int i = 0; i < n; i++) {
        out.push_back(a);
        long long c = a + b;
        a = b;
        b = c;
    }
    return out;
}

#endif  // FIBONACCI_H
