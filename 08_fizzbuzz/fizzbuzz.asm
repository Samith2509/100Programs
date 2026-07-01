; fizzbuzz.asm - FizzBuzz from 1 to N
; MASM x64, Windows
;
; Build:
;   ml64 /c fizzbuzz.asm
;   link fizzbuzz.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib

EXTERN printf:PROC
EXTERN scanf:PROC

.code

prompt      BYTE "Enter N: ", 0
fmt_in      BYTE "%d", 0
str_fizzbuzz BYTE "FizzBuzz", 10, 0
str_fizz    BYTE "Fizz", 10, 0
str_buzz    BYTE "Buzz", 10, 0
fmt_num     BYTE "%d", 10, 0

; Stack frame: push rbp + 2 extras (rbx, r12) = 3 pushes total
; RSP after pushes = 16k-32 (aligned); sub 48 => 16k-80 (aligned)
; [rsp+0..31] = shadow space   [rsp+32..35] = n scratch (DWORD)

main PROC
    push    rbp
    mov     rbp, rsp
    push    rbx                         ; i (loop counter)
    push    r12                         ; n
    sub     rsp, 48

    lea     rcx, [prompt]
    call    printf

    lea     rcx, [fmt_in]
    lea     rdx, [rsp+32]               ; &n
    call    scanf
    mov     r12d, DWORD PTR [rsp+32]   ; n

    mov     ebx, 1                      ; i = 1

fizz_loop:
    cmp     ebx, r12d
    jg      fizz_done

    ; check i % 15 == 0 -> FizzBuzz
    mov     eax, ebx
    xor     edx, edx
    mov     ecx, 15
    div     ecx
    test    edx, edx
    jnz     check3
    lea     rcx, [str_fizzbuzz]
    call    printf
    jmp     fizz_next

check3:
    ; check i % 3 == 0 -> Fizz
    mov     eax, ebx
    xor     edx, edx
    mov     ecx, 3
    div     ecx
    test    edx, edx
    jnz     check5
    lea     rcx, [str_fizz]
    call    printf
    jmp     fizz_next

check5:
    ; check i % 5 == 0 -> Buzz
    mov     eax, ebx
    xor     edx, edx
    mov     ecx, 5
    div     ecx
    test    edx, edx
    jnz     print_num
    lea     rcx, [str_buzz]
    call    printf
    jmp     fizz_next

print_num:
    lea     rcx, [fmt_num]
    mov     edx, ebx                    ; i
    call    printf

fizz_next:
    inc     ebx
    jmp     fizz_loop

fizz_done:
    xor     eax, eax
    add     rsp, 48
    pop     r12
    pop     rbx
    pop     rbp
    ret
main ENDP

END
