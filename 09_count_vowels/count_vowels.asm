; count_vowels.asm — Count vowels in a string (case-insensitive)
; Example: "Hello World" -> 3
; x86-64 Linux, NASM syntax
;
; Build:
;   nasm -f elf64 count_vowels.asm -o count_vowels_asm.o
;   gcc count_vowels_asm.o -o count_vowels_asm -no-pie
; Run:
;   ./count_vowels_asm

default rel

section .data
    prompt  db "Enter a string: ", 0
    fmt_in  db "%255[^", 10, "]", 0
    fmt_out db "Vowel count: %d", 10, 0

section .bss
    buf resb 256

section .text
    extern printf, scanf
    global main

main:
    push    rbp
    mov     rbp, rsp
    push    rbx             ; i (index)
    push    r12             ; count
    ; 3 pushes total = 24 bytes: RSP = 16k-32, aligned (no sub needed)

    lea     rdi, [prompt]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_in]
    lea     rsi, [buf]
    xor     eax, eax
    call    scanf

    xor     ebx, ebx        ; i = 0
    xor     r12d, r12d      ; count = 0

.loop:
    lea     rax, [buf]
    movzx   eax, byte [rax + rbx]
    test    al, al
    jz      .done

    cmp     al, 'A'
    jl      .check
    cmp     al, 'Z'
    jg      .check
    add     al, 32          ; to lowercase

.check:
    cmp     al, 'a'
    je      .vowel
    cmp     al, 'e'
    je      .vowel
    cmp     al, 'i'
    je      .vowel
    cmp     al, 'o'
    je      .vowel
    cmp     al, 'u'
    je      .vowel
    jmp     .next

.vowel:
    inc     r12d

.next:
    inc     ebx
    jmp     .loop

.done:
    lea     rdi, [fmt_out]
    mov     esi, r12d
    xor     eax, eax
    call    printf

    pop     r12
    pop     rbx
    xor     eax, eax
    pop     rbp
    ret
