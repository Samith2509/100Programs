; fizzbuzz.asm — FizzBuzz from 1 to N
; x86-64 Linux, NASM syntax
;
; Build:
;   nasm -f elf64 fizzbuzz.asm -o fizzbuzz_asm.o
;   gcc fizzbuzz_asm.o -o fizzbuzz_asm -no-pie
; Run:
;   ./fizzbuzz_asm

default rel

section .data
    prompt       db "Enter N: ", 0
    fmt_in       db "%d", 0
    fizzbuzz_str db "FizzBuzz", 10, 0
    fizz_str     db "Fizz", 10, 0
    buzz_str     db "Buzz", 10, 0
    fmt_num      db "%d", 10, 0

section .bss
    n resd 1

section .text
    extern printf, scanf
    global main

main:
    push    rbp
    mov     rbp, rsp
    push    rbx             ; i
    push    r12             ; n
    ; 3 pushes total = 24 bytes: RSP = 16k-32, aligned (no sub needed)

    lea     rdi, [prompt]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_in]
    lea     rsi, [n]
    xor     eax, eax
    call    scanf
    mov     r12d, [n]

    mov     ebx, 1          ; i = 1

.loop:
    cmp     ebx, r12d
    jg      .done

    mov     eax, ebx
    xor     edx, edx
    mov     ecx, 15
    div     ecx
    test    edx, edx
    jnz     .check3
    lea     rdi, [fizzbuzz_str]
    xor     eax, eax
    call    printf
    jmp     .next

.check3:
    mov     eax, ebx
    xor     edx, edx
    mov     ecx, 3
    div     ecx
    test    edx, edx
    jnz     .check5
    lea     rdi, [fizz_str]
    xor     eax, eax
    call    printf
    jmp     .next

.check5:
    mov     eax, ebx
    xor     edx, edx
    mov     ecx, 5
    div     ecx
    test    edx, edx
    jnz     .print_num
    lea     rdi, [buzz_str]
    xor     eax, eax
    call    printf
    jmp     .next

.print_num:
    lea     rdi, [fmt_num]
    mov     esi, ebx
    xor     eax, eax
    call    printf

.next:
    inc     ebx
    jmp     .loop

.done:
    pop     r12
    pop     rbx
    xor     eax, eax
    pop     rbp
    ret
