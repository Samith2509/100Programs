// Core logic for GCD/LCM, factored out so it can be unit tested.
#ifndef LCM_H
#define LCM_H

// Greatest common divisor via the Euclidean algorithm.
inline int gcd(int a, int b) {
    while (b != 0) {
        int t = b;
        b = a % b;
        a = t;
    }
    return a;
}

// Least common multiple. Returns 0 when the gcd is 0 (i.e. both inputs 0).
inline int lcm(int a, int b) {
    int g = gcd(a, b);
    return g != 0 ? (a / g) * b : 0;
}

#endif  // LCM_H
