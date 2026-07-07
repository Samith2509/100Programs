# ch04 — Doubly Linked List

Four small programs that build and manipulate a **doubly linked list**, each
implemented twice: once in C++ and once in hand-written x86-64 assembly
(NASM, Linux). A doubly linked list node carries a value plus two pointers —
`prev` (the node before it) and `next` (the node after it) — so the list can be
walked in either direction and nodes can be spliced in or out in O(1) once you
hold a pointer to the neighbour.

## Node layout

Every program uses the same node representation.

| Language | Layout |
|----------|--------|
| C++      | `struct Node { int val; Node* prev; Node* next; };` |
| Assembly | 24-byte block: `[node+0]` = val, `[node+8]` = prev, `[node+16]` = next |

The assembly programs keep all scratch storage in **stack-frame local
variables** addressed relative to `rbp` (e.g. `[rbp-8]` for the `scanf`
temporary) rather than a `.bss` section or ad-hoc `[rsp]` slots. Each source
line carries an inline comment explaining what it does.

## Files

| File | Purpose |
|------|---------|
| `doubly_linked_list.cpp` / `.asm` | Build the list from user input and traverse it **forward** (from the head) and **backward** (from the tail) to show both link directions work. |
| `dll_insert_begin.cpp` / `.asm`   | Build the list, then insert a new node at the **front** (before the head). |
| `dll_insert_position.cpp` / `.asm`| Build the list, then insert a new node at a **specified 1-based position** (positions ≤ 1 go to the front; positions past the end append at the tail). |
| `dll_delete_node.cpp` / `.asm`    | Build the list, then **delete** the node at a specified 1-based position, re-linking its neighbours (a position past the end leaves the list unchanged). |

## Building and running

C++:

```sh
g++ -O2 -o doubly_linked_list doubly_linked_list.cpp
./doubly_linked_list
```

Assembly:

```sh
nasm -f elf64 doubly_linked_list.asm -o doubly_linked_list_asm.o
gcc doubly_linked_list_asm.o -o doubly_linked_list_asm -no-pie
./doubly_linked_list_asm
```

Substitute the matching file name for the other three programs. Each program
prompts for a count, then the values, then any operation-specific input
(position and/or value), and prints the resulting list.
