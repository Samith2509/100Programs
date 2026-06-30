; max_in_array.asm — Find the maximum value in an array
; x86-64 Linux, NASM syntax, links against libc
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

section .bss
    n   resd 1
    arr resd 100        ; supports up to 100 elements

section .text
    extern printf, scanf
    global main

main:
    push    rbp
    mov     rbp, rsp
    push    rbx             ; loop index i
    push    r12             ; n
    push    r13             ; current max
    sub     rsp, 8          ; 16-byte alignment

    ; read n
    lea     rdi, [prompt_n]
    xor     eax, eax
    call    printf

    lea     rdi, [fmt_int]
    lea     rsi, [n]
    xor     eax, eax
    call    scanf
    mov     r12d, [n]

    ; read array elements
    lea     rdi, [prompt_arr]
    xor     eax, eax
    call    printf

    xor     ebx, ebx
.read_loop:
    cmp     ebx, r12d
    jge     .read_done
    lea     rcx, [arr]
    lea     rsi, [rcx + rbx*4]
    lea     rdi, [fmt_int]
    xor     eax, eax
    call    scanf
    inc     ebx
    jmp     .read_loop
.read_done:

    ; max = arr[0]
    lea     rax, [arr]
    mov     r13d, [rax]

    ; loop from index 1, update max if arr[i] > max
    mov     ebx, 1
.max_loop:
    cmp     ebx, r12d
    jge     .max_done
    lea     rax, [arr]
    mov     ecx, [rax + rbx*4]
    cmp     ecx, r13d
    jle     .no_update
    mov     r13d, ecx
.no_update:
    inc     ebx
    jmp     .max_loop
.max_done:

    ; print result
    lea     rdi, [fmt_out]
    mov     esi, r13d
    xor     eax, eax
    call    printf

    add     rsp, 8
    pop     r13
    pop     r12
    pop     rbx
    xor     eax, eax
    pop     rbp
    ret
