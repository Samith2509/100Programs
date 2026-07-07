; dll_insert_position.asm — Build a doubly linked list, then insert a new node
; at a specified 1-based position.
;   * position <= 1 (or an empty list) -> insert at the front
;   * a position past the end            -> append at the tail
; x86-64 Linux, NASM syntax. Each node is 24 bytes:
;   [node+0] = val   [node+8] = prev   [node+16] = next
;
; Build:
;   nasm -f elf64 dll_insert_position.asm -o dll_insert_position_asm.o
;   gcc dll_insert_position_asm.o -o dll_insert_position_asm -no-pie
; Run:
;   ./dll_insert_position_asm

default rel

section .data
    prompt_n  db "How many values? ", 0             ; ask for the count
    prompt_v  db "Enter values: ", 0                ; ask for the values
    prompt_p  db "Insert position (1-based): ", 0   ; ask for the position
    prompt_x  db "Value to insert: ", 0             ; ask for the value
    fmt_in    db "%d", 0                             ; scanf integer format
    lbl_res   db "Result :", 0                       ; label before the result
    fmt_val   db " %d", 0                              ; prints " <value>"
    newline   db 10, 0                                 ; newline

section .text
    extern printf, scanf, malloc
    global main

main:
    push    rbp                     ; save caller's base pointer
    mov     rbp, rsp                ; set up our stack frame
    sub     rsp, 24                 ; reserve locals+pad ([rbp-8] = scanf temp;
                                    ;   8 bytes padding keep 16-byte alignment
                                    ;   given the five register pushes below)
    push    rbx                     ; rbx = head
    push    r12                     ; r12 = count, then insert position
    push    r13                     ; r13 = tail, then loop counter
    push    r14                     ; r14 = current node
    push    r15                     ; r15 = new node

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

    ; ---- read the position and the value, allocate the new node ----
.read_pos:
    lea     rdi, [prompt_p]         ; "Insert position (1-based): "
    xor     eax, eax
    call    printf
    lea     rdi, [fmt_in]           ; "%d"
    lea     rsi, [rbp-8]           ; &temp
    xor     eax, eax
    call    scanf                   ; read position into [rbp-8]
    mov     r12d, [rbp-8]           ; r12 = position

    lea     rdi, [prompt_x]         ; "Value to insert: "
    xor     eax, eax
    call    printf
    lea     rdi, [fmt_in]           ; "%d"
    lea     rsi, [rbp-8]           ; &temp
    xor     eax, eax
    call    scanf                   ; read the value into [rbp-8]

    mov     edi, 24                 ; node size
    call    malloc                  ; rax = new node
    mov     r15, rax                ; r15 = new node
    mov     ecx, [rbp-8]            ; the value
    mov     [r15], ecx              ; node->val = value

    ; ---- decide where to insert ----
    cmp     r12d, 1                 ; position <= 1?
    jle     .ins_front              ; yes -> insert at the front
    test    rbx, rbx                ; empty list?
    jz      .ins_front              ; yes -> insert at the front

    ; walk to the node after which we insert (index position-1)
    mov     r14, rbx                ; current = head
    mov     r13d, 1                 ; i = 1
.walk:
    mov     rax, [r14+16]           ; rax = current->next
    test    rax, rax                ; no next node?
    jz      .found                  ; yes -> insert after the last node
    mov     ecx, r12d               ; ecx = position
    dec     ecx                     ; ecx = position - 1
    cmp     r13d, ecx               ; i >= position-1?
    jge     .found                  ; yes -> we are at the insertion point
    mov     r14, rax                ; current = current->next
    inc     r13d                    ; i++
    jmp     .walk

.found:
    mov     rax, [r14+16]           ; rax = current->next (the successor)
    mov     [r15+8], r14            ; node->prev = current
    mov     [r15+16], rax           ; node->next = successor
    test    rax, rax                ; is there a successor?
    jz      .fix_cur
    mov     [rax+8], r15            ; successor->prev = node
.fix_cur:
    mov     [r14+16], r15           ; current->next = node
    jmp     .print

.ins_front:
    mov     qword [r15+8], 0        ; node->prev = NULL (it becomes the head)
    mov     [r15+16], rbx           ; node->next = old head
    test    rbx, rbx                ; was the list non-empty?
    jz      .front_head
    mov     [rbx+8], r15            ; old head->prev = node
.front_head:
    mov     rbx, r15                ; head = node

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
