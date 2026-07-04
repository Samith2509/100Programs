// Core logic for factorial, factored out for unit testing.
#ifndef FACTORIAL_H
#define FACTORIAL_H

// Returns n! (accurate up to n = 20 with long long). n <= 1 returns 1.
inline long long factorial(int n) {
    long long result = 1;
    for (int i = 2; i <= n; i++) result *= i;
    return result;
}

#endif  // FACTORIAL_H
