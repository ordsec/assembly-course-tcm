.intel_syntax noprefix

# Declare the data
.text
.section .rodata

.type message,       @object
message:
    .string "Hello, world!\n"
    .equ length, .-message - 1

# Declare the printstr function
.text
.globl    printstr
.type     printstr, @function

# printstr function logic
printstr:
    push rbp
    mov rbp, rsp

    # Write to screen
    mov rax, 0x01           # Write syscall - 0x01
    mov rdi, 1              # fd - STDOUT (1)
    lea rsi, message[rip]
    mov rdx, length
    syscall

    # Check if bytes were written
    cmp rax, 0
    # If not (rax will have a negative value),
    # return that value, which will be an error code
    jl return

    # Otherwise, zero out rax
    xor rax, rax

    return:
        mov rsp, rbp
        pop rbp
        ret

    .size       printstr, .-printstr

# Declare main
.text
.globl      main
.type       main, @function

main:
    push rbp
    mov rbp, rsp

    # The only thing that happens here is
    # calling `printstr`
    call printstr

    mov rsp, rbp
    pop rbp
    ret

    .size       main, .-main
    .section    .note.GNU-stack,"",@progbits
