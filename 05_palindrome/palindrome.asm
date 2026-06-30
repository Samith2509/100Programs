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

section .bss
    buf resb 256

section .text
    extern printf, scanf, strlen
    global main

main:
    push    rbp
    mov     rbp, rsp
    push    rbx             ; left pointer
    push    r12             ; string length
    push    r13             ; right pointer
    sub     rsp, 8          ; 16-byte alignment:
                            ;   push rbp(8)+rbx(8)+r12(8)+r13(8) = 32; sub 8 → 16n-48 (aligned)

    lea     rdi, [prompt]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_in]
    lea     rsi, [buf]
    xor     eax, eax
    call    scanf

    lea     rdi, [buf]
    call    strlen
    mov     r12, rax        ; r12 = length

    lea     rbx, [buf]      ; rbx = left  (start of string)
    lea     r13, [buf]
    add     r13, r12
    dec     r13             ; r13 = right (last char of string)

.check:
    cmp     rbx, r13
    jge     .yes            ; pointers crossed: all chars matched
    movzx   eax, byte [rbx]
    movzx   ecx, byte [r13]
    cmp     eax, ecx
    jne     .no
    inc     rbx
    dec     r13
    jmp     .check

.yes:
    lea     rdi, [yes_msg]
    lea     rsi, [buf]
    xor     eax, eax
    call    printf
    jmp     .exit

.no:
    lea     rdi, [no_msg]
    lea     rsi, [buf]
    xor     eax, eax
    call    printf

.exit:
    add     rsp, 8
    pop     r13
    pop     r12
    pop     rbx
    xor     eax, eax
    pop     rbp
    ret
