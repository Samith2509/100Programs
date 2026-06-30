// For each adjacent pair (arr[i], arr[i+1]):
//   Case 1: arr[i]   % arr[i+1] == 0  ->  1
//   Case 2: arr[i+1] % arr[i]   == 0  ->  2
//   Case 3: neither                   ->  0
//
// Build: g++ -O2 -o divisibility_check divisibility_check.cpp
// Run:   ./divisibility_check

#include <iostream>
#include <vector>

int main() {
    int n;
    std::cout << "Enter number of elements: ";
    std::cin >> n;

    std::vector<int> arr(n);
    std::cout << "Enter elements: ";
    for (int i = 0; i < n; i++) std::cin >> arr[i];

    std::cout << "Output: [";
    for (int i = 0; i < n - 1; i++) {
        if (i > 0) std::cout << ", ";
        int a = arr[i], b = arr[i + 1];
        int result;
        if      (b != 0 && a % b == 0) result = 1;
        else if (a != 0 && b % a == 0) result = 2;
        else                            result = 0;
        std::cout << result;
    }
    std::cout << "]\n";
    return 0;
}
