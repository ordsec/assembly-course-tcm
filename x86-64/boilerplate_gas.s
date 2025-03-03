# A minimum GAS boilerplate that will compile and run

.intel_syntax noprefix

# .section .data

# Your data here

# Function header
# .text
# .globl    <func_name>
# .type     <func_name>, @function

.text
.globl      main
.type       main, @function

main:
    push rbp
    mov rbp, rsp

    xor rax, rax
    mov rsp, rbp
    pop rbp
    ret

    .size       main, .-main
    .section    .note.GNU-stack,"",@progbits