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
| `ch04_01_dll_delete.cpp` / `.asm`         | Build the list, then **delete** the node at a specified 1-based position, re-linking its neighbours (a position past the end leaves the list unchanged). |
| `ch04_02_dll_insert_begin.cpp` / `.asm`   | Build the list, then insert a new node at the **front** (before the head). |
| `ch04_03_insert_position.cpp` / `.asm`    | Build the list, then insert a new node at a **specified 1-based position** (positions ≤ 1 go to the front; positions past the end append at the tail). |
| `ch04_04_doubly_linked_list.cpp` / `.asm` | Build the list from user input and traverse it **forward** (from the head) and **backward** (from the tail) to show both link directions work. |

## Building and running

C++:

```sh
g++ -O2 -o ch04_04_doubly_linked_list ch04_04_doubly_linked_list.cpp
./ch04_04_doubly_linked_list
```

Assembly:

```sh
nasm -f elf64 ch04_04_doubly_linked_list.asm -o ch04_04_doubly_linked_list_asm.o
gcc ch04_04_doubly_linked_list_asm.o -o ch04_04_doubly_linked_list_asm -no-pie
./ch04_04_doubly_linked_list_asm
```

Substitute the matching file name for the other three programs. Each program
prompts for a count, then the values, then any operation-specific input
(position and/or value), and prints the resulting list.
