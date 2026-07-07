// ch04_03_insert_position.cpp
// Purpose: Build a doubly linked list, then insert a new node at a specified
//          1-based position.
//
// Position handling:
//   * pos <= 1 (or an empty list) inserts at the front.
//   * otherwise we walk to the node that will precede the new one, splice the
//     new node in, and repair the prev/next links on both neighbours.
//   * a position past the end appends at the tail.
//
// Build: g++ -O2 -o ch04_03_insert_position ch04_03_insert_position.cpp
// Run:   ./ch04_03_insert_position

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

// Insert `val` at 1-based `pos` and return the (possibly new) head.
static Node* insert_at(Node* head, int pos, int val) {
    if (pos <= 1 || !head) {                 // insert at the front
        Node* node = new Node{val, nullptr, head};
        if (head) head->prev = node;
        return node;
    }
    Node* cur = head;                        // find the node to insert after
    for (int i = 1; cur->next && i < pos - 1; ++i) cur = cur->next;

    Node* node = new Node{val, cur, cur->next};
    if (cur->next) cur->next->prev = node;   // fix the successor's back-link
    cur->next = node;                        // splice the new node in
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

    int pos, x;
    std::cout << "Insert position (1-based): ";
    std::cin >> pos;
    std::cout << "Value to insert: ";
    std::cin >> x;
    head = insert_at(head, pos, x);

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
