; ch04_04_doubly_linked_list.asm — Build a doubly linked list from user input and
; traverse it forward (from the head) and backward (from the tail).
; x86-64 Linux, NASM syntax. Each node is 24 bytes:
;   [node+0]  = val (int)
;   [node+8]  = prev pointer
;   [node+16] = next pointer
;
; Build:
;   nasm -f elf64 ch04_04_doubly_linked_list.asm -o ch04_04_doubly_linked_list_asm.o
;   gcc ch04_04_doubly_linked_list_asm.o -o ch04_04_doubly_linked_list_asm -no-pie
; Run:
;   ./ch04_04_doubly_linked_list_asm

default rel

section .data
    prompt_n  db "How many values? ", 0     ; asks for the number of values
    prompt_v  db "Enter values: ", 0        ; asks for the values themselves
    fmt_in    db "%d", 0                     ; scanf format for one integer
    lbl_fwd   db "Forward :", 0              ; label before the forward walk
    lbl_bwd   db "Backward:", 0              ; label before the backward walk
    fmt_val   db " %d", 0                     ; prints " <space><value>"
    newline   db 10, 0                        ; a single newline

section .text
    extern printf, scanf, malloc              ; libc routines we rely on
    global main

main:
    push    rbp                     ; save caller's base pointer
    mov     rbp, rsp                ; establish our own stack frame
    sub     rsp, 16                 ; reserve 16 bytes of locals ([rbp-8] = scanf temp)
    push    rbx                     ; preserve rbx  -> holds the list head
    push    r12                     ; preserve r12  -> holds the remaining count
    push    r13                     ; preserve r13  -> holds the list tail
    push    r14                     ; preserve r14  -> current / new node

    ; ---- read how many values ----
    lea     rdi, [prompt_n]         ; 1st arg = "How many values? "
    xor     eax, eax                ; 0 vector regs used (varargs ABI rule)
    call    printf                  ; print the prompt
    lea     rdi, [fmt_in]           ; 1st arg = "%d"
    lea     rsi, [rbp-8]            ; 2nd arg = &local temp
    xor     eax, eax                ; no vector args
    call    scanf                   ; read the count into [rbp-8]
    mov     r12d, [rbp-8]           ; r12 = count
    test    r12d, r12d              ; is the count negative?
    jns     .prompt_vals            ; no -> keep it as-is
    xor     r12d, r12d              ; yes -> clamp negative counts to 0

.prompt_vals:
    lea     rdi, [prompt_v]         ; 1st arg = "Enter values: "
    xor     eax, eax
    call    printf                  ; prompt for the values

    ; ---- build the list by appending at the tail ----
    xor     ebx, ebx                ; head = NULL
    xor     r13d, r13d              ; tail = NULL
.build:
    test    r12d, r12d              ; any values left to read?
    jz      .print_fwd             ; no -> start printing
    lea     rdi, [fmt_in]           ; "%d"
    lea     rsi, [rbp-8]           ; &temp
    xor     eax, eax
    call    scanf                   ; read one value into [rbp-8]
    mov     edi, 24                 ; node size = 24 bytes
    call    malloc                  ; rax = address of the new node
    mov     r14, rax                ; r14 = new node
    mov     ecx, [rbp-8]            ; ecx = value just read
    mov     [r14], ecx              ; node->val = value
    mov     qword [r14+8], 0        ; node->prev = NULL
    mov     qword [r14+16], 0       ; node->next = NULL
    test    rbx, rbx                ; is the list currently empty?
    jnz     .append                 ; no -> append after the tail
    mov     rbx, r14                ; head = node
    mov     r13, r14                ; tail = node
    jmp     .build_next
.append:
    mov     [r13+16], r14           ; tail->next = node
    mov     [r14+8], r13            ; node->prev = tail
    mov     r13, r14                ; tail = node
.build_next:
    dec     r12d                    ; one fewer value to read
    jmp     .build

    ; ---- forward traversal: follow next from the head ----
.print_fwd:
    lea     rdi, [lbl_fwd]          ; "Forward :"
    xor     eax, eax
    call    printf
    mov     r14, rbx                ; current = head
.fwd_loop:
    test    r14, r14                ; reached the end?
    jz      .print_bwd
    lea     rdi, [fmt_val]          ; " %d"
    mov     esi, [r14]              ; value = current->val
    xor     eax, eax
    call    printf
    mov     r14, [r14+16]           ; current = current->next
    jmp     .fwd_loop

    ; ---- backward traversal: follow prev from the tail ----
.print_bwd:
    lea     rdi, [newline]          ; end the forward line
    xor     eax, eax
    call    printf
    lea     rdi, [lbl_bwd]          ; "Backward:"
    xor     eax, eax
    call    printf
    mov     r14, r13                ; current = tail
.bwd_loop:
    test    r14, r14                ; walked past the head?
    jz      .done
    lea     rdi, [fmt_val]          ; " %d"
    mov     esi, [r14]              ; value = current->val
    xor     eax, eax
    call    printf
    mov     r14, [r14+8]            ; current = current->prev
    jmp     .bwd_loop

.done:
    lea     rdi, [newline]          ; end the backward line
    xor     eax, eax
    call    printf
    pop     r14                     ; restore callee-saved registers
    pop     r13
    pop     r12
    pop     rbx
    leave                           ; mov rsp,rbp ; pop rbp
    xor     eax, eax                ; return 0
    ret
