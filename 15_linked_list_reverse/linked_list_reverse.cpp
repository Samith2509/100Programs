// Reverse a singly linked list built from values entered by the user.
// Example: 1 2 3 4 5  ->  5 4 3 2 1
//
// Build: g++ -O2 -o linked_list_reverse linked_list_reverse.cpp
// Run:   ./linked_list_reverse

#include <iostream>

#include "linked_list_reverse.h"

int main() {
    int n;
    std::cout << "How many values? ";
    std::cin >> n;
    if (n < 0) n = 0;

    int* vals = new int[n];
    std::cout << "Enter values: ";
    for (int i = 0; i < n; ++i) std::cin >> vals[i];

    Node* head = build_list(vals, n);
    delete[] vals;
    head = reverse_list(head);

    std::cout << "Reversed list:";
    for (Node* cur = head; cur; cur = cur->next) std::cout << ' ' << cur->val;
    std::cout << '\n';

    free_list(head);
    return 0;
}
