# # # # # # # # # # # #
# # # Read syscall # # #
# # # # # # # # # # # #

    .file       "helloworld.c"
    .intel_syntax noprefix
    # Set max input legnth to 100, this can be used
    # elsewhere in the code
    .equ max_input_length, 100
    .text
    .section    .rodata
message:
    .string "Please input a short message: "
    # This calculates the length of the message 
    # by going back however many bytes the message is
    # and another byte
    .equ length, .-message - 1

    # Create a section for data that can be modified, 
    # as opposed to .rodata, which is read-only.
    .section .data
input:
    # A very basic way to allocate memory - we're now
    # using 100 bytes of memory for the input,
    # based on the max_input_length value declared above.
    # The allocated space is filled with zeros.
    .zero max_input_length
    .text
    .globl  main
    .type   main, @function
main:
    push rbp
    mov rbp, rsp

    # Handle prompt output via write syscall
    mov rax, 0x01               # Syscall code for write 
    mov rdi, 1                  # File descriptor is stdout (1)
    lea rsi, message[rip]       # ptr to the beginning of message
    mov rdx, length             # length of string to print
    syscall

    # Check if syscall wrote bytes (its return value is the 
    # number of bytes it wrote)
    cmp rax, 0    
    # -1 will be returned if there is an error, so return that          
    jl return

    # Handle user input via read syscall
    mov rax, 0                  # Syscall code for read is 0
    mov rdi, 0                  # File descriptor is stdin (0)
    lea rsi, input[rip]         # RIP-relative ptr to buffer
    mov rdx, max_input_length
    syscall

    # According to the man page, on success the read syscall
    # returns the number of bytes written. We can use that
    # to output the message that was entered.
    mov rdx, rax                # Capture the length of input
    mov rax, 0x01               # Write syscall code
    mov rdi, 1                  # fd is stdout
    lea rsi, input[rip]
    syscall

    # Check if bytes were written
    cmp rax, 0
    jl return

    # Otherwise, zero out rax and return
    xor rax, rax

    return:
    # Function epilogue
    mov rsp, rbp
    pop rbp
    ret
    
    .size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
