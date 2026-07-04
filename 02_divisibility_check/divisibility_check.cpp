// For each adjacent pair (arr[i], arr[(i+1) % n]), wrapping so the last
// element is paired with the first:
//   Case 1: arr[i]   % arr[i+1] == 0  ->  1
//   Case 2: arr[i+1] % arr[i]   == 0  ->  2
//   Case 3: neither                   ->  0
//
// Build: g++ -O2 -o divisibility_check divisibility_check.cpp
// Run:   ./divisibility_check

#include <iostream>
#include <vector>

#include "divisibility_check.h"

int main() {
    int n;
    std::cout << "Enter number of elements: ";
    std::cin >> n;

    std::vector<int> arr(n);
    std::cout << "Enter elements: ";
    for (int i = 0; i < n; i++) std::cin >> arr[i];

    std::vector<int> out = divisibilityPattern(arr);
    std::cout << "Output: [";
    for (int i = 0; i < n; i++) {
        if (i > 0) std::cout << ", ";
        std::cout << out[i];
    }
    std::cout << "]\n";
    return 0;
}
