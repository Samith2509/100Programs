; divisibility_check.asm - Adjacent-pair divisibility check
; For each pair (arr[i], arr[i+1]):
;   1 if arr[i]   % arr[i+1] == 0
;   2 if arr[i+1] % arr[i]   == 0
;   0 otherwise
; MASM x64, Windows
;
; Build:
;   ml64 /c divisibility_check.asm
;   link divisibility_check.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib

EXTERN printf:PROC
EXTERN scanf:PROC

.code

prompt_n   BYTE "Enter number of elements: ", 0
prompt_arr BYTE "Enter elements: ", 0
fmt_in     BYTE "%d", 0
out_start  BYTE "Output: [", 0
sep        BYTE ", ", 0
out_end    BYTE "]", 10, 0

; Stack frame: push rbp + 3 extras (rbx, r12, r13) = 4 pushes total
; RSP after pushes = 16k-40 (not aligned); sub 440 => 16k-480 (aligned)
; [rsp+0..31]   = shadow space
; [rsp+32..431] = arr[100] (100 x DWORD = 400 bytes)
; [rsp+432..435] = n scratch (DWORD)
; [rsp+436..439] = padding

main PROC
    push    rbp
    mov     rbp, rsp
    push    rbx                         ; loop index i
    push    r12                         ; n
    push    r13                         ; result (0/1/2)
    sub     rsp, 440

    lea     rcx, [prompt_n]
    call    printf

    lea     rcx, [fmt_in]
    lea     rdx, [rsp+432]              ; &n scratch
    call    scanf
    mov     r12d, DWORD PTR [rsp+432]  ; n

    lea     rcx, [prompt_arr]
    call    printf

    xor     ebx, ebx                    ; i = 0
read_loop:
    cmp     ebx, r12d
    jge     read_done
    lea     rcx, [fmt_in]
    lea     rdx, [rsp + rbx*4 + 32]    ; &arr[i]
    call    scanf
    inc     ebx
    jmp     read_loop
read_done:

    lea     rcx, [out_start]
    call    printf

    xor     ebx, ebx                    ; i = 0
div_loop:
    mov     eax, r12d
    dec     eax                         ; n - 1
    cmp     ebx, eax
    jge     div_done                    ; i >= n-1: stop

    ; print ", " for every pair after the first
    test    ebx, ebx
    jz      div_no_sep
    lea     rcx, [sep]
    call    printf
div_no_sep:

    ; load a = arr[i], b = arr[i+1]  (use volatile r10/r11)
    mov     r10d, DWORD PTR [rsp + rbx*4 + 32]  ; a
    mov     r11d, DWORD PTR [rsp + rbx*4 + 36]  ; b

    ; Case 1: b != 0 && a % b == 0  -> result = 1
    test    r11d, r11d
    jz      div_try2
    mov     eax, r10d
    cdq
    idiv    r11d
    test    edx, edx
    jnz     div_try2
    mov     r13d, 1
    jmp     div_print

div_try2:
    ; Case 2: a != 0 && b % a == 0  -> result = 2
    test    r10d, r10d
    jz      div_case0
    mov     eax, r11d
    cdq
    idiv    r10d
    test    edx, edx
    jnz     div_case0
    mov     r13d, 2
    jmp     div_print

div_case0:
    mov     r13d, 0

div_print:
    lea     rcx, [fmt_in]               ; "%d" reused for output
    mov     edx, r13d
    call    printf

    inc     ebx
    jmp     div_loop

div_done:
    lea     rcx, [out_end]
    call    printf

    xor     eax, eax
    add     rsp, 440
    pop     r13
    pop     r12
    pop     rbx
    pop     rbp
    ret
main ENDP

END
