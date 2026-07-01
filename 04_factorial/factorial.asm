; factorial.asm - Compute N! iteratively (accurate up to N = 20)
; MASM x64, Windows
;
; Build:
;   ml64 /c factorial.asm
;   link factorial.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib

EXTERN printf:PROC
EXTERN scanf:PROC

.code

prompt  BYTE "Enter n (0-20): ", 0
fmt_in  BYTE "%d", 0
fmt_out BYTE "%d! = %lld", 10, 0

; Stack frame: push rbp + 3 extras (rbx, r12, r13) = 4 pushes total
; RSP after pushes = 16k-40 (not aligned); sub 40 => 16k-80 (aligned)
; [rsp+0..31] = shadow space   [rsp+32..35] = n (DWORD)

main PROC
    push    rbp
    mov     rbp, rsp
    push    rbx                         ; loop counter i
    push    r12                         ; n
    push    r13                         ; result
    sub     rsp, 40

    lea     rcx, [prompt]
    call    printf

    lea     rcx, [fmt_in]
    lea     rdx, [rsp+32]               ; &n
    call    scanf
    mov     r12d, DWORD PTR [rsp+32]    ; n

    mov     r13, 1                      ; result = 1
    mov     ebx, 2                      ; i = 2

fact_loop:
    cmp     ebx, r12d
    jg      fact_done
    imul    r13, rbx                    ; result *= i
    inc     ebx
    jmp     fact_loop

fact_done:
    lea     rcx, [fmt_out]
    mov     edx, r12d                   ; n
    mov     r8, r13                     ; result
    call    printf

    xor     eax, eax
    add     rsp, 40
    pop     r13
    pop     r12
    pop     rbx
    pop     rbp
    ret
main ENDP

END
