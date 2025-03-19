# This version is with args being passed in via the stack.

.intel_syntax noprefix

# Declare the data
.text
.section .rodata

.type message,       @object
message:
    .string "Hello, world!\n"

.align 4
.type length,        @object
.size length,        4

length:
    .long            .-message - 1

# Declare the printstr function
.text
.globl    printstr
.type     printstr, @function

# printstr function logic

# printstr will be receiving two arguments
# (pointer to where string starts and its length)

# print(char *strToPrint, int length)

# In this version, we're pushing all the args on the stack
# and receiving them inside the printstr function

# Call order sequence: rdi, rsi, rdx, rcx, r8, r9, stack
# except now we're just skipping directly to the stack
printstr:
    push rbp
    mov rbp, rsp

    # The args are pushed onto the stack in main, so we need to
    # receive them here.

    # We need a 16-byte call stack here because we're working
    # with entire registers 
    sub rsp, 16

    # We can't move memory to memory, so we have to store
    # the pushed values first. Second argument:
    mov rax, QWORD PTR 16[rbp]
    mov QWORD PTR -8[rbp], rax

    # First argument:
    mov rax, QWORD PTR 24[rbp]
    mov QWORD PTR -16[rbp], rax

    # Above, 16 and 24 off of rbp are where the values pushed
    # in main will reside. They're not 0 and 8 because there are
    # two things already there: the return address for the caller
    # (which gets pushed automatically as part of the `call` instruction)
    # and the caller's BP. From the standpoint of the callee (the function
    # we're in), the BP is at 0, so anything from before is on the + side
    # and anything allocated in the local stack from is on the - side. 

    # Finally, retrieve the args from memory for the syscall:
    mov rsi, QWORD PTR -8[rbp]
    mov rdx, QWORD PTR -16[rbp]
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

    # Hypothetical: what if we had to use local variables
    # in main and then call another function? To comply
    # with the ABI, we have to subtract multiples of 16
    # from the SP so that the stack is aligned.
    # sub rsp, 16
    # mov QWORD PTR -8[rbp], 0x42069

    # Args have to be pushed in the reverse order. 
    # Note that we can use partial registers, but only
    # a full 8-byte register can be pushed onto the stack.
    mov esi, DWORD PTR length[rip]      # Pass 2nd arg
    push rsi
    lea rdi, message[rip]               # Pass 1st arg
    push rdi
    call printstr

    # If we do some other stuff here, hypothetically, 
    # we would have to close the local stack frame. 
    # This right here is basic garbage collection.

    # add rsp, 16

    mov rsp, rbp
    pop rbp
    ret

    .size       main, .-main
    .section    .note.GNU-stack,"",@progbits
