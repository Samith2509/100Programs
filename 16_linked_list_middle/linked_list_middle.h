// Core logic for finding the middle node of a linked list, factored out for
// unit testing. Uses the slow/fast (tortoise-and-hare) pointer technique.
#ifndef LINKED_LIST_MIDDLE_H
#define LINKED_LIST_MIDDLE_H

struct Node {
    int val;
    Node* next;
};

// Returns the value of the middle node. For an even number of nodes the second
// of the two middle nodes is returned (1 2 3 4 -> 3). The list must be non-empty.
inline int middle_value(Node* head) {
    Node* slow = head;
    Node* fast = head;
    while (fast && fast->next) {
        slow = slow->next;
        fast = fast->next->next;
    }
    return slow->val;
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

#endif  // LINKED_LIST_MIDDLE_H
