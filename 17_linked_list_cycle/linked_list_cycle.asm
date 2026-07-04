; linked_list_cycle.asm — Detect a cycle in a linked list (Floyd's algorithm)
; Build a list from user input, optionally loop the tail back to node[pos].
; x86-64 Linux, NASM syntax. Nodes are 16 bytes: [node+0] = val, [node+8] = next.
;
; Build:
;   nasm -f elf64 linked_list_cycle.asm -o linked_list_cycle_asm.o
;   gcc linked_list_cycle_asm.o -o linked_list_cycle_asm -no-pie
; Run:
;   ./linked_list_cycle_asm

default rel

section .data
    prompt_n db "How many values? ", 0
    prompt_v db "Enter values: ", 0
    prompt_p db "Index to loop the tail back to (-1 for none): ", 0
    fmt_in   db "%d", 0
    msg_yes  db "Cycle detected", 10, 0
    msg_no   db "No cycle", 10, 0

section .text
    extern printf, scanf, malloc
    global main

main:
    push    rbp
    mov     rbp, rsp
    push    rbx                 ; head
    push    r12                 ; remaining count / n
    push    r13                 ; tail (build) / slow (search)
    push    r14                 ; scratch / fast (search)
    push    r15                 ; original n (for loop wiring)
    sub     rsp, 8              ; [rsp] = int temp; keeps 16-byte alignment

    ; ---- read count ----
    lea     rdi, [prompt_n]
    xor     eax, eax
    call    printf
    lea     rdi, [fmt_in]
    mov     rsi, rsp
    xor     eax, eax
    call    scanf
    mov     r12d, [rsp]
    test    r12d, r12d
    jns     .keep_n
    xor     r12d, r12d          ; clamp negative counts to 0
.keep_n:
    mov     r15d, r12d          ; remember n

    lea     rdi, [prompt_v]
    xor     eax, eax
    call    printf

    ; ---- build list ----
    xor     ebx, ebx            ; head = null
    xor     r13d, r13d          ; tail = null
.read:
    test    r12d, r12d
    jz      .read_pos
    lea     rdi, [fmt_in]
    mov     rsi, rsp
    xor     eax, eax
    call    scanf
    mov     edi, 16
    call    malloc              ; rax = new node
    mov     ecx, [rsp]
    mov     [rax], ecx          ; node->val
    mov     qword [rax+8], 0    ; node->next = null
    test    rbx, rbx
    jnz     .append
    mov     rbx, rax            ; head = node
    mov     r13, rax            ; tail = node
    jmp     .next
.append:
    mov     [r13+8], rax        ; tail->next = node
    mov     r13, rax            ; tail = node
.next:
    dec     r12d
    jmp     .read

    ; ---- read loop index ----
.read_pos:
    lea     rdi, [prompt_p]
    xor     eax, eax
    call    printf
    lea     rdi, [fmt_in]
    mov     rsi, rsp
    xor     eax, eax
    call    scanf
    mov     eax, [rsp]          ; pos
    test    rbx, rbx            ; empty list -> nothing to wire
    jz      .search
    test    eax, eax
    js      .search             ; pos < 0 -> no loop
    cmp     eax, r15d
    jge     .search             ; pos >= n -> out of range, no loop

    ; find node[pos]: walk pos steps from head
    mov     r14, rbx            ; p = head
    mov     ecx, eax            ; steps = pos
.find:
    test    ecx, ecx
    jz      .wire
    mov     r14, [r14+8]
    dec     ecx
    jmp     .find
.wire:
    mov     [r13+8], r14        ; tail->next = node[pos]  (r13 still = tail)

    ; ---- Floyd's cycle detection ----
.search:
    mov     r13, rbx            ; slow = head
    mov     r14, rbx            ; fast = head
.walk:
    test    r14, r14            ; fast == null?
    jz      .no
    mov     rax, [r14+8]        ; fast->next
    test    rax, rax            ; fast->next == null?
    jz      .no
    mov     r13, [r13+8]        ; slow = slow->next
    mov     r14, [rax+8]        ; fast = fast->next->next
    cmp     r13, r14
    je      .yes
    jmp     .walk
.yes:
    lea     rdi, [msg_yes]
    jmp     .print
.no:
    lea     rdi, [msg_no]
.print:
    xor     eax, eax
    call    printf

    add     rsp, 8
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     rbx
    xor     eax, eax
    pop     rbp
    ret
