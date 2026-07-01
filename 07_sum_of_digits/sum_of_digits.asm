; sum_of_digits.asm - Sum the digits of an integer entered by the user
; Example: 1234 -> 10
; MASM x64, Windows
;
; Build:
;   ml64 /c sum_of_digits.asm
;   link sum_of_digits.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib

EXTERN printf:PROC
EXTERN scanf:PROC

.code

prompt  BYTE "Enter a number: ", 0
fmt_in  BYTE "%d", 0
fmt_out BYTE "Sum of digits: %d", 10, 0

; Stack frame: push rbp + 1 extra (r12) = 2 pushes total
; RSP after pushes = 16k-24 (not aligned); sub 40 => 16k-64 (aligned)
; [rsp+0..31] = shadow space   [rsp+32..35] = n scratch (DWORD)

main PROC
    push    rbp
    mov     rbp, rsp
    push    r12                         ; sum
    sub     rsp, 40

    lea     rcx, [prompt]
    call    printf

    lea     rcx, [fmt_in]
    lea     rdx, [rsp+32]               ; &n
    call    scanf
    mov     eax, DWORD PTR [rsp+32]    ; n

    ; if n < 0, negate it
    test    eax, eax
    jns     digits_pos
    neg     eax
digits_pos:

    xor     r12d, r12d                  ; sum = 0

digits_loop:
    test    eax, eax
    jz      digits_done
    xor     edx, edx
    mov     ecx, 10
    div     ecx                         ; eax = n/10, edx = n%10
    add     r12d, edx                   ; sum += digit
    jmp     digits_loop

digits_done:
    lea     rcx, [fmt_out]
    mov     edx, r12d                   ; sum
    call    printf

    xor     eax, eax
    add     rsp, 40
    pop     r12
    pop     rbp
    ret
main ENDP

END
