;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Functions continued ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; The two functions from 00-functions-1, calc_len and print_str,
; can be merged into one.

db [0x1, 0xf]                     
string1: db "Hello," db 0x00
db [0x2, 0xf]
string2: db "world!" db 0x00

def print_str {
    ; Retrieve the offset of stringN from the stack into SI
    ; (for lods)
    pop SI  
    ; BP also needs to be set to the offset of stringN, 
    ; so we can simply move that value into BP from SI.                   
    mov BP, SI            
    ; Then carry on with the logic.      
    xor CX, CX
    count_bytes:
    lods byte
    cmp AL, 0x00
    je return
    inc CX
    jmp count_bytes

    ; Once the calculation of the string length is finished,
    ; we can go ahead and print it. This requires that 
    ; BP is set to the beginning of the string.
    return:
    xor AH, AH
    mov AH, 0x13
    int 0x10
    ret
}

start:
; Set up for the first string
; mov SI, offset string1
; mov BP, offset string1
; call print_str

; Set up for the second string
; mov SI, offset string2
; mov BP, offset string2
; call print_str

; Above is a completely valid way to call the simple function
; print_str. However, there are many scenarios when a function
; needs to operate on more data than we can pack into registers,
; either due to their size or due to the number of arguments.
; This is where the stack comes in - in the function, we just 
; need to remember to pull them off the stack.

; Pushing BX below (and popping it off the stack above in the 
; function) is how arguments are passed into a function!

mov BX, offset string1              ; BX <- beginning of string1
push BX                             ; BX -> stack
call print_str

mov BX, offset string2              ; BX <- beginning of string2
push BX                             ; BX -> stack
call print_str