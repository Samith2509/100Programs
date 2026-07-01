; palindrome.asm — Check whether a word is a palindrome
; Compares characters from both ends toward the centre.
; x86-64 Linux, NASM syntax
;
; Build:
;   nasm -f elf64 palindrome.asm -o palindrome_asm.o
;   gcc palindrome_asm.o -o palindrome_asm -no-pie
; Run:
;   ./palindrome_asm

default rel

section .data
    prompt  db "Enter a word: ", 0
    fmt_in  db "%255s", 0
    yes_msg db '"%s" is a palindrome.', 10, 0
    no_msg  db '"%s" is not a palindrome.', 10, 0

section .text
    extern printf, scanf, strlen
    global main

main:
    push    rbp
    mov     rbp, rsp
    push    rbx             ; left pointer
    push    r12             ; string length
    push    r13             ; right pointer
    push    r14             ; buffer base (stack-allocated, replaces .bss)
    sub     rsp, 256        ; 256-byte input buffer

    mov     r14, rsp

    lea     rdi, [prompt]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_in]
    mov     rsi, r14
    xor     eax, eax
    call    scanf

    mov     rdi, r14
    call    strlen
    mov     r12, rax

    mov     rbx, r14
    lea     r13, [r14]
    add     r13, r12
    dec     r13

.check:
    cmp     rbx, r13
    jge     .yes
    movzx   eax, byte [rbx]
    movzx   ecx, byte [r13]
    cmp     eax, ecx
    jne     .no
    inc     rbx
    dec     r13
    jmp     .check

.yes:
    lea     rdi, [yes_msg]
    mov     rsi, r14
    xor     eax, eax
    call    printf
    jmp     .exit

.no:
    lea     rdi, [no_msg]
    mov     rsi, r14
    xor     eax, eax
    call    printf

.exit:
    add     rsp, 256
    pop     r14
    pop     r13
    pop     r12
    pop     rbx
    xor     eax, eax
    pop     rbp
    ret
