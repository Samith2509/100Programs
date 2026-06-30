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
    fmt_in  db "%255[^", 10, "]", 0   ; 10 = 0x0A newline (NASM doesn't expand \n in strings)
    space   db " ", 0
    newline db 10, 0

section .bss
    buf resb 256

section .text
    extern printf, scanf
    global main

; reverse_word(rdi=start, rsi=end_inclusive)
; Swaps bytes from both ends toward the middle.
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
    push    rbx                 ; callee-saved (unused but keeps alignment tidy)
    push    r12                 ; word-start pointer
    push    r13                 ; saved delimiter byte
    push    r14                 ; current scan pointer
    push    r15                 ; first-word flag
    sub     rsp, 8              ; 16-byte stack alignment

    lea     rdi, [prompt]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_in]
    lea     rsi, [buf]
    xor     eax, eax
    call    scanf

    lea     rdi, [out_hdr]
    xor     eax, eax
    call    printf

    lea     r14, [buf]
    xor     r15d, r15d          ; 0 = first word not yet printed

.main_loop:
    movzx   eax, byte [r14]
    test    al, al
    jz      .done

    cmp     al, ' '
    jne     .found_word
    inc     r14
    jmp     .main_loop

.found_word:
    ; print space separator before every word after the first
    test    r15d, r15d
    jz      .no_sep
    lea     rdi, [space]
    xor     eax, eax
    call    printf
.no_sep:
    mov     r15d, 1

    mov     r12, r14            ; r12 = word start

    ; scan to space or end of string
.find_end:
    movzx   eax, byte [r14]
    test    al, al
    jz      .end_found
    cmp     al, ' '
    je      .end_found
    inc     r14
    jmp     .find_end

.end_found:
    movzx   r13d, byte [r14]    ; save delimiter
    mov     byte [r14], 0       ; null-terminate word temporarily

    mov     rdi, r12
    mov     rsi, r14
    dec     rsi                 ; rsi = last char of word (inclusive)
    call    reverse_word

    mov     rdi, r12            ; printf("%s", word_start)
    xor     eax, eax
    call    printf

    mov     byte [r14], r13b    ; restore delimiter
    jmp     .main_loop

.done:
    lea     rdi, [newline]
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
