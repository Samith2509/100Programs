// Find the maximum value in an array entered by the user.
//
// Build: g++ -O2 -o max_in_array max_in_array.cpp
// Run:   ./max_in_array

#include <iostream>
#include <vector>

#include "max_in_array.h"

int main() {
    int n;
    std::cout << "Enter number of elements: ";
    std::cin >> n;

    std::vector<int> arr(n);
    std::cout << "Enter elements: ";
    for (int i = 0; i < n; i++) std::cin >> arr[i];

    std::cout << "Maximum: " << maxInArray(arr.data(), n) << '\n';
    return 0;
}
