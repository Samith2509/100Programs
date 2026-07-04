// Core logic for the adjacent-pair divisibility pattern, factored out for testing.
#ifndef DIVISIBILITY_CHECK_H
#define DIVISIBILITY_CHECK_H

#include <vector>

// For each element paired with its successor (wrapping the last to the first):
//   1 -> arr[i]   % arr[i+1] == 0
//   2 -> arr[i+1] % arr[i]   == 0
//   0 -> neither
inline std::vector<int> divisibilityPattern(const std::vector<int>& arr) {
    int n = static_cast<int>(arr.size());
    std::vector<int> out(n);
    for (int i = 0; i < n; i++) {
        int a = arr[i], b = arr[(i + 1) % n];
        if      (b != 0 && a % b == 0) out[i] = 1;
        else if (a != 0 && b % a == 0) out[i] = 2;
        else                           out[i] = 0;
    }
    return out;
}

#endif  // DIVISIBILITY_CHECK_H
