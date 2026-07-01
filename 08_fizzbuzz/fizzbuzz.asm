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

section .text
    extern printf, scanf
    global main

main:
    push    rbp
    mov     rbp, rsp
    push    rbx             ; i
    push    r12             ; n
    sub     rsp, 16         ; n slot (stack-allocated, replaces .bss); keeps 16-byte alignment

    lea     rdi, [prompt]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_in]
    mov     rsi, rsp
    xor     eax, eax
    call    scanf
    mov     r12d, [rsp]

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
    add     rsp, 16
    pop     r12
    pop     rbx
    xor     eax, eax
    pop     rbp
    ret
