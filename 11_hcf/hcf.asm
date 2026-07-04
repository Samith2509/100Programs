; hcf.asm — Compute the HCF (GCD) of two numbers entered by the user
; Example: 12, 18 -> HCF: 6
; x86-64 Linux, NASM syntax
;
; Build:
;   nasm -f elf64 hcf.asm -o hcf_asm.o
;   gcc hcf_asm.o -o hcf_asm -no-pie
; Run:
;   ./hcf_asm

default rel

section .data
    prompt   db "Enter two numbers: ", 0
    fmt_in2  db "%d %d", 0
    fmt_out  db "HCF: %d", 10, 0

section .text
    extern printf, scanf
    global main

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 16         ; a/b input slots (stack-allocated, replaces .bss)

    lea     rdi, [prompt]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_in2]
    lea     rsi, [rsp]
    lea     rdx, [rsp+4]
    xor     eax, eax
    call    scanf

    mov     r8d, [rsp]       ; x = a
    mov     r9d, [rsp+4]     ; y = b
.gcd_loop:
    test    r9d, r9d
    jz      .gcd_done
    mov     eax, r8d
    xor     edx, edx
    div     r9d              ; edx = x % y
    mov     r8d, r9d         ; x = y
    mov     r9d, edx         ; y = x % y
    jmp     .gcd_loop
.gcd_done:                   ; hcf = r8d

    lea     rdi, [fmt_out]
    mov     esi, r8d         ; hcf
    xor     eax, eax
    call    printf

    add     rsp, 16
    xor     eax, eax
    pop     rbp
    ret
