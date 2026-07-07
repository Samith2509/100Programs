// dll_insert_begin.cpp
// Purpose: Build a doubly linked list, then insert a brand-new node at the
//          FRONT of the list (before the current head).
//
// Inserting at the beginning is an O(1) operation:
//   1. the new node's `next` points at the old head,
//   2. the old head's `prev` points back at the new node,
//   3. the new node becomes the head.
//
// Build: g++ -O2 -o dll_insert_begin dll_insert_begin.cpp
// Run:   ./dll_insert_begin

#include <iostream>

struct Node {
    int val;
    Node* prev;
    Node* next;
};

static void push_back(Node*& head, Node*& tail, int val) {
    Node* node = new Node{val, tail, nullptr};
    if (!head) head = node;
    else tail->next = node;
    tail = node;
}

// Insert `val` at the front and return the new head.
static Node* push_front(Node* head, int val) {
    Node* node = new Node{val, nullptr, head};
    if (head) head->prev = node;  // old head now points back to the new node
    return node;                  // the new node is the new head
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

    int x;
    std::cout << "Value to insert at front: ";
    std::cin >> x;
    head = push_front(head, x);

    std::cout << "Result :";
    for (Node* cur = head; cur; cur = cur->next) std::cout << ' ' << cur->val;
    std::cout << '\n';

    for (Node* cur = head; cur;) {
        Node* nx = cur->next;
        delete cur;
        cur = nx;
    }
    return 0;
}
