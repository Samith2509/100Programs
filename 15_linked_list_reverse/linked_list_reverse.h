// Core logic for reversing a singly linked list, factored out for unit testing.
#ifndef LINKED_LIST_REVERSE_H
#define LINKED_LIST_REVERSE_H

struct Node {
    int val;
    Node* next;
};

// Reverses a singly linked list in place and returns the new head.
// Example: 1 -> 2 -> 3   becomes   3 -> 2 -> 1.
inline Node* reverse_list(Node* head) {
    Node* prev = nullptr;
    while (head) {
        Node* next = head->next;
        head->next = prev;
        prev = head;
        head = next;
    }
    return prev;
}

// Builds a linked list from the first `n` values of `vals`. Returns the head
// (nullptr when n == 0). Caller owns the nodes and must free_list() them.
inline Node* build_list(const int* vals, int n) {
    Node* head = nullptr;
    Node* tail = nullptr;
    for (int i = 0; i < n; ++i) {
        Node* node = new Node{vals[i], nullptr};
        if (!head) {
            head = tail = node;
        } else {
            tail->next = node;
            tail = node;
        }
    }
    return head;
}

// Frees every node reachable from `head`.
inline void free_list(Node* head) {
    while (head) {
        Node* next = head->next;
        delete head;
        head = next;
    }
}

#endif  // LINKED_LIST_REVERSE_H
