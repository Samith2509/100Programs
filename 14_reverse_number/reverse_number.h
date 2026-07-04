// Core logic for reversing an integer's digits, factored out for unit testing.
#ifndef REVERSE_NUMBER_H
#define REVERSE_NUMBER_H

// Reverses the decimal digits of `n`. Negative numbers keep their sign.
// Example: 1234 -> 4321, -57 -> -75, 0 -> 0.
inline int reverse_number(int n) {
    bool neg = n < 0;
    if (neg) n = -n;

    int rev = 0;
    while (n > 0) {
        rev = rev * 10 + n % 10;
        n /= 10;
    }
    return neg ? -rev : rev;
}

#endif  // REVERSE_NUMBER_H
