; prime_check.asm — Check whether a number entered by the user is prime
; Example: 7 -> prime, 8 -> not prime
; x86-64 Linux, NASM syntax
;
; Build:
;   nasm -f elf64 prime_check.asm -o prime_check_asm.o
;   gcc prime_check_asm.o -o prime_check_asm -no-pie
; Run:
;   ./prime_check_asm

default rel

section .data
    prompt   db "Enter a number: ", 0
    fmt_in   db "%d", 0
    msg_yes  db "%d is prime", 10, 0
    msg_no   db "%d is not prime", 10, 0

section .text
    extern printf, scanf
    global main

main:
    push    rbp
    mov     rbp, rsp
    push    r12             ; i (trial divisor)
    push    r13             ; n
    sub     rsp, 16         ; n input slot (stack-allocated, replaces .bss)

    lea     rdi, [prompt]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_in]
    mov     rsi, rsp
    xor     eax, eax
    call    scanf
    mov     r13d, [rsp]      ; n

    cmp     r13d, 2
    jl      .notprime

    mov     r12d, 2          ; i = 2
.loop:
    mov     eax, r12d
    imul    eax, eax         ; i*i
    cmp     eax, r13d
    jg      .isprime         ; i*i > n -> prime

    mov     eax, r13d
    xor     edx, edx
    mov     ecx, r12d
    div     ecx              ; eax = n/i, edx = n%i
    test    edx, edx
    jz      .notprime        ; divisible -> not prime

    inc     r12d
    jmp     .loop

.isprime:
    lea     rdi, [msg_yes]
    mov     esi, r13d
    xor     eax, eax
    call    printf
    jmp     .end

.notprime:
    lea     rdi, [msg_no]
    mov     esi, r13d
    xor     eax, eax
    call    printf

.end:
    add     rsp, 16
    pop     r13
    pop     r12
    xor     eax, eax
    pop     rbp
    ret
