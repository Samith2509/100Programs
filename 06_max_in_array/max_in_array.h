// Core logic for finding the maximum of an array, factored out for testing.
#ifndef MAX_IN_ARRAY_H
#define MAX_IN_ARRAY_H

// Returns the maximum of the first `n` elements of `arr`.
// Assumes n >= 1 (matches the program, which reads at least one element).
inline int maxInArray(const int* arr, int n) {
    int max = arr[0];
    for (int i = 1; i < n; i++) {
        if (arr[i] > max) max = arr[i];
    }
    return max;
}

#endif  // MAX_IN_ARRAY_H
