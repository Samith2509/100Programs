; factorial.asm — Compute N! iteratively
; Accurate up to N = 20 (20! fits in a signed 64-bit integer).
; x86-64 Linux, NASM syntax
;
; Build:
;   nasm -f elf64 factorial.asm -o factorial_asm.o
;   gcc factorial_asm.o -o factorial_asm -no-pie
; Run:
;   ./factorial_asm

default rel

section .data
    prompt  db "Enter n (0-20): ", 0
    fmt_in  db "%d", 0
    fmt_out db "%d! = %lld", 10, 0

section .text
    extern printf, scanf
    global main

main:
    push    rbp
    mov     rbp, rsp
    push    rbx             ; loop counter i
    push    r12             ; n
    push    r13             ; result
    sub     rsp, 8          ; n slot (stack-allocated, replaces .bss)

    lea     rdi, [prompt]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_in]
    mov     rsi, rsp
    xor     eax, eax
    call    scanf
    mov     r12d, [rsp]

    mov     r13, 1
    mov     ebx, 2

.loop:
    cmp     ebx, r12d
    jg      .done
    imul    r13, rbx
    inc     ebx
    jmp     .loop

.done:
    lea     rdi, [fmt_out]
    mov     esi, r12d
    mov     rdx, r13
    xor     eax, eax
    call    printf

    add     rsp, 8
    pop     r13
    pop     r12
    pop     rbx
    xor     eax, eax
    pop     rbp
    ret
