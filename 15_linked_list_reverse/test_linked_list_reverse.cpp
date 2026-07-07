// Unit tests for reverse_list().
// Build & run: g++ -std=c++17 -O2 -o test_linked_list_reverse test_linked_list_reverse.cpp && ./test_linked_list_reverse

#include "linked_list_reverse.h"

#include "../test_common/test_framework.h"

// Collects the list's values into `out` (assumed large enough) and returns
// the count written.
static int to_array(Node* head, int* out) {
    int n = 0;
    for (Node* cur = head; cur; cur = cur->next) out[n++] = cur->val;
    return n;
}

// Fails the current test unless the list holds exactly expected[0..len).
static void check_list(Node* head, const int* expected, int len) {
    int got[64];
    int n = to_array(head, got);
    CHECK_EQ(n, len);
    for (int i = 0; i < n && i < len; ++i) CHECK_EQ(got[i], expected[i]);
}

TEST(reverses_multiple_nodes) {
    int vals[] = {1, 2, 3, 4, 5};
    Node* head = reverse_list(build_list(vals, 5));
    int expected[] = {5, 4, 3, 2, 1};
    check_list(head, expected, 5);
    free_list(head);
}

TEST(reverses_two_nodes) {
    int vals[] = {7, 9};
    Node* head = reverse_list(build_list(vals, 2));
    int expected[] = {9, 7};
    check_list(head, expected, 2);
    free_list(head);
}

TEST(single_node_unchanged) {
    int vals[] = {42};
    Node* head = reverse_list(build_list(vals, 1));
    int expected[] = {42};
    check_list(head, expected, 1);
    free_list(head);
}

TEST(empty_list_stays_empty) {
    Node* head = reverse_list(build_list(nullptr, 0));
    CHECK(head == nullptr);
}

TEST(reverse_twice_is_identity) {
    int vals[] = {3, 1, 4, 1, 5, 9};
    Node* head = reverse_list(reverse_list(build_list(vals, 6)));
    int expected[] = {3, 1, 4, 1, 5, 9};
    check_list(head, expected, 6);
    free_list(head);
}

RUN_ALL_TESTS_MAIN()
