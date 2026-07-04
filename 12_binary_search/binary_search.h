// Core logic for binary search, factored out so it can be unit tested.
#ifndef BINARY_SEARCH_H
#define BINARY_SEARCH_H

// Returns the index of `target` in the sorted (ascending) array `arr` of
// length `n`, or -1 if it is not present.
inline int binary_search(const int* arr, int n, int target) {
    int lo = 0, hi = n - 1;
    while (lo <= hi) {
        int mid = (lo + hi) / 2;
        if (arr[mid] == target) return mid;
        else if (arr[mid] < target) lo = mid + 1;
        else hi = mid - 1;
    }
    return -1;
}

#endif  // BINARY_SEARCH_H
