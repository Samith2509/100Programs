default rel

global main

extern printf,scanf


section .data

prompt      db "Enter string: ",0
out_hdr     db "Output: ",0
fmt_in      db "%255[^",10,"]",0
fmt_wrd     db "%.*s",0
space        db " ",0
newline     db 10,0

section .text

reverse_word:

.loop:
    cmp rdi,rsi
    jge .done

    mov al,[rdi]
    mov r8b,[rsi]

    mov [rdi],r8b
    mov [rsi],al

    inc rdi
    dec rsi
    jmp .loop

.done:
    ret

main:

    push rbp
    mov rbp,rsp

    push rbx
    push r12
    push r13
    push r14
    push r15

    sub rsp,296

    lea rbx,[rsp+32]

    lea rdi,[prompt]
    xor eax,eax
    call printf

    lea rdi,[fmt_in]
    mov rsi,rbx
    xor eax,eax
    call scanf

    lea rdi,[out_hdr]
    xor eax,eax
    call printf

    xor r12d,r12d
    xor r15d,r15d

word_loop:

skip_spaces:

    mov al,[rbx+r12]

    test al,al
    jz program_end

    cmp al,' '
    jne word_start

    inc r12
    jmp skip_spaces

word_start:

    mov r13,r12

find_end:

    mov al,[rbx+r12]

    test al,al
    jz process_word

    cmp al,' '
    je process_word

    inc r12
    jmp find_end

process_word:

    mov r14,r12
    sub r14,r13

    lea rdi,[rbx+r13]
    lea rsi,[rbx+r12-1]

    call reverse_word
    test r15d,r15d
    jz no_space

    lea rdi,[space]
    xor eax,eax
    call printf

no_space:

    mov r15d,1

    lea rdi,[fmt_wrd]
    mov esi,r14d
    lea rdx,[rbx+r13]
    xor eax,eax
    call printf

    jmp word_loop

program_end:

    lea rdi,[newline]
    xor eax,eax
    call printf

    xor eax,eax

    add rsp,296

    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx

    pop rbp

    ret