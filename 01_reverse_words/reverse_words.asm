; reverse_words.asm — Reverse each word in the input string
; x86-64 Linux, NASM syntax, links against libc
;
; Build:
;   nasm -f elf64 reverse_words.asm -o reverse_words_asm.o
;   gcc reverse_words_asm.o -o reverse_words_asm -no-pie
; Run:
;   ./reverse_words_asm

default rel

section .data
    prompt  db "Enter string: ", 0
    out_hdr db "Output: ", 0
    fmt_in  db "%255[^", 10, "]", 0
    space   db " ", 0
    newline db 10, 0

section .text
    extern printf, scanf
    global main

; reverse_word(rdi=start, rsi=end_inclusive)
reverse_word:
.loop:
    cmp     rdi, rsi
    jge     .done
    movzx   eax, byte [rdi]
    movzx   ecx, byte [rsi]
    mov     byte [rdi], cl
    mov     byte [rsi], al
    inc     rdi
    dec     rsi
    jmp     .loop
.done:
    ret

main:
    push    rbp
    mov     rbp, rsp
    push    rbx             ; buffer base (stack-allocated, replaces .bss)
    push    r12             ; word-start pointer
    push    r13             ; saved delimiter byte
    push    r14             ; current scan pointer
    push    r15             ; first-word flag
    sub     rsp, 264        ; 256-byte input buffer, keeps rsp 16-byte aligned

    mov     rbx, rsp

    lea     rdi, [prompt]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_in]
    mov     rsi, rbx
    xor     eax, eax
    call    scanf

    lea     rdi, [out_hdr]
    xor     eax, eax
    call    printf

    mov     r14, rbx
    xor     r15d, r15d

.main_loop:
    movzx   eax, byte [r14]
    test    al, al
    jz      .done

    cmp     al, ' '
    jne     .found_word
    inc     r14
    jmp     .main_loop

.found_word:
    test    r15d, r15d
    jz      .no_sep
    lea     rdi, [space]
    xor     eax, eax
    call    printf
.no_sep:
    mov     r15d, 1

    mov     r12, r14

.find_end:
    movzx   eax, byte [r14]
    test    al, al
    jz      .end_found
    cmp     al, ' '
    je      .end_found
    inc     r14
    jmp     .find_end

.end_found:
    movzx   r13d, byte [r14]
    mov     byte [r14], 0

    mov     rdi, r12
    mov     rsi, r14
    dec     rsi
    call    reverse_word

    mov     rdi, r12
    xor     eax, eax
    call    printf

    mov     byte [r14], r13b
    jmp     .main_loop

.done:
    lea     rdi, [newline]
    xor     eax, eax
    call    printf

    add     rsp, 264
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     rbx
    xor     eax, eax
    pop     rbp
    ret
