; max_in_array.asm - Find the maximum value in an array entered by the user
; MASM x64, Windows
;
; Build:
;   ml64 /c max_in_array.asm
;   link max_in_array.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib

EXTERN printf:PROC
EXTERN scanf:PROC

.code

prompt_n  BYTE "Enter number of elements: ", 0
prompt_e  BYTE "Enter elements: ", 0
fmt_in    BYTE "%d", 0
fmt_out   BYTE "Maximum: %d", 10, 0

; Stack frame: push rbp + 3 extras (rbx, r12, r13) = 4 pushes total
; RSP after pushes = 16k-40 (not aligned); sub 40 => 16k-80 (aligned)
; [rsp+0..31] = shadow space   [rsp+32..35] = x scratch (DWORD)

main PROC
    push    rbp
    mov     rbp, rsp
    push    rbx                         ; loop index i
    push    r12                         ; n
    push    r13                         ; max
    sub     rsp, 40

    lea     rcx, [prompt_n]
    call    printf

    lea     rcx, [fmt_in]
    lea     rdx, [rsp+32]               ; &n scratch
    call    scanf
    mov     r12d, DWORD PTR [rsp+32]    ; n

    lea     rcx, [prompt_e]
    call    printf

    ; read first element as the initial max
    lea     rcx, [fmt_in]
    lea     rdx, [rsp+32]
    call    scanf
    mov     r13d, DWORD PTR [rsp+32]    ; max = arr[0]

    mov     ebx, 1                      ; i = 1

max_loop:
    cmp     ebx, r12d
    jge     max_done

    lea     rcx, [fmt_in]
    lea     rdx, [rsp+32]               ; &x
    call    scanf
    mov     eax, DWORD PTR [rsp+32]     ; x
    cmp     eax, r13d
    jle     max_skip
    mov     r13d, eax                   ; max = x
max_skip:
    inc     ebx
    jmp     max_loop

max_done:
    lea     rcx, [fmt_out]
    mov     edx, r13d                   ; max
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
