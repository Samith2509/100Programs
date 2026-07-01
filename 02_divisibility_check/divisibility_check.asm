; divisibility_check.asm — Adjacent-pair divisibility check
; For each pair (arr[i], arr[i+1]):
;   1 if arr[i]   % arr[i+1] == 0
;   2 if arr[i+1] % arr[i]   == 0
;   0 otherwise
;
; Build:
;   nasm -f elf64 divisibility_check.asm -o divisibility_check_asm.o
;   gcc divisibility_check_asm.o -o divisibility_check_asm -no-pie
; Run:
;   ./divisibility_check_asm

default rel

section .data
    prompt_n    db "Enter number of elements: ", 0
    prompt_arr  db "Enter elements: ", 0
    fmt_int     db "%d", 0
    out_start   db "Output: [", 0
    sep         db ", ", 0
    out_end     db "]", 10, 0

section .bss
    n       resd 1
    arr     resd 100

section .text
    extern printf, scanf
    global main

main:
    push    rbp
    mov     rbp, rsp
    push    rbx
    push    r12             ; loop index i
    push    r13             ; first-pair flag
    push    r14             ; result (0/1/2)
    push    r15             ; n
    sub     rsp, 8

    lea     rdi, [prompt_n]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_int]
    lea     rsi, [n]
    xor     eax, eax
    call    scanf
    mov     r15d, [n]

    lea     rdi, [prompt_arr]
    xor     eax, eax
    call    printf

    xor     r12d, r12d
.read_loop:
    cmp     r12d, r15d
    jge     .read_done
    lea     rcx, [arr]
    lea     rsi, [rcx + r12*4]
    lea     rdi, [fmt_int]
    xor     eax, eax
    call    scanf
    inc     r12d
    jmp     .read_loop
.read_done:

    lea     rdi, [out_start]
    xor     eax, eax
    call    printf

    xor     r12d, r12d
    xor     r13d, r13d

.out_loop:
    mov     eax, r15d
    dec     eax
    cmp     r12d, eax
    jge     .out_done

    test    r13d, r13d
    jz      .no_sep
    lea     rdi, [sep]
    xor     eax, eax
    call    printf
.no_sep:
    mov     r13d, 1

    lea     rax, [arr]
    mov     r8d, [rax + r12*4]
    mov     r9d, [rax + r12*4 + 4]

    test    r9d, r9d
    jz      .try2
    mov     eax, r8d
    cdq
    idiv    r9d
    test    edx, edx
    jnz     .try2
    mov     r14d, 1
    jmp     .print

.try2:
    test    r8d, r8d
    jz      .case0
    mov     eax, r9d
    cdq
    idiv    r8d
    test    edx, edx
    jnz     .case0
    mov     r14d, 2
    jmp     .print

.case0:
    mov     r14d, 0

.print:
    lea     rdi, [fmt_int]
    mov     esi, r14d
    xor     eax, eax
    call    printf

    inc     r12d
    jmp     .out_loop

.out_done:
    lea     rdi, [out_end]
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
