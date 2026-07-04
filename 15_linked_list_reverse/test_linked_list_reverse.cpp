// Unit tests for reverse_list().
// Build & run: g++ -std=c++17 -O2 -o test_linked_list_reverse test_linked_list_reverse.cpp && ./test_linked_list_reverse
#include <vector>

#include "linked_list_reverse.h"

#include "../test_common/test_framework.h"

// Collects the list's values into a vector for easy comparison.
static std::vector<int> to_vector(Node* head) {
    std::vector<int> out;
    for (Node* cur = head; cur; cur = cur->next) out.push_back(cur->val);
    return out;
}

TEST(reverses_multiple_nodes) {
    int vals[] = {1, 2, 3, 4, 5};
    Node* head = reverse_list(build_list(vals, 5));
    CHECK_EQ(to_vector(head), (std::vector<int>{5, 4, 3, 2, 1}));
    free_list(head);
}

TEST(reverses_two_nodes) {
    int vals[] = {7, 9};
    Node* head = reverse_list(build_list(vals, 2));
    CHECK_EQ(to_vector(head), (std::vector<int>{9, 7}));
    free_list(head);
}

TEST(single_node_unchanged) {
    int vals[] = {42};
    Node* head = reverse_list(build_list(vals, 1));
    CHECK_EQ(to_vector(head), (std::vector<int>{42}));
    free_list(head);
}

TEST(empty_list_stays_empty) {
    Node* head = reverse_list(build_list(nullptr, 0));
    CHECK(head == nullptr);
}

TEST(reverse_twice_is_identity) {
    int vals[] = {3, 1, 4, 1, 5, 9};
    Node* head = reverse_list(reverse_list(build_list(vals, 6)));
    CHECK_EQ(to_vector(head), (std::vector<int>{3, 1, 4, 1, 5, 9}));
    free_list(head);
}

RUN_ALL_TESTS_MAIN()
