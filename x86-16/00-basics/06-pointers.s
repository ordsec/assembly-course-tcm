;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Pointers in assembly ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

db [0x01, 0xa]           ; Prep step, put 10 1's at the beginning of memory.
number: dw 0x1234
string: db "I am a string!"

; A pointer is an object that stores a memory address.
; It's an object because we don't have variables in assembly - as opposed to C/C++,
; where a pointer is a __variable__ that stores a memory address.
; In assembly, a memory address can be stored either in a register or in memory,
; using one memory location to point to another one. It's up to us to keep track of what's
; in memory or registers!

; There are registers that are only meant to hold memory addresses:
; the Stack Pointer (SP), the Base Pointer (BP), the Source Index (SI),
; and the Destination Index (DI).

start:
; Normal stuff, moving 0xabcd into memory at the offset of 0x02,
; using the square bracket syntax that tells the assembler that
; we're dealing with a memory address and not with a simple value.
mov word [0x02], 0xabcd
mov BX, 0x02

; Treat the contents of BX as a memory address rather than as a literal value.
; Put the value at that address into CX.
; This is known as DEREFERENCING A POINTER, and the following syntax is used.
mov CX, word [BX] ; Equivalent to mov CX, word [0x02]

; IMPORTANT: only the BX register can be dereferenced like this in 8086, 
; trying to do it with other registers will cause an error. Other registers can be
; used to store memory addresses (which are just hex numbers), but they can't
; be dereferenced this way.

; There are other ways to interact with addresses or get the address of a label 
; or a piece of data. One of them is the lea (Load Effective Address) instruction.

; lea allows us to load the address of an operand. 
; Get the address of the 'number' label:
lea AX, word number

; The following pretty much does the same thing - we're just dereferencing 
; the offset of the 'number' label
mov DX, offset number

; This isn't the true power of lea though. We can use math operations to shift
; around the memory address and dereference specific bytes anywhere in it. 
; This is great for moving around strings (which are arrays of characters).
; lea AX, word number + 1

; Another way to do the same because lea doesn't work correctly in the emulator.
; Move the start of the string into BX:
mov BX, offset string

; Move byte 3 of the string into AX, using the starting address of the string
; that is already in BX. What this says is, "put in AX what you see 
; at the beginning of the string via the offset, PLUS three bytes over.
mov AX, word [BX, 3]