; gcd_lcm.asm — Compute the GCD and LCM of two numbers entered by the user
; Example: 12, 18 -> GCD: 6, LCM: 36
; x86-64 Linux, NASM syntax
;
; Build:
;   nasm -f elf64 gcd_lcm.asm -o gcd_lcm_asm.o
;   gcc gcd_lcm_asm.o -o gcd_lcm_asm -no-pie
; Run:
;   ./gcd_lcm_asm

default rel

section .data
    prompt   db "Enter two numbers: ", 0
    fmt_in2  db "%d %d", 0
    fmt_out  db "GCD: %d", 10, "LCM: %d", 10, 0

section .text
    extern printf, scanf
    global main

main:
    push    rbp
    mov     rbp, rsp
    push    r12             ; a
    push    r13             ; b
    sub     rsp, 16         ; a/b input slots (stack-allocated, replaces .bss)

    lea     rdi, [prompt]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_in2]
    lea     rsi, [rsp]
    lea     rdx, [rsp+4]
    xor     eax, eax
    call    scanf

    mov     r12d, [rsp]      ; a
    mov     r13d, [rsp+4]    ; b

    mov     r8d, r12d        ; x = a
    mov     r9d, r13d        ; y = b
.gcd_loop:
    test    r9d, r9d
    jz      .gcd_done
    mov     eax, r8d
    xor     edx, edx
    div     r9d              ; edx = x % y
    mov     r8d, r9d         ; x = y
    mov     r9d, edx         ; y = x % y
    jmp     .gcd_loop
.gcd_done:                   ; gcd = r8d

    xor     r10d, r10d       ; lcm = 0
    test    r8d, r8d
    jz      .lcm_done
    mov     eax, r12d        ; a
    xor     edx, edx
    div     r8d              ; eax = a / gcd
    imul    eax, r13d        ; * b
    mov     r10d, eax
.lcm_done:

    lea     rdi, [fmt_out]
    mov     esi, r8d         ; gcd
    mov     edx, r10d        ; lcm
    xor     eax, eax
    call    printf

    add     rsp, 16
    pop     r13
    pop     r12
    xor     eax, eax
    pop     rbp
    ret
