// Core logic for summing an integer's digits, factored out for unit testing.
#ifndef SUM_OF_DIGITS_H
#define SUM_OF_DIGITS_H

// Returns the sum of the decimal digits of `n`. The sign is ignored.
// Example: 1234 -> 10, -56 -> 11, 0 -> 0.
inline int sumOfDigits(int n) {
    if (n < 0) n = -n;
    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }
    return sum;
}

#endif  // SUM_OF_DIGITS_H
