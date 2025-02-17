;;;;;;;;;;;;;;;;;;;;;
;;;;; The stack ;;;;;
;;;;;;;;;;;;;;;;;;;;;

; When we put stuff into memory, we have to keep track of it: pointers,
; labels, allocations, etc.

; The stack is a great way to preserve the contents of registers in memory
; and retrieve them without having to use those pesky memory addresses. The downside
; is that we can only "see" one thing at any given time because, while multiple
; things can be stored, only the top of the stack can be retrieved. The order is
; LIFO: Last In First Out. 

; The stack grows downward. If we push numbers 1, 2, 3 onto the stack in this order,
; The lowest address will have the top of the stack, and that's where the SP 
; (Stack Pointer) will be located. As the stack grows, the SP is decremented.

; 0x0FFFF ------- 1
; 0x0FFFE ------- 2
; 0x0FFFD ------- 3 <--- SP

; When we pop from the stack, the SP gets incremented, so after calling `pop <register>`
; (i.e. pop from the stack into <register>), the SP will point to 0xFFFE, which is
; the new top of the stack.

; Pushing a word will occupy two bytes, so with the rules of endianness the LSB
; will be first and the SP will be decremented by 0x2.

number: dw 0x5678

start:
mov AX, 0xabcd
; Pushing and popping happens from and back to registers
push AX                     ; SP now at 0xFFFE
push AX                     ; SP now at 0xFFFC

; The SP will increment, but the data in memory isn't zeroed out!
; We're just no longer pointing to it, it can just get overwritten. 
pop BX                      ; SP now at 0xFFFE

; Writing to a memory address is ALWAYS destructive, this includes
; the stack, which will just keep growing downwards.
mov CX, 0x1234
push CX                     ; SP now at 0xFFFC
mov word [0xfffa], 0x6789   ; 89h at 0xFFFB, 67h at 0xFFFA 
push CX                     ; The last two bytes are overwritten!