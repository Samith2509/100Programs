// Binary search for a target value in a sorted array entered by the user.
//
// Build: g++ -O2 -o binary_search binary_search.cpp
// Run:   ./binary_search

#include <iostream>

int main() {
    int n;
    std::cout << "Enter number of elements (sorted ascending): ";
    std::cin >> n;

    int arr[100];
    std::cout << "Enter elements: ";
    for (int i = 0; i < n; i++) std::cin >> arr[i];

    int target;
    std::cout << "Enter target: ";
    std::cin >> target;

    int lo = 0, hi = n - 1, idx = -1;
    while (lo <= hi) {
        int mid = (lo + hi) / 2;
        if (arr[mid] == target) { idx = mid; break; }
        else if (arr[mid] < target) lo = mid + 1;
        else hi = mid - 1;
    }

    if (idx != -1) std::cout << "Found at index: " << idx << '\n';
    else std::cout << "Not found\n";
    return 0;
}
