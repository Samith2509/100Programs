; sum_of_digits.asm — Sum the digits of an integer entered by the user
; Example: 1234 -> 10
; x86-64 Linux, NASM syntax
;
; Build:
;   nasm -f elf64 sum_of_digits.asm -o sum_of_digits_asm.o
;   gcc sum_of_digits_asm.o -o sum_of_digits_asm -no-pie
; Run:
;   ./sum_of_digits_asm

default rel

section .data
    prompt  db "Enter a number: ", 0
    fmt_in  db "%d", 0
    fmt_out db "Sum of digits: %d", 10, 0

section .text
    extern printf, scanf
    global main

main:
    push    rbp
    mov     rbp, rsp
    push    r12             ; sum
    sub     rsp, 8          ; n slot (stack-allocated, replaces .bss); keeps 16-byte alignment

    lea     rdi, [prompt]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_in]
    mov     rsi, rsp
    xor     eax, eax
    call    scanf
    mov     eax, [rsp]

    test    eax, eax
    jns     .pos
    neg     eax             ; handle negative: take absolute value
.pos:
    xor     r12d, r12d      ; sum = 0

.loop:
    test    eax, eax
    jz      .done
    xor     edx, edx
    mov     ecx, 10
    div     ecx             ; eax = n/10, edx = n%10
    add     r12d, edx       ; sum += digit
    jmp     .loop

.done:
    lea     rdi, [fmt_out]
    mov     esi, r12d
    xor     eax, eax
    call    printf

    add     rsp, 8
    pop     r12
    xor     eax, eax
    pop     rbp
    ret
