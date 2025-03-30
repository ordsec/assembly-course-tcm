.intel_syntax noprefix

.text
.globl _start

_start:
    mov rcx, 0x2020204f4c4c4548     # set up to push "hello", account for LE
    push rcx
    xor rax, rax
    mov al, 1                       # syscall: 1 (write to screen), using AL only
    mov rdi, rax                    # fd: stdout (rax is already set to 1)
    mov rsi, rsp                    # sp points where the "hello" string is
    xor rdx, rdx
    mov dl, 5                       # length of "hello"
    syscall
