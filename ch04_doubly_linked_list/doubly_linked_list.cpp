// doubly_linked_list.cpp
// Purpose: Build a doubly linked list from user-supplied values and traverse
//          it in BOTH directions, proving the prev/next links are wired up
//          correctly.
//
// A doubly linked list node stores a value plus two pointers:
//   * prev -> the node before it
//   * next -> the node after it
// Because every node knows its predecessor, the list can be walked forward
// from the head or backward from the tail.
//
// Build: g++ -O2 -o doubly_linked_list doubly_linked_list.cpp
// Run:   ./doubly_linked_list

#include <iostream>

struct Node {
    int val;
    Node* prev;
    Node* next;
};

// Append `val` to the end of the list, keeping the tail pointer current.
static void push_back(Node*& head, Node*& tail, int val) {
    Node* node = new Node{val, tail, nullptr};
    if (!head) head = node;   // first node becomes the head
    else tail->next = node;   // link the previous tail to the new node
    tail = node;              // the new node is now the tail
}

int main() {
    int n;
    std::cout << "How many values? ";
    std::cin >> n;
    if (n < 0) n = 0;

    Node* head = nullptr;
    Node* tail = nullptr;
    std::cout << "Enter values: ";
    for (int i = 0; i < n; ++i) {
        int v;
        std::cin >> v;
        push_back(head, tail, v);
    }

    // Forward traversal follows `next` starting at the head.
    std::cout << "Forward :";
    for (Node* cur = head; cur; cur = cur->next) std::cout << ' ' << cur->val;
    std::cout << '\n';

    // Backward traversal follows `prev` starting at the tail.
    std::cout << "Backward:";
    for (Node* cur = tail; cur; cur = cur->prev) std::cout << ' ' << cur->val;
    std::cout << '\n';

    // Release every node.
    for (Node* cur = head; cur;) {
        Node* nx = cur->next;
        delete cur;
        cur = nx;
    }
    return 0;
}
