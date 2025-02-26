# # # # # # # # # # # # #
# # # Write syscall # # #
# # # # # # # # # # # # #

    .file       "helloworld.c"
    .intel_syntax noprefix
    .text
    .section    .rodata
message:
    .string "Hello, world!\n"
    # This calculates the length of the message 
    # by going back however many bytes the message is
    # and another byte
    .equ length, .-message - 1
    .text
    .globl  main
    .type   main, @function
main:
    # Function prologue starts
    push rbp
    mov rbp, rsp

    # The function itself
    mov rax, 0x01           # Write syscall's code is 1

    # The file descriptor, i.e. a handle either to a file
    # or to stdin/stdout. In this case, we need stdout,
    # for which the code is also 1.
    mov rdi, 1
    lea rsi, message[rip]   # ptr to the beginning of message
    mov rdx, length         # length of string to print
    syscall

    # check if syscall wrote bytes (its return value is the 
    # number of bytes it wrote)
    cmp rax, 0    
    # -1 will be returned if there is an error, so return that          
    jl return
    # otherwise, zero out rax and return
    xor rax, rax

    return:
    # Function epilogue
    mov rsp, rbp
    pop rbp
    ret
    
    .size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
