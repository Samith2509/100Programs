// Unit tests for has_cycle().
// Build & run: g++ -std=c++17 -O2 -o test_linked_list_cycle test_linked_list_cycle.cpp && ./test_linked_list_cycle
#include "linked_list_cycle.h"

#include "../test_common/test_framework.h"

TEST(acyclic_list_has_no_cycle) {
    int vals[] = {1, 2, 3, 4, 5};
    Node* head = build_list(vals, 5);
    CHECK(!has_cycle(head));
    free_list(head);
}

TEST(empty_list_has_no_cycle) {
    CHECK(!has_cycle(nullptr));
}

TEST(single_node_no_cycle) {
    int vals[] = {7};
    Node* head = build_list(vals, 1);
    CHECK(!has_cycle(head));
    free_list(head);
}

TEST(single_node_self_loop) {
    int vals[] = {7};
    Node* head = build_list(vals, 1);
    head->next = head;          // self-loop
    CHECK(has_cycle(head));
    head->next = nullptr;       // break loop before freeing
    free_list(head);
}

TEST(tail_loops_to_middle) {
    int vals[] = {1, 2, 3, 4, 5};
    Node* head = build_list(vals, 5);
    node_at(head, 4)->next = node_at(head, 2);  // 5 -> node[2]
    CHECK(has_cycle(head));
    node_at(head, 4)->next = nullptr;           // break loop before freeing
    free_list(head);
}

TEST(tail_loops_to_head) {
    int vals[] = {9, 8};
    Node* head = build_list(vals, 2);
    node_at(head, 1)->next = head;              // full loop
    CHECK(has_cycle(head));
    node_at(head, 1)->next = nullptr;
    free_list(head);
}

RUN_ALL_TESTS_MAIN()
