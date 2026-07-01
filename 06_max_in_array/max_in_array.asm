; max_in_array.asm — Find the maximum value in an array
; x86-64 Linux, NASM syntax
;
; Build:
;   nasm -f elf64 max_in_array.asm -o max_in_array_asm.o
;   gcc max_in_array_asm.o -o max_in_array_asm -no-pie
; Run:
;   ./max_in_array_asm

default rel

section .data
    prompt_n    db "Enter number of elements: ", 0
    prompt_arr  db "Enter elements: ", 0
    fmt_int     db "%d", 0
    fmt_out     db "Maximum: %d", 10, 0

section .text
    extern printf, scanf
    global main

main:
    push    rbp
    mov     rbp, rsp
    push    rbx             ; loop index i
    push    r12             ; n
    push    r13             ; current max
    push    r14             ; array base (stack-allocated, replaces .bss)
    sub     rsp, 416        ; arr[100] (400 bytes) + n (4 bytes), 16-byte aligned

    mov     r14, rsp        ; r14 -> arr[0..99]

    lea     rdi, [prompt_n]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_int]
    lea     rsi, [r14+400]
    xor     eax, eax
    call    scanf
    mov     r12d, [r14+400]

    lea     rdi, [prompt_arr]
    xor     eax, eax
    call    printf

    xor     ebx, ebx
.read_loop:
    cmp     ebx, r12d
    jge     .read_done
    lea     rsi, [r14 + rbx*4]
    lea     rdi, [fmt_int]
    xor     eax, eax
    call    scanf
    inc     ebx
    jmp     .read_loop
.read_done:

    mov     r13d, [r14]

    mov     ebx, 1
.max_loop:
    cmp     ebx, r12d
    jge     .max_done
    mov     ecx, [r14 + rbx*4]
    cmp     ecx, r13d
    jle     .no_update
    mov     r13d, ecx
.no_update:
    inc     ebx
    jmp     .max_loop
.max_done:

    lea     rdi, [fmt_out]
    mov     esi, r13d
    xor     eax, eax
    call    printf

    add     rsp, 416
    pop     r14
    pop     r13
    pop     r12
    pop     rbx
    xor     eax, eax
    pop     rbp
    ret
