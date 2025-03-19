# This version is with args being passed in via a stack frame,
# Length is now dynamically calculated.

.intel_syntax noprefix

# Declare the data
.text
.section .rodata

# First, the string
.type message,       @object
message:
    .string "Hello, world!\n"

# Then its length. Here we need an alignment because
# the string may not be naturally aligned (and we don't
# wanna have to worry about it)
.align 4
.type length,        @object
.size length,        4

# Declare it as a dword, then calculate the length dynamically
# like an absolute chad. -1 subtracts the null terminator.
length:
    .long            .-message - 1

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

# In this version, we're using a stack frame
printstr:
    push rbp
    mov rbp, rsp

    # In compiled languages, any declared local variable
    # (as opposed to global) is essentially creating 
    # empty space on the stack and filling it with data

    # To create this space, we SUBTRACT from the stack pointer
    # (since the stack grows downward), the number represents
    # how many bytes we're allocating. This number depends on
    # how much space we actually need.

    # Another note on this line is, if we're in a leaf function
    # (it doesn't call any other functions), we get 128 bytes of
    # stack frame space without having to sub from rsp (known as
    # the red zone).
    # For this reason, the below instruction is superfluous
    # and can be commented out
    
    # sub rsp, 12

    # Now we move the values in. Here we move 8 bytes down
    # from the base pointer (which does not change) to put in
    # the first value, which is an qword-size pointer.
    # In other words, we're working with bytes -8 thru 0.
    # Logic to receive values onto the call stack from the caller:
    mov QWORD PTR -8[rbp], rdi
    mov DWORD PTR -12[rbp], esi

    # Logic to place these values correctly for the syscall:
    mov rsi, QWORD PTR -8[rbp]
    mov edx, DWORD PTR -12[rbp]
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
