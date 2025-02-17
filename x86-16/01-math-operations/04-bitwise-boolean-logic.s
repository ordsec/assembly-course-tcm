;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Bitwise boolean logic ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Bitwise means the operation is performed on each vertically matching bit
; of the values we're working with.
; This is easier to visualize using binary. E.g.

; 1011 AND
; 0101
; --------
; 0001

start:

;;;;; AND ;;;;;

; If both bits are 1, the result is 1. Otherwise, it's 0.
; Think of it as multiplication. You'll only get 1 if both bits are 1,
; otherwise you'll get 0.

mov AL, 0b1011
mov AH, 0b0101
and AL, AH                  ; As always, the destination is where the result goes.
                            ; AL & AH = 0b0001, stored in AL.

;;;;; OR ;;;;;

; Here, if either of the bits are 1, the result is 1. Otherwise, it's 0.
; Think of it as addition. You'll get 1 unless both bits are 0.

mov AL, 0b1001
mov AH, 0b0101
or AL, AH                   ; AL | AH = 0b1101, stored in AL


;;;;; NOT ;;;;;

; This one runs on a single operand and negates it - in other words,
; it flips the bits of the operand. Within any set of bits (a byte, a word,
; a dword, etc.), NOT basically goes max_in_set - current_value, e.g.
; NOT 28 = NOT 0b00011100 = 0b11111111 - 0b00011100 = 0b11100011 = 228

mov AL, 0b00011100
not AL                      ; !AL - AL is now 0b11100011 or 0xe3


;;;;; XOR ;;;;;

; Exclusive OR only allows one of the bits to be 1 at a time. In other words,
; if either of the inputs is 1, the result is 1. Otherwise, it's 0.
; XOR is a great way to zero out a register withohut wasting cycles because
; XOR'ing two values that are the same will always return 0.

mov AL, 0b1011
mov AH, 0b0001
xor AL, AH                  ; AL XOR AH is 1010, stored in AL