# A minimum GAS boilerplate that will compile and run

.intel_syntax noprefix

.section .data

# Your data here

# Function declaration for <func_name>
.text
.globl    <func_name>
.type     <func_name>, @function

<func_name>:
    # Function logic

    .size   <func_name>, .-<func_name>

.text
.globl      main
.type       main, @function

main:
    push rbp
    mov rbp, rsp

    # call <func_name>

    xor rax, rax
    mov rsp, rbp
    pop rbp
    ret

    .size       main, .-main
    .section    .note.GNU-stack,"",@progbits