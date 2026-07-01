; fibonacci.asm - Print the first N Fibonacci numbers
; MASM x64, Windows
;
; Build:
;   ml64 /c fibonacci.asm
;   link fibonacci.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib

EXTERN printf:PROC
EXTERN scanf:PROC

.code

prompt  BYTE "Enter number of terms: ", 0
out_hdr BYTE "Fibonacci: ", 0
fmt_in  BYTE "%d", 0
fmt_num BYTE "%lld", 0
sp_char BYTE " ", 0
newline BYTE 10, 0

; Stack frame: push rbp + 5 extras (rbx, r12-r15) = 6 pushes total
; RSP after pushes = 16k-56 (not aligned); sub 40 => 16k-96 (aligned)
; [rsp+0..31] = shadow space   [rsp+32..35] = n (DWORD)

main PROC
    push    rbp
    mov     rbp, rsp
    push    rbx
    push    r12                         ; n
    push    r13                         ; a (current term)
    push    r14                         ; b (next term)
    push    r15                         ; i (loop index)
    sub     rsp, 40

    lea     rcx, [prompt]
    call    printf

    lea     rcx, [fmt_in]
    lea     rdx, [rsp+32]               ; &n
    call    scanf
    mov     r12d, DWORD PTR [rsp+32]    ; n

    lea     rcx, [out_hdr]
    call    printf

    xor     r13, r13                    ; a = 0
    mov     r14, 1                      ; b = 1
    xor     r15d, r15d                  ; i = 0

fib_loop:
    cmp     r15d, r12d
    jge     fib_done

    test    r15d, r15d
    jz      fib_no_space
    lea     rcx, [sp_char]
    call    printf
fib_no_space:

    lea     rcx, [fmt_num]
    mov     rdx, r13                    ; a
    call    printf

    mov     rax, r13
    add     rax, r14                    ; c = a + b
    mov     r13, r14                    ; a = b
    mov     r14, rax                    ; b = c

    inc     r15d
    jmp     fib_loop

fib_done:
    lea     rcx, [newline]
    call    printf

    xor     eax, eax
    add     rsp, 40
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     rbx
    pop     rbp
    ret
main ENDP

END
