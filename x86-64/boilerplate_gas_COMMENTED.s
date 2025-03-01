# GAS boilerplate with comments, for educational purposes

.intel_syntax noprefix  # Use Intel syntax instead of default AT&T syntax

.text                   # Define the code section (executable instructions)

.globl main             # Make 'main' globally accessible (required for linking)
.type main, @function   # Declare 'main' as a function

main:
    push rbp            # Save the old base pointer (callee-saved register)
    mov rbp, rsp        # Set up the new stack frame (align RBP with RSP)

    xor rax, rax        # Set RAX to 0 (common convention for returning 0)

    mov rsp, rbp        # Restore stack pointer (undo local variable space, if any)
    pop rbp             # Restore old base pointer

    ret                 # Return from function

    .size main, .-main  # Define function size (main's size = current address - start of main)
    .section .note.GNU-stack,"",@progbits  # Mark section as non-executable (security feature)
