; linked_list_reverse.asm — Reverse a singly linked list built from user input
; Example: 1 2 3 4 5 -> 5 4 3 2 1
; x86-64 Linux, NASM syntax. Nodes are 16 bytes: [node+0] = val, [node+8] = next.
;
; Build:
;   nasm -f elf64 linked_list_reverse.asm -o linked_list_reverse_asm.o
;   gcc linked_list_reverse_asm.o -o linked_list_reverse_asm -no-pie
; Run:
;   ./linked_list_reverse_asm

default rel

section .data
    prompt_n db "How many values? ", 0
    prompt_v db "Enter values: ", 0
    fmt_in   db "%d", 0
    lbl      db "Reversed list:", 0
    fmt_val  db " %d", 0
    newline  db 10, 0

section .text
    extern printf, scanf, malloc
    global main

main:
    push    rbp
    mov     rbp, rsp
    push    rbx                 ; head
    push    r12                 ; remaining count
    push    r13                 ; tail (build) / prev (reverse)
    push    r14                 ; scratch
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
    jns     .prompt_vals
    xor     r12d, r12d          ; clamp negative counts to 0

.prompt_vals:
    lea     rdi, [prompt_v]
    xor     eax, eax
    call    printf

    ; ---- build list ----
    xor     ebx, ebx            ; head = null
    xor     r13d, r13d          ; tail = null
.read:
    test    r12d, r12d
    jz      .reverse
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

    ; ---- reverse in place ----
.reverse:
    xor     r13d, r13d          ; prev = null
.rev_loop:
    test    rbx, rbx
    jz      .rev_done
    mov     rax, [rbx+8]        ; next = cur->next
    mov     [rbx+8], r13        ; cur->next = prev
    mov     r13, rbx            ; prev = cur
    mov     rbx, rax            ; cur = next
    jmp     .rev_loop
.rev_done:
    mov     rbx, r13            ; head = prev

    ; ---- print ----
    lea     rdi, [lbl]
    xor     eax, eax
    call    printf
.print:
    test    rbx, rbx
    jz      .print_done
    lea     rdi, [fmt_val]
    mov     esi, [rbx]
    xor     eax, eax
    call    printf
    mov     rbx, [rbx+8]
    jmp     .print
.print_done:
    lea     rdi, [newline]
    xor     eax, eax
    call    printf

    add     rsp, 16
    pop     r14
    pop     r13
    pop     r12
    pop     rbx
    xor     eax, eax
    pop     rbp
    ret
