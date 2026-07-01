; reverse_words.asm - Reverse each word in the input string
; Example: "HEllo world" -> "ollEH dlrow"
; MASM x64, Windows
;
; Build:
;   ml64 /c reverse_words.asm
;   link reverse_words.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib

EXTERN printf:PROC
EXTERN scanf:PROC

.code

prompt  BYTE "Enter string: ", 0
out_hdr BYTE "Output: ", 0
fmt_in  BYTE "%255[^", 10, "]", 0     ; reads up to 255 chars, stops at newline
fmt_wrd BYTE "%.*s", 0
sp_char BYTE " ", 0
newline BYTE 10, 0

; reverse_word: reverses bytes in buf[rcx..rdx] inclusive
; Uses only volatile registers (rax, r8) - no saves needed
reverse_word PROC
rw_loop:
    cmp     rcx, rdx
    jge     rw_done
    movzx   eax, BYTE PTR [rcx]
    movzx   r8d, BYTE PTR [rdx]
    mov     BYTE PTR [rcx], r8b
    mov     BYTE PTR [rdx], al
    inc     rcx
    dec     rdx
    jmp     rw_loop
rw_done:
    ret
reverse_word ENDP

; Stack frame for main: push rbp + 5 extras (rbx, r12-r15) = 6 pushes total
; RSP after pushes = 16k-56 (not aligned); sub 296 => 16k-352 (aligned)
; [rsp+0..31]   = shadow space
; [rsp+32..287] = line buffer (256 bytes)
; [rsp+288..295] = padding
;
; rbx = buf base pointer (= rsp+32, kept constant)
; r12 = current scan index i
; r13 = start index of current word
; r14 = word_len
; r15 = first-word flag (0 = first, 1 = subsequent)

main PROC
    push    rbp
    mov     rbp, rsp
    push    rbx
    push    r12
    push    r13
    push    r14
    push    r15
    sub     rsp, 296

    lea     rbx, [rsp+32]               ; buf base (constant throughout)

    lea     rcx, [prompt]
    call    printf

    lea     rcx, [fmt_in]
    mov     rdx, rbx                    ; buf
    call    scanf

    lea     rcx, [out_hdr]
    call    printf

    xor     r12d, r12d                  ; i = 0
    xor     r15d, r15d                  ; first = 0 (true)

word_loop:
    ; skip spaces
skip_sp:
    movzx   eax, BYTE PTR [rbx+r12]
    test    al, al
    jz      rw_exit                     ; end of string
    cmp     al, ' '
    jne     word_start
    inc     r12d
    jmp     skip_sp

word_start:
    mov     r13d, r12d                  ; start = i

    ; scan to next space or null
find_end:
    movzx   eax, BYTE PTR [rbx+r12]
    test    al, al
    jz      do_word
    cmp     al, ' '
    je      do_word
    inc     r12d
    jmp     find_end

do_word:
    ; word_len = i - start
    mov     r14d, r12d
    sub     r14d, r13d

    ; reverse the word in-place: buf[start .. i-1]
    lea     rcx, [rbx+r13]              ; left  = &buf[start]
    lea     rdx, [rbx+r12-1]            ; right = &buf[i-1]
    call    reverse_word                ; clobbers rax, r8, rcx, rdx only

    ; print space separator before all but the first word
    test    r15d, r15d
    jz      no_sep
    lea     rcx, [sp_char]
    call    printf
no_sep:
    mov     r15d, 1                     ; no longer the first word

    ; printf("%.*s", word_len, &buf[start])
    lea     rcx, [fmt_wrd]
    mov     edx, r14d                   ; precision = word_len
    lea     r8, [rbx+r13]              ; &buf[start]
    call    printf

    jmp     word_loop

rw_exit:
    lea     rcx, [newline]
    call    printf

    xor     eax, eax
    add     rsp, 296
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     rbx
    pop     rbp
    ret
main ENDP

END
