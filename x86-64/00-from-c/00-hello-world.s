	.file	"00-hello-world.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"Hello, world!"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	lea	rax, .LC0[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	pop	rbp
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
