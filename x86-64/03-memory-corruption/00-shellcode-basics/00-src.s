.intel_syntax noprefix

.text
.globl _start

_start:
    mov rcx, 0x004f4c4c4548     # set up to push "hello", account for LE
    push rcx
    mov rax, 1                  # syscall: 1 (write to screen)
    mov rdi, 1                  # fd: stdout
    mov rsi, rsp                # sp points where the "hello" string is
    mov rdx, 5                  # length of "hello"
    syscall
