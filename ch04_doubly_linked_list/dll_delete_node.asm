; dll_delete_node.asm — Build a doubly linked list, then delete the node at a
; specified 1-based position. A position past the end leaves the list intact.
; x86-64 Linux, NASM syntax. Each node is 24 bytes:
;   [node+0] = val   [node+8] = prev   [node+16] = next
;
; Build:
;   nasm -f elf64 dll_delete_node.asm -o dll_delete_node_asm.o
;   gcc dll_delete_node_asm.o -o dll_delete_node_asm -no-pie
; Run:
;   ./dll_delete_node_asm

default rel

section .data
    prompt_n  db "How many values? ", 0                ; ask for the count
    prompt_v  db "Enter values: ", 0                   ; ask for the values
    prompt_p  db "Position to delete (1-based): ", 0   ; ask for the position
    fmt_in    db "%d", 0                                ; scanf integer format
    lbl_res   db "Result :", 0                          ; label before result
    fmt_val   db " %d", 0                                 ; prints " <value>"
    newline   db 10, 0                                    ; newline

section .text
    extern printf, scanf, malloc, free
    global main

main:
    push    rbp                     ; save caller's base pointer
    mov     rbp, rsp                ; set up our stack frame
    sub     rsp, 24                 ; reserve locals+pad ([rbp-8] = scanf temp;
                                    ;   8 bytes padding keep 16-byte alignment
                                    ;   given the five register pushes below)
    push    rbx                     ; rbx = head
    push    r12                     ; r12 = count, then delete position
    push    r13                     ; r13 = tail, then counter/next scratch
    push    r14                     ; r14 = current node
    push    r15                     ; r15 = prev scratch

    ; ---- read the count ----
    lea     rdi, [prompt_n]         ; "How many values? "
    xor     eax, eax
    call    printf
    lea     rdi, [fmt_in]           ; "%d"
    lea     rsi, [rbp-8]           ; &temp
    xor     eax, eax
    call    scanf                   ; read count into [rbp-8]
    mov     r12d, [rbp-8]           ; r12 = count
    test    r12d, r12d              ; negative?
    jns     .prompt_vals
    xor     r12d, r12d              ; clamp to 0

.prompt_vals:
    lea     rdi, [prompt_v]         ; "Enter values: "
    xor     eax, eax
    call    printf

    ; ---- build the list by appending at the tail ----
    xor     ebx, ebx                ; head = NULL
    xor     r13d, r13d              ; tail = NULL
.build:
    test    r12d, r12d              ; values left?
    jz      .read_pos
    lea     rdi, [fmt_in]           ; "%d"
    lea     rsi, [rbp-8]           ; &temp
    xor     eax, eax
    call    scanf                   ; read a value into [rbp-8]
    mov     edi, 24                 ; node size
    call    malloc                  ; rax = new node
    mov     r14, rax                ; r14 = new node
    mov     ecx, [rbp-8]            ; value read
    mov     [r14], ecx              ; node->val = value
    mov     qword [r14+8], 0        ; node->prev = NULL
    mov     qword [r14+16], 0       ; node->next = NULL
    test    rbx, rbx                ; list empty?
    jnz     .append
    mov     rbx, r14                ; head = node
    mov     r13, r14                ; tail = node
    jmp     .build_next
.append:
    mov     [r13+16], r14           ; tail->next = node
    mov     [r14+8], r13            ; node->prev = tail
    mov     r13, r14                ; tail = node
.build_next:
    dec     r12d                    ; one fewer to read
    jmp     .build

    ; ---- read the position to delete ----
.read_pos:
    lea     rdi, [prompt_p]         ; "Position to delete (1-based): "
    xor     eax, eax
    call    printf
    lea     rdi, [fmt_in]           ; "%d"
    lea     rsi, [rbp-8]           ; &temp
    xor     eax, eax
    call    scanf                   ; read position into [rbp-8]
    mov     r12d, [rbp-8]           ; r12 = position

    ; ---- walk to the target node ----
    test    rbx, rbx                ; empty list?
    jz      .print                  ; yes -> nothing to delete
    mov     r14, rbx                ; current = head
    mov     r13d, 1                 ; i = 1
.walk:
    test    r14, r14                ; ran off the end?
    jz      .print                  ; yes -> nothing to delete
    cmp     r13d, r12d              ; i >= position?
    jge     .unlink                 ; yes -> current is the target
    mov     r14, [r14+16]           ; current = current->next
    inc     r13d                    ; i++
    jmp     .walk

    ; ---- unlink the target node (current = r14) ----
.unlink:
    mov     r15, [r14+8]            ; prev = current->prev
    mov     r13, [r14+16]           ; next = current->next
    test    r15, r15                ; is there a predecessor?
    jz      .del_head
    mov     [r15+16], r13           ; prev->next = next
    jmp     .del_next
.del_head:
    mov     rbx, r13                ; deleting the head -> head = next
.del_next:
    test    r13, r13                ; is there a successor?
    jz      .del_free
    mov     [r13+8], r15            ; next->prev = prev
.del_free:
    mov     rdi, r14                ; free(current)
    call    free

    ; ---- print the resulting list ----
.print:
    lea     rdi, [lbl_res]          ; "Result :"
    xor     eax, eax
    call    printf
    mov     r14, rbx                ; current = head
.print_loop:
    test    r14, r14                ; end of list?
    jz      .done
    lea     rdi, [fmt_val]          ; " %d"
    mov     esi, [r14]              ; value = current->val
    xor     eax, eax
    call    printf
    mov     r14, [r14+16]           ; current = current->next
    jmp     .print_loop

.done:
    lea     rdi, [newline]          ; end the line
    xor     eax, eax
    call    printf
    pop     r15                     ; restore callee-saved registers
    pop     r14
    pop     r13
    pop     r12
    pop     rbx
    leave                           ; tear down the frame
    xor     eax, eax                ; return 0
    ret
