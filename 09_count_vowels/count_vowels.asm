; count_vowels.asm - Count vowels in a string (case-insensitive)
; Example: "Hello World" -> 3
; MASM x64, Windows
;
; Build:
;   ml64 /c count_vowels.asm
;   link count_vowels.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib

EXTERN printf:PROC
EXTERN scanf:PROC

.code

prompt  BYTE "Enter a string: ", 0
fmt_in  BYTE "%255[^", 10, "]", 0     ; reads up to 255 chars, stops at newline
fmt_out BYTE "Vowel count: %d", 10, 0

; Stack frame: push rbp + 3 extras (rbx, r12, r13) = 4 pushes total
; RSP after pushes = 16k-40 (not aligned); sub 296 => 16k-336 (aligned)
; [rsp+0..31]   = shadow space
; [rsp+32..287] = string buffer (256 bytes)
; [rsp+288..295] = padding

main PROC
    push    rbp
    mov     rbp, rsp
    push    rbx                         ; buf base pointer
    push    r12                         ; vowel count
    push    r13                         ; loop index i
    sub     rsp, 296

    lea     rbx, [rsp+32]               ; buf base (constant)

    lea     rcx, [prompt]
    call    printf

    lea     rcx, [fmt_in]
    mov     rdx, rbx                    ; buf
    call    scanf

    xor     r12d, r12d                  ; count = 0
    xor     r13d, r13d                  ; i = 0

vowel_loop:
    movzx   eax, BYTE PTR [rbx+r13]    ; c = buf[i]
    test    al, al
    jz      vowel_done                  ; end of string

    ; tolower: if 'A'-'Z', add 0x20
    cmp     al, 'A'
    jl      check_vowel
    cmp     al, 'Z'
    jg      check_vowel
    add     al, 20h                     ; to lowercase

check_vowel:
    cmp     al, 'a'
    je      is_vowel
    cmp     al, 'e'
    je      is_vowel
    cmp     al, 'i'
    je      is_vowel
    cmp     al, 'o'
    je      is_vowel
    cmp     al, 'u'
    je      is_vowel
    jmp     vowel_next

is_vowel:
    inc     r12d                        ; count++

vowel_next:
    inc     r13d
    jmp     vowel_loop

vowel_done:
    lea     rcx, [fmt_out]
    mov     edx, r12d                   ; count
    call    printf

    xor     eax, eax
    add     rsp, 296
    pop     r13
    pop     r12
    pop     rbx
    pop     rbp
    ret
main ENDP

END
