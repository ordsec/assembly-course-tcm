;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Functions in assembly! ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Also referred to procedures or subroutines, functions
; are a way to reuse code in a dynamic way, using 
; different inputs (arguments).

; In 8086, functions have to be declared before the `start`.
; The syntax is as follows. `ret` is not always necessary, but
; it's a good practice.

; def demo_func {
;     mov AH, 2                     ; do the stuff
;     ret                           ; go back to the next instruction after the call
; }

; start:
; mov AH, 1                         ; AH <- 1
; call demo_func                    ; AH <- 2 as described in demo_func
; mov AH, 3                         ; AH <- 3

; Time for something more useful. Here's a function that 
; calculates the length of a string stored in memory for
; printing purposes. 

; In this assembler, data is still at the top, before any
; function definitions.

db [0x1, 0xf]                     
string1: db "Hello," db 0x00
db [0x2, 0xf]
string2: db "world!" db 0x00

def calc_len {
    ; We can't accept arguments in assembly - oh well.
    ; Instead, we can use registers/stack.
    xor CX, CX                      ; Clear CX for inc counter
    count_bytes:                    ; Enter the loop
    lods byte                       ; Load a byte
    cmp AL, 0x00                    ; Check if it's the null
    je return                       ; If so, return from the func
    inc CX                          ; Otherwise, increment the counter
    jmp count_bytes                 ; and go back

    return:
    ret
}

def print_str {
    xor AH, AH
    mov AH, 0x13
    int 0x10
    ret
}

start:
; We need to set up SI before we call the function since
; it features lods. It can be done before the call - 
; nothing will happen to SI when the function is called.
mov SI, offset string1
call calc_len
; With all these function calls, we have to keep track of
; registers even more. What is CX currently? It's the length
; of string1.
mov BP, offset string1
call print_str

mov SI, offset string2
call calc_len
mov BP, offset string2
call print_str

;...continued in 01-functions-2.s