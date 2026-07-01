; palindrome.asm - Check whether a word is a palindrome (case-sensitive)
; MASM x64, Windows
;
; Build:
;   ml64 /c palindrome.asm
;   link palindrome.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib

EXTERN printf:PROC
EXTERN scanf:PROC
EXTERN strlen:PROC

.code

prompt  BYTE "Enter a word: ", 0
fmt_in  BYTE "%255s", 0
fmt_yes BYTE '"', "%s", '"', " is a palindrome.", 10, 0
fmt_no  BYTE '"', "%s", '"', " is not a palindrome.", 10, 0

; Stack frame: push rbp + 3 extras (rbx, r12, r13) = 4 pushes total
; RSP after pushes = 16k-40 (not aligned); sub 296 => 16k-336 (aligned)
; [rsp+0..31]   = shadow space
; [rsp+32..287] = word buffer (256 bytes)
; [rsp+288..295] = padding

main PROC
    push    rbp
    mov     rbp, rsp
    push    rbx                         ; left index
    push    r12                         ; string length
    push    r13                         ; right index
    sub     rsp, 296

    lea     rcx, [prompt]
    call    printf

    lea     rcx, [fmt_in]
    lea     rdx, [rsp+32]               ; buf
    call    scanf

    lea     rcx, [rsp+32]               ; strlen(buf)
    call    strlen
    mov     r12, rax                    ; length

    xor     ebx, ebx                    ; left = 0
    lea     r13, [r12-1]                ; right = length - 1

palin_check:
    cmp     rbx, r13
    jge     palin_yes                   ; pointers crossed: palindrome

    lea     rax, [rsp+32]               ; buf base
    movzx   ecx, BYTE PTR [rax+rbx]    ; buf[left]
    movzx   edx, BYTE PTR [rax+r13]    ; buf[right]
    cmp     ecx, edx
    jne     palin_no
    inc     rbx
    dec     r13
    jmp     palin_check

palin_yes:
    lea     rcx, [fmt_yes]
    lea     rdx, [rsp+32]               ; buf
    call    printf
    jmp     palin_exit

palin_no:
    lea     rcx, [fmt_no]
    lea     rdx, [rsp+32]               ; buf
    call    printf

palin_exit:
    xor     eax, eax
    add     rsp, 296
    pop     r13
    pop     r12
    pop     rbx
    pop     rbp
    ret
main ENDP

END
