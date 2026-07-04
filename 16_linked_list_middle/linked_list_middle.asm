; linked_list_middle.asm — Find the middle node of a linked list from user input
; Slow/fast pointers; for even counts the second middle is reported. 1 2 3 4 5 -> 3
; x86-64 Linux, NASM syntax. Nodes are 16 bytes: [node+0] = val, [node+8] = next.
;
; Build:
;   nasm -f elf64 linked_list_middle.asm -o linked_list_middle_asm.o
;   gcc linked_list_middle_asm.o -o linked_list_middle_asm -no-pie
; Run:
;   ./linked_list_middle_asm

default rel

section .data
    prompt_n db "How many values? ", 0
    prompt_v db "Enter values: ", 0
    fmt_in   db "%d", 0
    fmt_out  db "Middle: %d", 10, 0
    empty    db "List is empty; no middle.", 10, 0

section .text
    extern printf, scanf, malloc
    global main

main:
    push    rbp
    mov     rbp, rsp
    push    rbx                 ; head
    push    r12                 ; remaining count
    push    r13                 ; tail (build) / slow (search)
    push    r14                 ; fast (search)
    sub     rsp, 16             ; [rsp] = int temp; keeps 16-byte alignment

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
    jg      .prompt_vals
    lea     rdi, [empty]        ; count <= 0: nothing to do
    xor     eax, eax
    call    printf
    jmp     .exit

.prompt_vals:
    lea     rdi, [prompt_v]
    xor     eax, eax
    call    printf

    ; ---- build list ----
    xor     ebx, ebx            ; head = null
    xor     r13d, r13d          ; tail = null
.read:
    test    r12d, r12d
    jz      .search
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

    ; ---- slow/fast walk ----
.search:
    mov     r13, rbx            ; slow = head
    mov     r14, rbx            ; fast = head
.walk:
    test    r14, r14            ; fast == null?
    jz      .found
    mov     rax, [r14+8]        ; fast->next
    test    rax, rax            ; fast->next == null?
    jz      .found
    mov     r13, [r13+8]        ; slow = slow->next
    mov     r14, [rax+8]        ; fast = fast->next->next
    jmp     .walk
.found:
    lea     rdi, [fmt_out]
    mov     esi, [r13]          ; slow->val
    xor     eax, eax
    call    printf

.exit:
    add     rsp, 16
    pop     r14
    pop     r13
    pop     r12
    pop     rbx
    xor     eax, eax
    pop     rbp
    ret
