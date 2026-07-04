// Core logic for detecting a cycle in a singly linked list, factored out for
// unit testing. Uses Floyd's tortoise-and-hare algorithm (O(1) extra space).
#ifndef LINKED_LIST_CYCLE_H
#define LINKED_LIST_CYCLE_H

struct Node {
    int val;
    Node* next;
};

// Returns true when the list reachable from `head` contains a cycle.
inline bool has_cycle(Node* head) {
    Node* slow = head;
    Node* fast = head;
    while (fast && fast->next) {
        slow = slow->next;
        fast = fast->next->next;
        if (slow == fast) return true;
    }
    return false;
}

// Builds an acyclic linked list from the first `n` values of `vals`. Returns the
// head (nullptr when n == 0). Caller owns the nodes.
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

// Returns the node at index `pos` (0-based), or nullptr if out of range.
inline Node* node_at(Node* head, int pos) {
    if (pos < 0) return nullptr;
    for (int i = 0; head && i < pos; ++i) head = head->next;
    return head;
}

// Frees the nodes of an ACYCLIC list. Never call on a list with a cycle.
inline void free_list(Node* head) {
    while (head) {
        Node* next = head->next;
        delete head;
        head = next;
    }
}

#endif  // LINKED_LIST_CYCLE_H
