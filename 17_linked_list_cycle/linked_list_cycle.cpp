// Detect whether a singly linked list contains a cycle (Floyd's algorithm).
// Build a list from user values, then optionally join the tail back to an
// earlier node to create a loop.
//
// Build: g++ -O2 -o linked_list_cycle linked_list_cycle.cpp
// Run:   ./linked_list_cycle

#include <iostream>
#include <vector>

#include "linked_list_cycle.h"

int main() {
    int n;
    std::cout << "How many values? ";
    std::cin >> n;
    if (n < 0) n = 0;

    std::vector<int> vals(n);
    std::cout << "Enter values: ";
    for (int i = 0; i < n; ++i) std::cin >> vals[i];

    int pos;
    std::cout << "Index to loop the tail back to (-1 for none): ";
    std::cin >> pos;

    Node* head = build_list(vals.data(), n);

    // Join the tail to node[pos] to form a cycle, if requested.
    if (head && pos >= 0 && pos < n) {
        Node* tail = node_at(head, n - 1);
        tail->next = node_at(head, pos);
    }

    if (has_cycle(head)) {
        std::cout << "Cycle detected\n";
    } else {
        std::cout << "No cycle\n";
        free_list(head);  // only safe to free when acyclic
    }
    return 0;
}
