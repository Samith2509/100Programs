; reverse_number.asm — Reverse the digits of an integer entered by the user
; Negative numbers keep their sign. Example: 1234 -> 4321, -57 -> -75
; x86-64 Linux, NASM syntax
;
; Build:
;   nasm -f elf64 reverse_number.asm -o reverse_number_asm.o
;   gcc reverse_number_asm.o -o reverse_number_asm -no-pie
; Run:
;   ./reverse_number_asm

default rel

section .data
    prompt  db "Enter a number: ", 0
    fmt_in  db "%d", 0
    fmt_out db "Reversed: %d", 10, 0

section .text
    extern printf, scanf
    global main

main:
    push    rbp
    mov     rbp, rsp
    push    r12             ; sign flag (0 = positive, 1 = negative)
    sub     rsp, 8          ; n slot (stack-allocated, replaces .bss); keeps 16-byte alignment

    lea     rdi, [prompt]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_in]
    mov     rsi, rsp
    xor     eax, eax
    call    scanf
    mov     eax, [rsp]

    xor     r12d, r12d      ; sign = positive
    test    eax, eax
    jns     .pos
    mov     r12d, 1         ; remember it was negative
    neg     eax             ; work with absolute value
.pos:
    xor     r8d, r8d        ; rev = 0

.loop:
    test    eax, eax
    jz      .done
    xor     edx, edx
    mov     ecx, 10
    div     ecx             ; eax = n/10, edx = n%10
    imul    r8d, r8d, 10    ; rev *= 10
    add     r8d, edx        ; rev += digit
    jmp     .loop

.done:
    test    r12d, r12d      ; restore sign
    jz      .print
    neg     r8d
.print:
    lea     rdi, [fmt_out]
    mov     esi, r8d
    xor     eax, eax
    call    printf

    add     rsp, 8
    pop     r12
    xor     eax, eax
    pop     rbp
    ret
