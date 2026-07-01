; fibonacci.asm — Print first N Fibonacci numbers
; x86-64 Linux, NASM syntax
;
; Build:
;   nasm -f elf64 fibonacci.asm -o fibonacci_asm.o
;   gcc fibonacci_asm.o -o fibonacci_asm -no-pie
; Run:
;   ./fibonacci_asm

default rel

section .data
    prompt  db "Enter number of terms: ", 0
    out_hdr db "Fibonacci: ", 0
    fmt_in  db "%d", 0
    fmt_num db "%lld", 0
    space   db " ", 0
    newline db 10, 0

section .text
    extern printf, scanf
    global main

main:
    push    rbp
    mov     rbp, rsp
    push    rbx
    push    r12             ; n
    push    r13             ; a (current term)
    push    r14             ; b (next term)
    push    r15             ; i
    sub     rsp, 8          ; n slot (stack-allocated, replaces .bss)

    lea     rdi, [prompt]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_in]
    mov     rsi, rsp
    xor     eax, eax
    call    scanf
    mov     r12d, [rsp]

    lea     rdi, [out_hdr]
    xor     eax, eax
    call    printf

    xor     r13, r13
    mov     r14, 1
    xor     r15d, r15d

.loop:
    cmp     r15d, r12d
    jge     .done

    test    r15d, r15d
    jz      .no_space
    lea     rdi, [space]
    xor     eax, eax
    call    printf
.no_space:

    lea     rdi, [fmt_num]
    mov     rsi, r13
    xor     eax, eax
    call    printf

    mov     rax, r13
    add     rax, r14
    mov     r13, r14
    mov     r14, rax

    inc     r15d
    jmp     .loop

.done:
    lea     rdi, [newline]
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
