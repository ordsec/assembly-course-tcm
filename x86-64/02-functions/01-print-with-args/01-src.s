# This version is with args being passed in via registers,
# values are still hard-coded.

.intel_syntax noprefix

# Declare the data
.text
.section .rodata

.align 4
.type length,        @object
.size length,        4

length:
    .long            14

.type message,       @object
message:
    .string "Hello, world!\n"

# Declare the printstr function
.text
.globl    printstr
.type     printstr, @function

# printstr function logic

# Register call order: rdi, rsi, rdx, rcx, r8, r9
# Important point is that's the order they're called
# by the CPU, but we're free to pass things around
# in whatever order we choose, as long as everything
# is in the proper register and nothing gets overwritten
# in the process.

# printstr will be receiving two arguments
# (pointer to where string starts and its length)

# print(char *strToPrint, int length)

# In this version, we're simply receiving these
# via registers
printstr:
    push rbp
    mov rbp, rsp

    # Write to screen - get 2nd arg, then 1st
    # The order is such because rsi needs to be preserved
    # as it'll be used to store the string pointer
    mov edx, esi            # Receive length from esi  
    mov rsi, rdi            # Receive ptr to beginning of string 
                            # from rdi. We don't need lea here
    mov rax, 0x01           # Write syscall - 0x01
    mov rdi, 1              # fd - STDOUT (1)
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

    mov esi, DWORD PTR length[rip]      # Pass 2nd arg
    lea rdi, message[rip]               # Pass 1st arg
    call printstr

    mov rsp, rbp
    pop rbp
    ret

    .size       main, .-main
    .section    .note.GNU-stack,"",@progbits
