; binary_search.asm — Binary search for a target value in a sorted array
; x86-64 Linux, NASM syntax
;
; Build:
;   nasm -f elf64 binary_search.asm -o binary_search_asm.o
;   gcc binary_search_asm.o -o binary_search_asm -no-pie
; Run:
;   ./binary_search_asm

default rel

section .data
    prompt_n     db "Enter number of elements (sorted ascending): ", 0
    prompt_arr   db "Enter elements: ", 0
    prompt_t     db "Enter target: ", 0
    fmt_int      db "%d", 0
    fmt_found    db "Found at index: %d", 10, 0
    fmt_notfound db "Not found", 10, 0

section .text
    extern printf, scanf
    global main

main:
    push    rbp
    mov     rbp, rsp
    push    rbx             ; loop index / result index
    push    r12             ; n
    push    r13             ; array base (stack-allocated, replaces .bss)
    push    r14             ; lo
    push    r15             ; hi
    sub     rsp, 424        ; arr[100] (400 bytes) + n (4) + target (4), padded for 16-byte alignment

    mov     r13, rsp        ; r13 -> arr[0..99]; r13+400 = n; r13+404 = target

    lea     rdi, [prompt_n]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_int]
    lea     rsi, [r13+400]
    xor     eax, eax
    call    scanf
    mov     r12d, [r13+400]

    lea     rdi, [prompt_arr]
    xor     eax, eax
    call    printf

    xor     ebx, ebx
.read_loop:
    cmp     ebx, r12d
    jge     .read_done
    lea     rsi, [r13 + rbx*4]
    lea     rdi, [fmt_int]
    xor     eax, eax
    call    scanf
    inc     ebx
    jmp     .read_loop
.read_done:

    lea     rdi, [prompt_t]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_int]
    lea     rsi, [r13+404]
    xor     eax, eax
    call    scanf

    xor     r14d, r14d       ; lo = 0
    mov     r15d, r12d
    dec     r15d             ; hi = n - 1
    mov     ebx, -1          ; idx = -1

.search_loop:
    cmp     r14d, r15d
    jg      .search_done     ; lo > hi -> not found

    mov     eax, r14d
    add     eax, r15d
    shr     eax, 1           ; mid = (lo+hi)/2 (unsigned shift; lo,hi >= 0)
    mov     ecx, eax         ; mid

    mov     edx, [r13 + rcx*4]  ; arr[mid]
    mov     eax, [r13+404]      ; target
    cmp     edx, eax
    je      .found
    jl      .go_right

    mov     r15d, ecx        ; hi = mid - 1
    dec     r15d
    jmp     .search_loop
.go_right:
    mov     r14d, ecx        ; lo = mid + 1
    inc     r14d
    jmp     .search_loop

.found:
    mov     ebx, ecx         ; idx = mid

.search_done:
    cmp     ebx, -1
    je      .notfound

    lea     rdi, [fmt_found]
    mov     esi, ebx
    xor     eax, eax
    call    printf
    jmp     .end

.notfound:
    lea     rdi, [fmt_notfound]
    xor     eax, eax
    call    printf

.end:
    add     rsp, 424
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     rbx
    xor     eax, eax
    pop     rbp
    ret
