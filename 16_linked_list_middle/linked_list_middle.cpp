// Find the middle node of a singly linked list built from user input.
// For an even count the second middle is reported. Example: 1 2 3 4 5 -> 3
//
// Build: g++ -O2 -o linked_list_middle linked_list_middle.cpp
// Run:   ./linked_list_middle

#include <iostream>
#include <vector>

#include "linked_list_middle.h"

int main() {
    int n;
    std::cout << "How many values? ";
    std::cin >> n;
    if (n <= 0) {
        std::cout << "List is empty; no middle.\n";
        return 0;
    }

    std::vector<int> vals(n);
    std::cout << "Enter values: ";
    for (int i = 0; i < n; ++i) std::cin >> vals[i];

    Node* head = build_list(vals.data(), n);
    std::cout << "Middle: " << middle_value(head) << '\n';

    free_list(head);
    return 0;
}
