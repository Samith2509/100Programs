// Core logic for HCF (GCD), factored out for unit testing.
#ifndef HCF_H
#define HCF_H

// Greatest common divisor (highest common factor) via the Euclidean algorithm.
inline int hcf(int a, int b) {
    int x = a, y = b;
    while (y != 0) {
        int t = y;
        y = x % y;
        x = t;
    }
    return x;
}

#endif  // HCF_H
