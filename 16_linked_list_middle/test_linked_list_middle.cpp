// Unit tests for middle_value().
// Build & run: g++ -std=c++17 -O2 -o test_linked_list_middle test_linked_list_middle.cpp && ./test_linked_list_middle
#include "linked_list_middle.h"

#include "../test_common/test_framework.h"

TEST(odd_length_true_middle) {
    int vals[] = {1, 2, 3, 4, 5};
    Node* head = build_list(vals, 5);
    CHECK_EQ(middle_value(head), 3);
    free_list(head);
}

TEST(even_length_returns_second_middle) {
    int vals[] = {1, 2, 3, 4};
    Node* head = build_list(vals, 4);
    CHECK_EQ(middle_value(head), 3);
    free_list(head);
}

TEST(single_node) {
    int vals[] = {42};
    Node* head = build_list(vals, 1);
    CHECK_EQ(middle_value(head), 42);
    free_list(head);
}

TEST(two_nodes_returns_second) {
    int vals[] = {8, 9};
    Node* head = build_list(vals, 2);
    CHECK_EQ(middle_value(head), 9);
    free_list(head);
}

TEST(longer_list) {
    int vals[] = {10, 20, 30, 40, 50, 60, 70};
    Node* head = build_list(vals, 7);
    CHECK_EQ(middle_value(head), 40);
    free_list(head);
}

RUN_ALL_TESTS_MAIN()
