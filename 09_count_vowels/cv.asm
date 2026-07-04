default rel

section .data
    a db "Enter a:",0
    b db "Enter b:",0
    fin db "%d",0
    nl db 10,0
    op db "LCM:",0
    op2 db "HCF:",0

section .text
    global main
    extern printf,scanf
main:
    push rbp
    mov rbp,rsp
    push rbx
    push r12
    push r13
    push r14
    
    sub rsp, 16
    lea rdi,[a]
    xor eax,eax
    call printf

    mov rbx,rsp
    lea rdi,[fin]
    mov rsi,rbx
    xor eax,eax
    call scanf

    lea rdi,[b]
    xor eax,eax
    call printf

    lea r12,[rbx+8]
    lea rdi,[fin]
    mov rsi,r12
    xor eax,eax
    call scanf

    lea rdi,[op2]
    xor eax,eax
    call printf

    mov r13d,[rbx]
    mov r14d,[r12]
    ;test r13d,r13d
    ;jnz .loop

    .loop:
        test r14d,r14d
        jz .hcf
        mov eax, r13d
        xor edx,edx
        mov ecx,r14d
        div ecx
        mov r13d,r14d
        mov r14d,edx
        jmp .loop
        
        
        
    .hcf:
        lea rdi,[fin]
        mov esi, r13dby7
        xor eax,eax
        call printf
        mov rdi,nl
        xor eax,eax
        call printf

        lea rdi, [op]
        xor eax,eax
        call printf
        test r13d,r13d
        jz .zero
        mov eax,[rbx]
        xor edx,edx
        mov ecx,r13d
        div ecx
        
        mov ecx,[r12]

        mul ecx
        .zero:
            xor eax,eax
        .print:
        lea rdi,[fin]
        mov esi,eax
        xor eax,eax
        call printf
        .end:
        add rsp,16
        pop r14
        pop r13
        pop r12
        pop rbx
        pop rbp
        ret


