; dll_insert_begin.asm — Build a doubly linked list, then insert a new node at
; the FRONT of the list (before the current head).
; x86-64 Linux, NASM syntax. Each node is 24 bytes:
;   [node+0]  = val   [node+8] = prev   [node+16] = next
;
; Build:
;   nasm -f elf64 dll_insert_begin.asm -o dll_insert_begin_asm.o
;   gcc dll_insert_begin_asm.o -o dll_insert_begin_asm -no-pie
; Run:
;   ./dll_insert_begin_asm

default rel

section .data
    prompt_n  db "How many values? ", 0        ; ask for the count
    prompt_v  db "Enter values: ", 0           ; ask for the values
    prompt_x  db "Value to insert at front: ", 0 ; ask for the new front value
    fmt_in    db "%d", 0                         ; scanf integer format
    lbl_res   db "Result :", 0                   ; label before the result
    fmt_val   db " %d", 0                          ; prints " <value>"
    newline   db 10, 0                             ; newline

section .text
    extern printf, scanf, malloc
    global main

main:
    push    rbp                     ; save caller's base pointer
    mov     rbp, rsp                ; set up our stack frame
    sub     rsp, 16                 ; reserve locals ([rbp-8] = scanf temp)
    push    rbx                     ; rbx = head
    push    r12                     ; r12 = remaining count
    push    r13                     ; r13 = tail
    push    r14                     ; r14 = current / new node

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
    jz      .insert
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

    ; ---- insert a new node at the front ----
.insert:
    lea     rdi, [prompt_x]         ; "Value to insert at front: "
    xor     eax, eax
    call    printf
    lea     rdi, [fmt_in]           ; "%d"
    lea     rsi, [rbp-8]           ; &temp
    xor     eax, eax
    call    scanf                   ; read the new value into [rbp-8]
    mov     edi, 24                 ; node size
    call    malloc                  ; rax = new node
    mov     r14, rax                ; r14 = new node
    mov     ecx, [rbp-8]            ; the new value
    mov     [r14], ecx              ; node->val = value
    mov     qword [r14+8], 0        ; node->prev = NULL (it becomes the head)
    mov     [r14+16], rbx           ; node->next = old head
    test    rbx, rbx                ; was the list non-empty?
    jz      .set_head
    mov     [rbx+8], r14            ; old head->prev = node
.set_head:
    mov     rbx, r14                ; head = node

    ; ---- print the resulting list ----
    lea     rdi, [lbl_res]          ; "Result :"
    xor     eax, eax
    call    printf
    mov     r14, rbx                ; current = head
.print:
    test    r14, r14                ; end of list?
    jz      .done
    lea     rdi, [fmt_val]          ; " %d"
    mov     esi, [r14]              ; value = current->val
    xor     eax, eax
    call    printf
    mov     r14, [r14+16]           ; current = current->next
    jmp     .print

.done:
    lea     rdi, [newline]          ; end the line
    xor     eax, eax
    call    printf
    pop     r14                     ; restore callee-saved registers
    pop     r13
    pop     r12
    pop     rbx
    leave                           ; tear down the frame
    xor     eax, eax                ; return 0
    ret
