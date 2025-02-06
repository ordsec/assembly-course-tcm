;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Jump instructions ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; There are many different types of jumps, with a few that are
; quite common.

; In the emulator, we can only jump to a label. With a real 8086
; processor, we can jump to a memory address as well.

;;;;; jmp

; start:
; mov AH, 1

; jmp is unconditional - it doesn't depend on any flags
; jmp after2

; This will not execute as we're jumping over this part
; mov AH, 2

; This will execute
; after2:
; mov AH, 3

; The rest of the jumps are conditional - they'll be performed
; if certain flags are set a certain way, otherwise they'll 
; be ignored and the program will continue with the next 
; instruction.

; All jumps: 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ja, jnbe, jae, jnb, jb, jnae, jbe, jna, jc, je,     ;
; jz, jg, jnle, jge, jnl, jl, jnge, jle, jng, jnc,    ;
; jne, jnz, jno, jnp, jpo, jns, jo, jp, jpe, js, jcxz ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; The lettering has a convention:
;   - a is "above"
;   - b is "below"
;   - e is "equal"
;   - n is "not"
;   - g is "greater than"
;   - l is "less than"

; Jumps based on specific flags being set:
;   - c is "if carry is set"
;   - o is "if overflow is set"
;   - p is "if parity is set"
;   - z is "if zero is set"

; The difference between "above" and "greater than" is,
; "above" and "below" are to be used with UNSIGNED numbers
; whereas the "greater than" and "less than" are to be used
; with SIGNED numbers.


; The following program accepts a number from 0-9 and makes
; an output based on how the number compares to 5

message1: db "Please enter a number (0-9): "
null1: db 0x00               ; Null terminator immediately following the message
message2: db "The number you've entered is greater than 5!"
null2: db 0x00
message3: db "The number you've entered is in fact 5!"
null3: db 0x00
message4: db "The number you've entered is less than 5!"
null4: db 0x00

start:

;;;;; Print the prompt
mov AH, 0x13                 ; int 0x10 subfunction to print multiple chars
mov CX, offset null1         ; Get the number of characters to print. Find the null,
sub CX, offset message1      ; subtract the the offset where the message is from it.
mov BP, offset message1      ; Point the BP at the beginning of the message.
int 0x10

;;;;; Accept user input
xor AH, AH
mov AH, 0x1                 ; int 0x21 subfunction to accept one char
int 0x21                    ; input goes into AL

; The input will be in ASCII. Numbers 0-9 = ASCII 0x30-0x39.
; Ergo, to get the actual number, we want to subtract 30
; from what's currently the ASCII value.
sub AL, 0x30

;;;;; Make the comparison, jump based on it
cmp AL, 5
ja printover5               ; Jump to printover5 if > 5
je print5                   ; Jump to print5 if num == 5
xor AH, AH                  ; Else: number is less than 5
mov AH, 0x13
mov CX, offset null4
sub CX, offset message4
mov BP, offset message4
int 0x10
jmp end
mov DX, 0xffff

;;;;; Print the message if the number is more than 5
printover5:
xor AH, AH
mov AH, 0x13
mov CX, offset null2
sub CX, offset message2
mov BP, offset message2
int 0x10
jmp end                     ; We need to jump to the end because
                            ; otherwise the following instructions
                            ; prior to `end` will execute.

;;;;; Print the message if the number is 5
print5:
xor AH, AH
mov AH, 0x13
mov CX, offset null3
sub CX, offset message3
mov BP, offset message3
int 0x10

end:                        
xor AX, AX                  ; Set AX to 0 - all is well that ends well