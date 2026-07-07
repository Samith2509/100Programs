// ch04_01_dll_delete.cpp
// Purpose: Build a doubly linked list, then delete the node at a specified
//          1-based position.
//
// Deletion re-links the two neighbours around the target node:
//   * the predecessor's `next` skips over the target,
//   * the successor's `prev` skips back over the target,
//   * deleting the head simply advances `head`.
// A position past the end leaves the list untouched.
//
// Build: g++ -O2 -o ch04_01_dll_delete ch04_01_dll_delete.cpp
// Run:   ./ch04_01_dll_delete

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

// Delete the node at 1-based `pos` and return the (possibly new) head.
static Node* delete_at(Node* head, int pos) {
    if (!head) return head;
    Node* cur = head;
    for (int i = 1; cur && i < pos; ++i) cur = cur->next;
    if (!cur) return head;                       // position past the end

    if (cur->prev) cur->prev->next = cur->next;  // predecessor skips target
    else head = cur->next;                       // deleting the head
    if (cur->next) cur->next->prev = cur->prev;  // successor skips target
    delete cur;
    return head;
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

    int pos;
    std::cout << "Position to delete (1-based): ";
    std::cin >> pos;
    head = delete_at(head, pos);

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
